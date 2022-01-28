//
//  NicknameViewController.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/01/25.
//

import UIKit
import RxSwift
import RxCocoa

final class NicknameViewController: BaseViewController {

    let mainView = NicknameView()
    var viewModel = NicknameViewModel()

    let disposeBag = DisposeBag()

    override func loadView() {
        super.loadView()
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func setViewConfig() {
        super.setViewConfig()

        mainView.nicknameTextField.mainTextField.delegate = self

        mainView.nextButton.rx.tap
            .bind {
                self.addPressAnimationToButton(self.mainView.nextButton) { _ in
                    self.viewModel.checkButtonState(button: self.mainView.nextButton)
                }
            }
            .disposed(by: disposeBag)
    }

    override func textfieldConfig() {
        super.textfieldConfig()

        viewModel.checkValidation(textField: mainView.nicknameTextField.mainTextField, button: mainView.nextButton)
        mainView.nicknameTextField.mainTextField.addTarget(self, action: #selector(nicknameTextFieldDidChange(textfield:)), for: .editingChanged)
    }

    @objc func nicknameTextFieldDidChange(textfield: UITextField) {

        viewModel.nickname.value = textfield.text ?? ""
        checkMaxLength(textField: mainView.nicknameTextField.mainTextField, maxLength: 10)
    }
}

extension NicknameViewController: UITextFieldDelegate {

    func checkMaxLength(textField: UITextField, maxLength: Int) {
        if (textField.text?.count ?? 0 > maxLength) {
            textField.deleteBackward()
        }
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {

        mainView.nicknameTextField.textFieldState = .focus

    }

    func textFieldDidEndEditing(_ textField: UITextField) {

        mainView.nicknameTextField.textFieldState = .active
    }
}
