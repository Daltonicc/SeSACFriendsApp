//
//  LoginViewController.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/01/23.
//

import UIKit
import FirebaseAuth

final class LoginViewController: BaseViewController {

    weak var coordinator: MainCoordinator?
    let mainView = LoginView()
    let viewModel = LoginViewModel()

    override func loadView() {
        super.loadView()

        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        textfieldConfig()
    }

    override func setViewConfig() {
        super.setViewConfig()

        mainView.authButton.addTarget(self, action: #selector(sendButtonClicked(_:)), for: .touchUpInside)
    }

    func textfieldConfig() {

        viewModel.phoneNumber.bind { phoneNumber in

            self.mainView.phoneNumberTextField.mainTextField.text = phoneNumber.applyPatternOnNumbers(pattern: "###-####-####", replacementCharacter: "#")
        }

        mainView.phoneNumberTextField.mainTextField.addTarget(self, action: #selector(phoneNumberTextFieldDidChange(textfield:)), for: .editingChanged)
    }

    @objc func phoneNumberTextFieldDidChange(textfield: UITextField) {

        viewModel.phoneNumber.value = textfield.text ?? ""
    }

    @objc func sendButtonClicked(_ sender: UIButton) {

        addPressAnimationToButton(sender) { _ in

            //UI다 짜면 활성화
//            PhoneAuthProvider.provider().verifyPhoneNumber("+82) \(self.mainView.phoneNumberTextField.mainTextField.text ?? "")", uiDelegate: nil) { verificationID, error in
//                if let error = error {
//                     print(error.localizedDescription)
//                     return
//                }
//                self.viewModel.yourID = verificationID!
//            }

            self.coordinator?.startLogin2VC()

        }
    }
}
