//
//  BirthViewController.swift
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
                    self.viewModel.checkButtonState(yearTextField: self.mainView.yearTextField.mainTextField,
                                                    monthTextField: self.mainView.monthTextField.mainTextField,
                                                    dayTextField: self.mainView.dayTextField.mainTextField,
                                                    button: self.mainView.nextButton)
                }
            }
            .disposed(by: disposeBag)

        mainView.datePicker.addTarget(self, action: #selector(handleDatePicker(_:)), for: .valueChanged)
    }

    override func textfieldConfig() {
        super.textfieldConfig()

    }

    @objc func handleDatePicker(_ sender: UIDatePicker) {

        mainView.yearTextField.mainTextField.text = changeDateFormatting(date: sender.date, dateFormat: "yyyy")
        mainView.monthTextField.mainTextField.text = changeDateFormatting(date: sender.date, dateFormat: "MM")
        mainView.dayTextField.mainTextField.text = changeDateFormatting(date: sender.date, dateFormat: "dd")

        viewModel.checkValidation(yearTextField: mainView.yearTextField.mainTextField,
                                  monthTextField: mainView.monthTextField.mainTextField,
                                  dayTextField: mainView.dayTextField.mainTextField,
                                  button: mainView.nextButton)

        changeDateForSave(date: sender.date)
    }
}
