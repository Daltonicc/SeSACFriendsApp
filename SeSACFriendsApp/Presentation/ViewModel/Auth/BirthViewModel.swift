//
//  BirthViewModel.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/01/25.
//

import UIKit
import RxSwift
import RxCocoa

final class BirthViewModel {

    weak var coordinator: AuthCoordinator?

    let disposeBag = DisposeBag()

    func checkValidation(yearTextField: UITextField, monthTextField: UITextField, dayTextField: UITextField, button: CustomButton) {

        yearTextField.rx.text
            .bind { str in
                guard let str = str else { return }
                guard let year = Int(str) else { return }

                if year <= 2003 {
                    button.buttonState = .fill
                } else {
                    button.buttonState = .disable
                }
            }
            .disposed(by: disposeBag)
    }

    func checkButtonState(yearTextField: UITextField, monthTextField: UITextField, dayTextField: UITextField, button: CustomButton) {

        if button.buttonState == .fill {

            coordinator?.showEmailView()
        } else {
            //토스트 메세지!
        }
    }
}
