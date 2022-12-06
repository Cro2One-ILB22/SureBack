//
//  MerchantRejectStoryFormViewController.swift
//  SureBack
//
//  Created by Tubagus Adhitya Permana on 28/11/22.
//

import UIKit

class MerchantRejectStoryFormViewController: CommonSheetViewController {
    var id: Int?
    private let apiRequest = RequestFunction()
    var customerStoryViewModel = CustomerStoryViewModel.shared
    let question1TextLabel: UILabel = {
        let label = UILabel()
        label.text = "What's wrong with that Story?"
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let suggestMessage1: SuggestMessageCardButton = {
        let button = SuggestMessageCardButton()
        button.setTitle("contains inappropriate content", for: .normal)
        return button
    }()
    let suggestMessage2: SuggestMessageCardButton = {
        let button = SuggestMessageCardButton()
        button.setTitle("contains SARA elements", for: .normal)
        return button
    }()
    let suggestMessage3: SuggestMessageCardButton = {
        let button = SuggestMessageCardButton()
        button.setTitle("not relevant to my business", for: .normal)
        return button
    }()
    let suggestMessage4: SuggestMessageCardButton = {
        let button = SuggestMessageCardButton()
        button.setTitle("contains inappropriate content", for: .normal)
        return button
    }()
    let suggestMessage5: SuggestMessageCardButton = {
        let button = SuggestMessageCardButton()
        button.setTitle("has poor image/video content quality", for: .normal)
        return button
    }()
    let question2TextLabel: UILabel = {
        let label = UILabel()
        label.text = "Any words for your customer?"
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let messageField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Please say something polite"
        textField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        textField.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width - 60).isActive = true
        return textField
    }()
    let sendToCustButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .tealishGreen
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Send to Customer", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.layer.cornerRadius = 10
        return button
    }()
    var snackBarMessage: SnackBarMessage?
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = "Reason for Rejection"
        view.backgroundColor = .porcelain
        setupLayout()
        suggestMessage1.addTarget(self, action: #selector(suggestMessageAction), for: .touchUpInside)
        suggestMessage2.addTarget(self, action: #selector(suggestMessageAction), for: .touchUpInside)
        suggestMessage3.addTarget(self, action: #selector(suggestMessageAction), for: .touchUpInside)
        suggestMessage4.addTarget(self, action: #selector(suggestMessageAction), for: .touchUpInside)
        suggestMessage5.addTarget(self, action: #selector(suggestMessageAction), for: .touchUpInside)
        sendToCustButton.addTarget(self, action: #selector(sendToCustAction), for: .touchUpInside)
        snackBarMessage = SnackBarMessage()
    }
    @objc func suggestMessageAction(sender: UIButton) {
        messageField.text = ""
        switch(sender.currentTitle) {
        case suggestMessage1.currentTitle:
            UIPasteboard.general.string = suggestMessage1.currentTitle
        case suggestMessage2.currentTitle:
            UIPasteboard.general.string = suggestMessage2.currentTitle
        case suggestMessage3.currentTitle:
            UIPasteboard.general.string = suggestMessage3.currentTitle
        case suggestMessage4.currentTitle:
            UIPasteboard.general.string = suggestMessage4.currentTitle
        case suggestMessage5.currentTitle:
            UIPasteboard.general.string = suggestMessage5.currentTitle
        case .none:
            return
        case .some:
            return
        }
        if let myString = UIPasteboard.general.string {
            messageField.insertText(myString)
        }
    }
    @objc func sendToCustAction() {
        guard let note = messageField.text else {return}
        guard let id = id else {return}
        apiRequest.approveStory(false, id: id, note: note) {[weak self] _, statusCode in
            guard let self = self else {return}
            guard let statusCode = statusCode else {return}
            if statusCode != 200 {
                self.snackBarMessage?.showResponseMessage(statusCode: statusCode)
                return
            }
            self.customerStoryViewModel.removeWhere(id: id)
            self.dismiss(animated: true)
            self.navigationController?.popViewController(animated: true)
        }
    }
}
