//
//  Login2ViewController.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/01/24.
//

import UIKit

final class Login2ViewController: BaseViewController {

    let mainView = Login2View()
    let viewModel = Login2ViewModel()

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
        mainView.authButton.addTarget(self, action: #selector(authButtonClicked(_:)), for: .touchUpInside)

    }

    override func textfieldConfig() {
        super.textfieldConfig()

        viewModel.checkValidation(textField: mainView.numberTextField.mainTextField)
        
        mainView.numberTextField.mainTextField.addTarget(self, action: #selector(numberTextFieldDidChange(textfield:)), for: .editingChanged)
    }

    @objc func numberTextFieldDidChange(textfield: UITextField) {

        viewModel.authNumber.value = textfield.text ?? ""
        checkMaxLength(textField: textfield, maxLength: 6)
    }

    @objc func authButtonClicked(_ sender: UIButton) {

        addPressAnimationToButton(sender) { _ in
            self.viewModel.checkCredentialNumber(textField: self.mainView.numberTextField.mainTextField)
        }
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
