//
//  Login2ViewModel.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/01/25.
//

import Foundation
import UIKit
import SwiftUI

final class Login2ViewModel {

    weak var coordinator: AuthCoordinator?
    let login2UseCase = Login2UseCase()

    var authNumber: Observable<String> = Observable("")

    let idToken = UserDefaults.standard.object(forKey: "uidToken")

    func checkValidation(textField: UITextField, button: CustomButton) {

        authNumber.bind { authNumber in

            textField.text = authNumber.applyPatternOnNumbers(pattern: "######", replacementCharacter: "#")

            if authNumber.count == 6 {
                button.buttonState = .fill
            } else {
                button.buttonState = .disable
            }
        }
    }

    // MARK: - UseCase

    func checkCredentialNumber(textField: UITextField) {

//        login2UseCase.checkCredential(textField: textField) {
//
//            // 받아온 id토큰으로 API통신 회원정보 있는지 체크.
//            // 없으면 닉네임뷰로
//            self.coordinator?.showNicknameView()
//
//            // 있으면 바로 홈으로.
//
//        }
        coordinator?.showNicknameView()
    }
}
