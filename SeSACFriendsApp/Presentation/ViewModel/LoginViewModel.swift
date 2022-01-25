//
//  LoginViewModel.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/01/23.
//

import Foundation
import UIKit

final class LoginViewModel {

    weak var coordinator: HomeCoordinator?
    let loginUseCase = LoginUseCase()

    static var yourIDForFirebase: String = ""

    let idToken = UserDefaults.standard.object(forKey: "uidToken")

    var phoneNumber: Observable<String> = Observable("")

    func checkAuthValidation(textField: UITextField, button: CustomButton) {

        phoneNumber.bind { phoneNumber in

            if phoneNumber.count > 12 {
                textField.text = phoneNumber.applyPatternOnNumbers(pattern: "###-####-####", replacementCharacter: "#")
            } else {
                textField.text = phoneNumber.applyPatternOnNumbers(pattern: "###-###-####", replacementCharacter: "#")
            }

            if phoneNumber.count >= 12 {
                button.buttonState = .fill
            } else {
                button.buttonState = .disable
            }
        }
    }

    // 김성연, 배경원, 이주경, 최광호, 
    // MARK: - UseCase

    func requestFirebaseAuth(button: CustomButton, textField: UITextField) {

        // 버튼 상태가 fill 아니면 바로 리턴
        guard button.buttonState == .fill else { return }
        loginUseCase.requestFirebase(textField: textField)
        coordinator?.showLogin2AuthView()
    }
}
