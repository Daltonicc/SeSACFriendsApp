//
//  EmailViewController.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/01/25.
//

import UIKit

final class EmailViewController: BaseViewController {

    let mainView = EmailView()
    var viewModel = EmailViewModel()

    override func loadView() {
        super.loadView()
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func setViewConfig() {
        super.setViewConfig()

        mainView.nextButton.addTarget(self, action: #selector(nextButtonClicked(_:)), for: .touchUpInside)
        mainView.emailTextField.mainTextField.delegate = self

    }

    override func textfieldConfig() {
        super.textfieldConfig()

        viewModel.checkValidation(textField: mainView.emailTextField.mainTextField, button: mainView.nextButton)
        mainView.emailTextField.mainTextField.addTarget(self, action: #selector(emailTextFieldDidChange(textfield:)), for: .editingChanged)
    }

    @objc func emailTextFieldDidChange(textfield: UITextField) {

        viewModel.email.value = textfield.text ?? ""

        //최대 길이 제한 안줘도 될듯.
        checkMaxLength(textField: mainView.emailTextField.mainTextField, maxLength: 50)
    }

    @objc func nextButtonClicked(_ sender: UIButton) {

        addPressAnimationToButton(sender) { _ in

            self.viewModel.checkButtonState(button: self.mainView.nextButton)
        }
    }
}

extension EmailViewController: UITextFieldDelegate {

    func checkMaxLength(textField: UITextField, maxLength: Int) {
        if (textField.text?.count ?? 0 > maxLength) {
            textField.deleteBackward()
        }
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {

        mainView.emailTextField.textFieldState = .focus

    }

    func textFieldDidEndEditing(_ textField: UITextField) {

        mainView.emailTextField.textFieldState = .active
    }
}
