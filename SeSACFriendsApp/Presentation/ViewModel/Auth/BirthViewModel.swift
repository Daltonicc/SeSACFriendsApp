//
//  BirthViewModel.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/01/25.
//

import UIKit

final class BirthViewModel {

    weak var coordinator: AuthCoordinator?

    var birthYear: Observable<String> = Observable("")
    var birthMonth: Observable<String> = Observable("")
    var birthDay: Observable<String> = Observable("")

    func checkValidation(textField: UITextField, button: CustomButton) {

        birthYear.bind { year in

            textField.text = year

            if Int(year)! <= 2003 {
                button.buttonState = .fill
            } else {
                button.buttonState = .disable
            }
        }
    }

    func checkButtonState(button: CustomButton) {

        if button.buttonState == .fill {
            coordinator?.showEmailView()
        } else {
            //토스트 메세지!
        }
    }
}
