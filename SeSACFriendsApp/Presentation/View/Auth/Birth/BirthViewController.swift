//
//  BirthViewController.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/01/25.
//

import UIKit

final class BirthViewController: BaseViewController {

    let mainView = BirthView()
    var viewModel = BirthViewModel()

    override func loadView() {
        super.loadView()
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func setViewConfig() {
        super.setViewConfig()

        mainView.nextButton.addTarget(self, action: #selector(nextButtonClicked(_:)), for: .touchUpInside)
    }

    override func textfieldConfig() {
        super.textfieldConfig()

//        viewModel.checkValidation(textField: mainView.yearTextField.mainTextField, button: mainView.nextButton)
//        mainView.yearTextField.mainTextField.addTarget(self, action: #selector(yearTextFieldDidChange(textfield:)), for: .editingChanged)
    }

    @objc func yearTextFieldDidChange(textfield: UITextField) {

        viewModel.birthYear.value = textfield.text ?? ""
    }

    @objc func nextButtonClicked(_ sender: UIButton) {

        addPressAnimationToButton(sender) { _ in

            self.viewModel.checkButtonState(button: self.mainView.nextButton)
        }
    }
}
