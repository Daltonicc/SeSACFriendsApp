//
//  BirthViewController.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/01/25.
//

import UIKit
import RxSwift
import RxCocoa

final class BirthViewController: BaseViewController {

    let mainView = BirthView()
    var viewModel = BirthViewModel()

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

//        viewModel.checkValidation(textField: mainView.yearTextField.mainTextField, button: mainView.nextButton)
//        mainView.yearTextField.mainTextField.addTarget(self, action: #selector(yearTextFieldDidChange(textfield:)), for: .editingChanged)
    }

    @objc func yearTextFieldDidChange(textfield: UITextField) {

        viewModel.birthYear.value = textfield.text ?? ""
    }
}
