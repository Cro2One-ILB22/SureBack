//
//  TabBarViewController.swift
//  SureBack
//
//  Created by Tubagus Adhitya Permana on 07/11/22.
//

import CoreLocation
import RxCocoa
import RxSwift
import UIKit

class TabBarViewController: UITabBarController {
    private let locationManager = CLLocationManager()
    private var currentLocation: CLLocationCoordinate2D?
    private let locationSubject = ReplaySubject<CLLocationCoordinate2D>.create(bufferSize: 1)
    
    let request = RequestFunction()
    
    let viewModel = UserViewModel.shared
    
    var disposeBag = DisposeBag()
    
    var dashboardVC: CustomerDashboardViewController?
    var qrVC: CustomerQrCodeViewController?
    var profileVC: CustomerProfileViewController?
//    var selectedRole: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .porcelain
        self.setValue(tabBar, forKey: "tabBar")
        // proses nonton perubahan seperti didSet
        viewModel.userSubject.subscribe(onNext: { [weak self] user in // onNext : kalo update, next
            self?.dashboardVC?.user = user
            self?.qrVC?.user = user
        }).disposed(by: disposeBag)
        request.getUserInfo { [self] data in
            switch data {
            case let .success(result):
                self.initAndStartUpdatingLocation()
                do {
                    viewModel.userSubject.onNext(result)
                    print("login success")
                    let role = viewModel.user?.roles![1]
                    if role == "customer" {
                        dashboardVC = CustomerDashboardViewController(locationSubject: locationSubject)
                        dashboardVC?.user = viewModel.user
                        let navDashboard = UINavigationController(rootViewController: dashboardVC!)
                        navDashboard.tabBarItem = UITabBarItem(title: "Dashboard", image: UIImage(named: "list.dash.header.rectangle"), tag: 1)
                        
                        qrVC = CustomerQrCodeViewController()
                        qrVC?.user = viewModel.user
                        let navQR = UINavigationController(rootViewController: qrVC!)
                        navQR.tabBarItem = UITabBarItem(title: "QR", image: UIImage(named: "qrcode.viewfinder"), tag: 1)
                        
                        profileVC = CustomerProfileViewController()
                        let navProfile = UINavigationController(rootViewController: profileVC!)
                        navProfile.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "person.crop.circle"), tag: 1)
                        setViewControllers([navDashboard, navQR, navProfile], animated: false)
                    } else {
                        let dashboardVC = MerchantDashboardViewController()
                        dashboardVC.user = viewModel.user
                        let navDashboard = UINavigationController(rootViewController: dashboardVC)
                        navDashboard.tabBarItem = UITabBarItem(title: "Dashboard", image: UIImage(named: "list.dash.header.rectangle"), tag: 1)
                        
                        let scanQR = MerchantScanQRViewController()
                        let navQR = UINavigationController(rootViewController: scanQR)
                        navQR.tabBarItem = UITabBarItem(title: "QR", image: UIImage(named: "qrcode.viewfinder"), tag: 1)
                        
                        let profileVC = MerchantProfileViewController()
                        let navProfile = UINavigationController(rootViewController: profileVC)
                        navProfile.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "person.crop.circle"), tag: 1)
                        setViewControllers([navDashboard, navQR, navProfile], animated: false)
                    }
//                    selectedRole = role
//                    setupMiddleButton()
                } catch let error as NSError {
                    print(error.description)
                }
            case let .failure(error):
                print(error)
                print("failed to login")
                if error.responseCode == 401 {
                    KeychainHelper.standard.delete(key: .accessToken)
                    let loginVC = LoginViewController()
                    let appDelegate = UIApplication.shared.delegate as? AppDelegate
                    appDelegate?.window?.rootViewController = UINavigationController(rootViewController: IsLoginViewController())
                    //                    present(navLogin, animated: true, completion: nil)
                }
            }
        }
    }
//    func setupMiddleButton() {
//        let menuButton = UIButton(frame: CGRect(x: 0, y: 0, width: 64, height: 64))
//        var menuButtonFrame = menuButton.frame
//        let isNotFullScreenDevice = tabBar.frame.height <= 49.0
//        let minus = isNotFullScreenDevice ? CGFloat(20) : CGFloat(50)
//        menuButtonFrame.origin.y = view.bounds.height - menuButtonFrame.height - minus
//        menuButtonFrame.origin.x = view.bounds.width/2 - menuButtonFrame.size.width/2
//        menuButton.frame = menuButtonFrame
//
//        menuButton.backgroundColor = .tealishGreen
//        menuButton.layer.cornerRadius = menuButtonFrame.height/2
//        view.addSubview(menuButton)
//        print("heigh :", tabBar.frame.height)
//
//        menuButton.setImage(UIImage(named: "qr.tabbar"), for: .normal)
//        menuButton.addTarget(self, action: #selector(menuQRButtonAction(sender:)), for: .touchUpInside)
//
//        view.layoutIfNeeded()
//    }
//    @objc private func menuQRButtonAction(sender: UIButton) {
//        var viewController: UIViewController?
//        if selectedRole == "customer" {
//            viewController = CustomerQrCodeViewController()
//        } else {
//            viewController = ScanQrViewController()
//        }
//        guard let viewController = viewController else {return}
//        navigationController?.pushViewController(viewController, animated: true)
//    }
    deinit {
        locationManager.stopUpdatingLocation()
    }
}

extension TabBarViewController: CLLocationManagerDelegate {
    func initAndStartUpdatingLocation() {
        DispatchQueue.global(qos: .utility).async {
            self.locationManager.requestWhenInUseAuthorization()
            if CLLocationManager.locationServicesEnabled() {
                self.locationManager.delegate = self
                self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
                self.locationManager.startUpdatingLocation()
            }
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue)")
        guard locValue.latitude != currentLocation?.latitude,
              locValue.longitude != currentLocation?.longitude
        else { return }
        currentLocation = locValue
        locationSubject.onNext(locValue)
        guard let roles = viewModel.user?.roles,
              roles.contains("merchant")
        else { return }
        request.updateMerchantLocation(locationCoordinate: (locValue.latitude, locValue.longitude))
    }
}


