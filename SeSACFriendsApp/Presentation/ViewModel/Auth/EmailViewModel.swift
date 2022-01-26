//
//  EmailViewModel.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/01/25.
//

import UIKit

final class EmailViewModel {

    weak var coordinator: AuthCoordinator?

    var email: Observable<String> = Observable("")

    func checkValidation(textField: UITextField, button: CustomButton) {

        email.bind { email in

            textField.text = email

            //유효성 검사 로직 짜야함.
            if email.count >= 1 {
                button.buttonState = .fill
            } else {
                button.buttonState = .disable
            }
        }
    }

    func checkButtonState(button: CustomButton) {

        if button.buttonState == .fill {
            coordinator?.showGenderView()
        } else {
            //토스트 메세지!
        }
    }
}
