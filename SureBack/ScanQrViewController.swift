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

    let instruction1Label: UILabel = {
        let label = UILabel()
        label.text = "Please point the scanner at the"
        label.font = UIFont.systemFont(ofSize: 15)
        label.sizeToFit()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let instruction2Label: UILabel = {
        let label = UILabel()
        label.text = "Customer Identity QR"
        label.font = UIFont.systemFont(ofSize: 17)
        label.sizeToFit()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.black

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
        previewLayer.frame = view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)

        DispatchQueue.global(qos: .background).async {
            self.captureSession.startRunning()
        }

        setupInstruction1()
        setupInstruction2()
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
            switch response {
            case .success:
                self?.navigationController?.pushViewController(MerchantGenerateTokenFormViewController(customerId: customerId), animated: true)
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
    private func setupInstruction1() {
        view.addSubview(instruction1Label)
        instruction1Label.setTopAnchorConstraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50)
        instruction1Label.setLeftAnchorConstraint(equalTo: view.leftAnchor)
        instruction1Label.setRightAnchorConstraint(equalTo: view.rightAnchor)
    }

    private func setupInstruction2() {
        view.addSubview(instruction2Label)
        instruction2Label.setTopAnchorConstraint(equalTo: instruction1Label.bottomAnchor,constant: 5)
        instruction2Label.setLeftAnchorConstraint(equalTo: view.leftAnchor)
        instruction2Label.setRightAnchorConstraint(equalTo: view.rightAnchor)
    }
}
