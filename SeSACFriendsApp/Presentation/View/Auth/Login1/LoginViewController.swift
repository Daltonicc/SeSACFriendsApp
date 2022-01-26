//
//  LoginViewController.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/01/23.
//

import UIKit
import Toast

/*
 구현해야할 것
 1. 인증번호 자동으로 가져오기
 2. 타이머 기능
 3. 상황별 토스트 메세지

 */
final class LoginViewController: BaseViewController {

    weak var coordinator: AuthCoordinator?
    let mainView = LoginView()
    var viewModel = LoginViewModel()

    override func loadView() {
        super.loadView()

        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func setViewConfig() {
        super.setViewConfig()

        mainView.authButton.addTarget(self, action: #selector(sendButtonClicked(_:)), for: .touchUpInside)
        mainView.phoneNumberTextField.mainTextField.delegate = self
    }

    override func textfieldConfig() {
        super.textfieldConfig()

        viewModel.checkAuthValidation(textField: mainView.phoneNumberTextField.mainTextField,
                                      button: mainView.authButton)

        mainView.phoneNumberTextField.mainTextField.addTarget(self, action: #selector(phoneNumberTextFieldDidChange(textfield:)), for: .editingChanged)
    }

    @objc func phoneNumberTextFieldDidChange(textfield: UITextField) {

        viewModel.phoneNumber.value = textfield.text ?? ""
        checkMaxLength(textField: textfield, maxLength: 13)
    }

    @objc func sendButtonClicked(_ sender: UIButton) {

        addPressAnimationToButton(sender) { _ in

            self.viewModel.requestFirebaseAuth(
                button: self.mainView.authButton,
                textField: self.mainView.phoneNumberTextField.mainTextField
            )
        }
    }
}

extension LoginViewController: UITextFieldDelegate {

    func checkMaxLength(textField: UITextField, maxLength: Int) {
        if (textField.text?.count ?? 0 > maxLength) {
            textField.deleteBackward()
        }
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {

        mainView.phoneNumberTextField.textFieldState = .focus
        
    }

    func textFieldDidEndEditing(_ textField: UITextField) {

        mainView.phoneNumberTextField.textFieldState = .active
    }
}
