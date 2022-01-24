//
//  LoginViewController.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/01/23.
//

import UIKit
import FirebaseAuth
import Toast

final class LoginViewController: BaseViewController {

    weak var coordinator: HomeCoordinator?
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

        viewModel.phoneNumber.bind { phoneNumber in

            let textField = self.mainView.phoneNumberTextField.mainTextField

            if phoneNumber.count > 12 {
                textField.text = phoneNumber.applyPatternOnNumbers(pattern: "###-####-####", replacementCharacter: "#")
            } else {
                textField.text = phoneNumber.applyPatternOnNumbers(pattern: "###-###-####", replacementCharacter: "#")
            }

            if phoneNumber.count >= 12 {
                self.mainView.authButton.buttonState = .fill
            } else {
                self.mainView.authButton.buttonState = .disable
            }

        }
        mainView.phoneNumberTextField.mainTextField.addTarget(self, action: #selector(phoneNumberTextFieldDidChange(textfield:)), for: .editingChanged)
    }

    @objc func phoneNumberTextFieldDidChange(textfield: UITextField) {

        viewModel.phoneNumber.value = textfield.text ?? ""
        checkMaxLength(textField: textfield, maxLength: 13)
    }

    @objc func sendButtonClicked(_ sender: UIButton) {

        addPressAnimationToButton(sender) { _ in

            // 버튼 상태가 fill 아니면 바로 리턴
            guard self.mainView.authButton.buttonState == .fill else {


                return
            }

            PhoneAuthProvider.provider().verifyPhoneNumber("+82) \(self.mainView.phoneNumberTextField.mainTextField.text ?? "")", uiDelegate: nil) { verificationID, error in
                if let error = error {
                     print(error.localizedDescription)
                     return
                }
                LoginViewModel.yourID = verificationID!
            }
            self.coordinator?.showLogin2AuthView()

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
