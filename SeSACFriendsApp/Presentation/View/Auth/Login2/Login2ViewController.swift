//
//  Login2ViewController.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/01/24.
//

import UIKit
import FirebaseAuth

final class Login2ViewController: BaseViewController {

    weak var coordinator: HomeCoordinator?
    let mainView = Login2View()
    let viewModel = LoginViewModel()

    override func loadView() {
        super.loadView()

        self.view = mainView
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.view.makeToast("전화 번호 인증 시작", point: CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2), title: nil, image: nil, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func setViewConfig() {
        super.setViewConfig()

        mainView.numberTextField.mainTextField.delegate = self
        mainView.authButton.addTarget(self, action: #selector(authButtonClicked(_:)), for: .touchUpInside)

    }

    override func textfieldConfig() {
        super.textfieldConfig()

        viewModel.authNumber.bind { authNumber in
            
            self.mainView.numberTextField.mainTextField.text = authNumber.applyPatternOnNumbers(pattern: "######", replacementCharacter: "#")
        }
        
        mainView.numberTextField.mainTextField.addTarget(self, action: #selector(numberTextFieldDidChange(textfield:)), for: .editingChanged)

    }

    @objc func numberTextFieldDidChange(textfield: UITextField) {

        viewModel.authNumber.value = textfield.text ?? ""
        checkMaxLength(textField: textfield, maxLength: 6)
    }

    @objc func authButtonClicked(_ sender: UIButton) {

        let credential = PhoneAuthProvider.provider().credential(withVerificationID: LoginViewModel.yourID, verificationCode: mainView.numberTextField.mainTextField.text ?? "")

        addPressAnimationToButton(sender) { _ in
            Auth.auth().signIn(with: credential) { success, error in
                if error == nil {
                    let alert = UIAlertController(title: "로그인 성공!", message: nil, preferredStyle: .alert)
                    let ok = UIAlertAction(title: "확인", style: .default, handler: nil)
                    alert.addAction(ok)
                    self.present(alert, animated: true, completion: nil)
                } else {
                    let alert = UIAlertController(title: "로그인 실패", message: "인증키를 다시 확인해주세요", preferredStyle: .alert)
                    let ok = UIAlertAction(title: "확인", style: .default, handler: nil)
                    alert.addAction(ok)
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
}

extension Login2ViewController: UITextFieldDelegate {

    func checkMaxLength(textField: UITextField, maxLength: Int) {
        if (textField.text?.count ?? 0 > maxLength) {
            textField.deleteBackward()
        }
    }
}
