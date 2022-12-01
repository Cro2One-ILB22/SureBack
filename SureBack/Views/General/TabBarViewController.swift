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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .porcelain

        // proses nonton perubahan seperti didSet
        viewModel.userSubject.subscribe(onNext: { user in // onNext : kalo update, next
            self.dashboardVC?.user = user
            self.qrVC?.user = user
        }).disposed(by: disposeBag)
        request.getUserInfo { [self] data in
            switch data {
            case let .success(result):
                self.initAndStartUpdatingLocation()
                do {
                    viewModel.userSubject.onNext(result)
                    print("login success")

                    if viewModel.user?.roles![1] == "customer" {
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

                        let qrVC = ScanQrViewController()
//                        qrVC.user = user
                        let navQR = UINavigationController(rootViewController: qrVC)
                        navQR.tabBarItem = UITabBarItem(title: "QR", image: UIImage(named: "qrcode.viewfinder"), tag: 1)

                        let profileVC = MerchantProfileViewController()
//                        profileVC.user = user
                        let navProfile = UINavigationController(rootViewController: profileVC)
                        navProfile.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "person.crop.circle"), tag: 1)
                        setViewControllers([navDashboard, navQR, navProfile], animated: false)
                    }
                } catch let error as NSError {
                    print(error.description)
                }
            case let .failure(error):
                print(error)
                print("failed to login")
                if error.responseCode == 401 {
                    KeychainHelper.standard.delete(key: .accessToken)
                    let loginVC = LoginViewController()
                    let navLogin = UINavigationController(rootViewController: loginVC)
                    navLogin.modalPresentationStyle = .fullScreen
                    navigationController?.pushViewController(navLogin, animated: true)
//                    present(navLogin, animated: true, completion: nil)
                }
            }
        }
    }

//    init() {
//        super.init(nibName: nil, bundle: nil)
//        self.user = viewModel.user
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
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
