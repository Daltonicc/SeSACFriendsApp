//
//  LoginViewModel.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/01/23.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

final class LoginViewModel {

    weak var coordinator: AuthCoordinator?
    let useCase = LoginUseCase()

    static var yourIDForFirebase: String = ""

    let disposeBag = DisposeBag()

    deinit {
        print("LoginViewModel Deinit")
    }

    func checkAuthValidation(textField: UITextField, button: CustomButton) {

        textField.rx.text
            .bind { str in
                guard let str = str else { return }
                if str.count > 12 {
                    textField.text = str.applyPatternOnNumbers(pattern: "###-####-####", replacementCharacter: "#")
                } else {
                    textField.text = str.applyPatternOnNumbers(pattern: "###-###-####", replacementCharacter: "#")
                }

                if str.count >= 12 {
                    button.buttonState = .fill

                    let phoneNumber = "+82\(str)"
                    var newNumber = phoneNumber.components(separatedBy: ["-"]).joined()
                    newNumber.remove(at: newNumber.index(newNumber.startIndex, offsetBy: 3))
                    UserDefaultsRepository.savePhoneNumber(phoneNumber: newNumber)
                } else {
                    button.buttonState = .disable
                }
            }
            .disposed(by: disposeBag)
    }

    // MARK: - UseCase

    func requestFirebaseAuth(button: CustomButton, textField: UITextField) {

        // 버튼 상태가 fill 아니면 바로 리턴
        guard button.buttonState == .fill else { return }
        useCase.requestFirebase(textField: textField)
        coordinator?.showLogin2AuthView()

//        self.coordinator?.finish()
    }
}
