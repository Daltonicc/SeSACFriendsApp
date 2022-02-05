//
//  Login2ViewController.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/01/24.
//

import UIKit
import RxSwift
import RxCocoa

/*
 구현해야할 것

 1. 상황별 토스트 메세지

 */

final class Login2ViewController: BaseViewController {

    let mainView = Login2View()
    let viewModel = Login2ViewModel()

    let disposeBag = DisposeBag()

    override func loadView() {
        super.loadView()

        self.view = mainView
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func setViewConfig() {
        super.setViewConfig()

        mainView.numberTextField.mainTextField.delegate = self

        mainView.authButton.rx.tap
            .bind {
                self.addPressAnimationToButton(self.mainView.authButton) { _ in
                    self.viewModel.checkCredentialNumber(textField: self.mainView.numberTextField.mainTextField)
                }
            }
            .disposed(by: disposeBag)
    }

    override func textfieldConfig() {
        super.textfieldConfig()

        viewModel.checkValidation(textField: mainView.numberTextField.mainTextField, button: mainView.authButton)
        mainView.numberTextField.mainTextField.addTarget(self, action: #selector(numberTextFieldDidChange(textfield:)), for: .editingChanged)
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

    @objc func numberTextFieldDidChange(textfield: UITextField) {

        checkMaxLength(textField: textfield, maxLength: 6)
    }
}

extension Login2ViewController: UITextFieldDelegate {

    func checkMaxLength(textField: UITextField, maxLength: Int) {
        if (textField.text?.count ?? 0 > maxLength) {
            textField.deleteBackward()
        }
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {

        mainView.numberTextField.textFieldState = .focus
    }

    func textFieldDidEndEditing(_ textField: UITextField) {

        mainView.numberTextField.textFieldState = .active
    }
}
