//
//  LoginViewController.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/01/23.
//

import UIKit
import Toast
import RxSwift
import RxCocoa

/*
 구현해야할 것
 
 1. 인증번호 자동으로 가져오기
 2. 타이머 기능
 3. 상황별 토스트 메세지

 */
final class LoginViewController: BaseViewController {

    weak var coordinator: AuthCoordinator?
    let mainView = LoginView()
    var viewModel: LoginViewModel?

    deinit {
        print("Login1 Deinit")
    }

    override func loadView() {
        super.loadView()

        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func setViewConfig() {
        super.setViewConfig()

        mainView.authButton.rx.tap
            .bind { [weak self] in
                self?.addPressAnimationToButton(self?.mainView.authButton ?? CustomButton()) { [weak self] _ in
                    self?.viewModel!.requestFirebaseAuth(
                        button: self?.mainView.authButton ?? CustomButton(),
                        textField: self?.mainView.phoneNumberTextField.mainTextField ?? UITextField()
                    )
                }
            }
            .disposed(by: disposeBag)
    }

    override func textfieldConfig() {
        super.textfieldConfig()

        mainView.phoneNumberTextField.mainTextField.delegate = self
        mainView.phoneNumberTextField.mainTextField.addTarget(self, action: #selector(phoneNumberTextFieldDidChange(textfield:)), for: .editingChanged)

        viewModel?.checkAuthValidation(textField: mainView.phoneNumberTextField.mainTextField,
                                      button: mainView.authButton)

    }

    override func navigationItemConfig() {

        navigationItem.leftBarButtonItem = backBarButton

        backBarButton.target = self
        backBarButton.rx.tap
            .bind { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            }
            .disposed(by: disposeBag)
    }

    @objc func phoneNumberTextFieldDidChange(textfield: UITextField) {

        checkMaxLength(textField: textfield, maxLength: 13)
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
