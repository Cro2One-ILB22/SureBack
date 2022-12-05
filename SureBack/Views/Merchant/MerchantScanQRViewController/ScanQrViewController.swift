//
//  ScannerQrViewController.swift
//  SureBack
//
//  Created by Ditha Nurcahya Avianty on 27/10/22.
//

import AVFoundation
import UIKit

class ScanQrViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    let apiRequest = RequestFunction()
    
    weak var delegate: SendDataDelegate?
    let instructionLabel: UILabel = {
        let label = UILabel()
        label.text = "Please point the scanner at the Customer’s QR into generate token."
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.sizeToFit()
        label.textAlignment = .center
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let arrowBackImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "arrow.backward.circle.fill")
        image.isUserInteractionEnabled = true
        return image
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.setHidesBackButton(true, animated: true)
        
        captureSession = AVCaptureSession()

        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput

        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }

        if captureSession.canAddInput(videoInput) {
            captureSession.addInput(videoInput)
        } else {
            failed()
            return
        }

        let metadataOutput = AVCaptureMetadataOutput()

        if captureSession.canAddOutput(metadataOutput) {
            captureSession.addOutput(metadataOutput)

            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr]
        } else {
            failed()
            return
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.cornerRadius = 10
        previewLayer.frame = CGRect(x: view.frame.size.width / 23, y: view.frame.size.height / 4, width: 358, height: 568)
        previewLayer.frame = view.bounds
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)
        
        DispatchQueue.global(qos: .background).async {
            self.captureSession.startRunning()
        }
        arrowBackImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapArrowBack)))
        setuplayout()
    }
    @objc func didTapArrowBack() {
        print("tapped")
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers
        tabBarController?.selectedIndex = 0
        navigationController?.popToViewController(viewControllers.first!, animated: true)
    }
    func failed() {
        let ac = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        captureSession = nil
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if captureSession?.isRunning == false {
            DispatchQueue.global(qos: .background).async {
                self.captureSession.startRunning()
            }
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if captureSession?.isRunning == true {
            captureSession.stopRunning()
        }
    }
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        captureSession.stopRunning()
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            found(userData: stringValue)
        }
    }
    func found(userData: String) {
        print("scanQR result: \(userData)")
        guard let customerId = Int(userData) else { return }
        apiRequest.responseQRPurchase(customerId: customerId) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success:
                let totalPurchaseVC = TotalPurchaseFormViewController(presenter: self, customerId: customerId)
                totalPurchaseVC.hidesBottomBarWhenPushed = true
                self.present(totalPurchaseVC, animated: true)
            case .failure(let failure):
                print(failure)
            }
        }
        delegate?.passData(data: userData)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
}

extension ScanQrViewController {
    func setuplayout() {
//        setupTitle()
        setupBackButton()
        setupInstruction()
        createScanningFrame()
        createScanningIndicator()
    }
//    private func setupTitle() {
//        view.addSubview(titleLabel)
//        titleLabel.setTopAnchorConstraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16)
//        titleLabel.setLeadingAnchorConstraint(equalTo: view.leadingAnchor, constant: 16)
//        titleLabel.setTrailingAnchorConstraint(equalTo: view.trailingAnchor, constant: -16)
//    }
    private func setupBackButton() {
        view.addSubview(arrowBackImage)
        arrowBackImage.translatesAutoresizingMaskIntoConstraints = false
        arrowBackImage.setWidthAnchorConstraint(equalToConstant: 40)
        arrowBackImage.setHeightAnchorConstraint(equalToConstant: 40)
        arrowBackImage.setTopAnchorConstraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -10)
        arrowBackImage.setLeadingAnchorConstraint(equalTo: view.leadingAnchor, constant: 16)
//        backImage.setTrailingAnchorConstraint(equalTo: view.trailingAnchor, constant: -16)
    }
    private func setupInstruction() {
        view.addSubview(instructionLabel)
        instructionLabel.setTopAnchorConstraint(equalTo: arrowBackImage.bottomAnchor, constant: 40)
        instructionLabel.setLeadingAnchorConstraint(equalTo: view.leadingAnchor, constant: 40)
        instructionLabel.setTrailingAnchorConstraint(equalTo: view.trailingAnchor, constant: -16)
    }
    func createScanningIndicator() {
        
        let height: CGFloat = 15
        let opacity: Float = 0.4
        let topColor = UIColor.green.withAlphaComponent(0)
        let bottomColor = UIColor.green
        
        let layer = CAGradientLayer()
        layer.colors = [topColor.cgColor, bottomColor.cgColor]
        layer.opacity = opacity
        
        let squareWidth = view.frame.width * 0.6
        let xOffset = view.frame.width * 0.2
        let yOffset = view.frame.midY - (squareWidth / 2)
        layer.frame = CGRect(x: xOffset, y: yOffset, width: squareWidth, height: height)
        
//        self.view.layer.insertSublayer(layer, at: 0)
        self.view.layer.addSublayer(layer)
        
        let initialYPosition = layer.position.y
        let finalYPosition = initialYPosition + squareWidth - height
        let duration: CFTimeInterval = 2
        
        let animation = CABasicAnimation(keyPath: "position.y")
        animation.fromValue = initialYPosition as NSNumber
        animation.toValue = finalYPosition as NSNumber
        animation.duration = duration
        animation.repeatCount = .infinity
        animation.isRemovedOnCompletion = false
        
        layer.add(animation, forKey: nil)
    }
    func createScanningFrame() {
        
        let lineLength: CGFloat = 15
        let squareWidth = view.frame.width * 0.6
        let topLeftPosX = view.frame.width * 0.2
        let topLeftPosY = view.frame.midY - (squareWidth / 2)
        let btmLeftPosY = view.frame.midY + (squareWidth / 2)
        let btmRightPosX = view.frame.midX + (squareWidth / 2)
        let topRightPosX = view.frame.width * 0.8
        
        let path = UIBezierPath()
        
        //top left
        path.move(to: CGPoint(x: topLeftPosX, y: topLeftPosY + lineLength))
        path.addLine(to: CGPoint(x: topLeftPosX, y: topLeftPosY))
        path.addLine(to: CGPoint(x: topLeftPosX + lineLength, y: topLeftPosY))
        
        //bottom left
        path.move(to: CGPoint(x: topLeftPosX, y: btmLeftPosY - lineLength))
        path.addLine(to: CGPoint(x: topLeftPosX, y: btmLeftPosY))
        path.addLine(to: CGPoint(x: topLeftPosX + lineLength, y: btmLeftPosY))
        
        //bottom right
        path.move(to: CGPoint(x: btmRightPosX - lineLength, y: btmLeftPosY))
        path.addLine(to: CGPoint(x: btmRightPosX, y: btmLeftPosY))
        path.addLine(to: CGPoint(x: btmRightPosX, y: btmLeftPosY - lineLength))
        
        //top right
        path.move(to: CGPoint(x: topRightPosX, y: topLeftPosY + lineLength))
        path.addLine(to: CGPoint(x: topRightPosX, y: topLeftPosY))
        path.addLine(to: CGPoint(x: topRightPosX - lineLength, y: topLeftPosY))
        
        let shape = CAShapeLayer()
        shape.path = path.cgPath
        shape.strokeColor = UIColor.white.cgColor
        shape.lineWidth = 3
        shape.fillColor = UIColor.clear.cgColor
        self.view.layer.addSublayer(shape)
    }
}
