//
//  Login2ViewModel.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/01/25.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import Moya

final class Login2ViewModel {

    weak var coordinator: AuthCoordinator?
    let useCase: Login2UseCase
    let repository = Login2Repository()

    let disposeBag = DisposeBag()

    init(coordinator: AuthCoordinator, useCase: Login2UseCase) {
        self.coordinator = coordinator
        self.useCase = useCase
    }

    func checkValidation(textField: UITextField, button: CustomButton) {

        textField.rx.text
            .bind { str in
                guard let str = str else { return }
                textField.text = str.applyPatternOnNumbers(pattern: "######", replacementCharacter: "#")

                if str.count == 6 {
                    button.buttonState = .fill
                } else {
                    button.buttonState = .disable
                }
            }
            .disposed(by: disposeBag)
    }

    // MARK: - UseCase, Repository

    func checkCredentialNumber(textField: UITextField) {
            // 받아온 id토큰으로 API통신 회원정보 있는지 체크.
            // 없으면 닉네임뷰로
            // 있으면 바로 홈으로.
        useCase.checkCredential(textField: textField) { statusCode in
            switch statusCode {
            case 200: self.coordinator?.finish() // 홈 탭으로 이동
            case 406: self.coordinator?.showNicknameView() // 닉네임뷰로 이동
            default: print(statusCode)
            }
        }
    }
}
