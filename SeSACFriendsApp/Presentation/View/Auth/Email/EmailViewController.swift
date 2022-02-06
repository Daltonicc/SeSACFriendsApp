//
//  EmailViewController.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/01/25.
//

import UIKit
import RxSwift
import RxCocoa

/*
 구현해야할 것

 1. 상황별 토스트 메세지
 2. 이메일 유효성 검사

 */
final class EmailViewController: BaseViewController {

    let mainView = EmailView()
    var viewModel = EmailViewModel()

    let disposeBag = DisposeBag()

    deinit {
        print("Email Deinit")
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

        mainView.emailTextField.mainTextField.delegate = self

        mainView.nextButton.rx.tap
            .bind { [weak self] in
                self?.addPressAnimationToButton(self?.mainView.nextButton ?? CustomButton()) {[weak self] _ in
                    self?.viewModel.checkButtonState(button: self?.mainView.nextButton ?? CustomButton())
                }
            }
            .disposed(by: disposeBag)
    }

    override func textfieldConfig() {
        super.textfieldConfig()

        viewModel.checkValidation(textField: mainView.emailTextField.mainTextField, button: mainView.nextButton)
        mainView.emailTextField.mainTextField.addTarget(self, action: #selector(emailTextFieldDidChange(textfield:)), for: .editingChanged)
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

    @objc func emailTextFieldDidChange(textfield: UITextField) {

        //최대 길이 제한 안줘도 될듯.
        checkMaxLength(textField: mainView.emailTextField.mainTextField, maxLength: 50)
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
