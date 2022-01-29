//
//  NicknameViewModel.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/01/25.
//

import UIKit
import RxSwift
import RxCocoa

final class NicknameViewModel {

    weak var coordinator: AuthCoordinator?

    var nickname: Observable<String> = Observable("")

    let disposeBag = DisposeBag()

    func checkValidation(textField: UITextField, button: CustomButton) {

        nickname.bind { nickname in

            textField.text = nickname

            if nickname.count >= 1 {
                button.buttonState = .fill
            } else {
                button.buttonState = .disable
            }
        }
    }

    func checkButtonState(button: CustomButton) {

        if button.buttonState == .fill {
            coordinator?.showBirthView()
        } else {
            //토스트 메세지!
        }
    }
}
