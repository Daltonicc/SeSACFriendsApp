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

final class Login2ViewModel: ViewModel {

    weak var coordinator: AuthCoordinator?
    let useCase: Login2UseCase

    let disposeBag = DisposeBag()

    init(coordinator: AuthCoordinator, useCase: Login2UseCase) {
        self.coordinator = coordinator
        self.useCase = useCase
    }

    deinit {
        print("Login2ViewModel Deinit")
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

    func checkCredentialNumber(textField: UITextField, errorMessage: @escaping (String?) -> Void) {
            // 받아온 id토큰으로 API통신 회원정보 있는지 체크.
            // 없으면 닉네임뷰로
            // 있으면 바로 홈으로.
        useCase.checkCredential(textField: textField) { [weak self] (result) in
            switch result {
            case .success(_):
                self?.coordinator?.finish()
                
            case let .failure(error):
                if error == .notRegisteredUser {
                    self?.coordinator?.showNicknameView()
                } else {
                    errorMessage(error.errorDescription)
                }
            }
        }
    }
}
