//
//  NicknameViewController.swift
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

 */

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

        mainView.nicknameTextField.mainTextField.delegate = self

        viewModel.checkValidation(textField: mainView.nicknameTextField.mainTextField, button: mainView.nextButton)
        mainView.nicknameTextField.mainTextField.addTarget(self, action: #selector(nicknameTextFieldDidChange(textfield:)), for: .editingChanged)
    }

    override func navigationItemConfig() {

        navigationItem.leftBarButtonItem = backBarButton

        backBarButton.target = self
        backBarButton.rx.tap
            .bind {
                self.navigationController?.popViewController(animated: true)
            }
            .disposed(by: disposeBag)
    }

    @objc func nicknameTextFieldDidChange(textfield: UITextField) {

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
