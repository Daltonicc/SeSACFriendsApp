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

    weak var coordinator: HomeCoordinator?
    let login2UseCase = Login2UseCase()

    var authNumber: Observable<String> = Observable("")

    func checkValidation(textField: UITextField) {

        authNumber.bind { authNumber in

            textField.text = authNumber.applyPatternOnNumbers(pattern: "######", replacementCharacter: "#")
        }
    }

    // MARK: - UseCase

    func checkCredentialNumber(textField: UITextField) {

        login2UseCase.checkCredential(textField: textField)
    }
}
