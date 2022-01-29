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
    let login2UseCase = Login2UseCase()

    let disposeBag = DisposeBag()

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

    // MARK: - UseCase

    func checkCredentialNumber(textField: UITextField) {

        login2UseCase.checkCredential(textField: textField) {

            // 받아온 id토큰으로 API통신 회원정보 있는지 체크.
            // 없으면 닉네임뷰로
            // 있으면 바로 홈으로.
            let provider = MoyaProvider<SeSACFriendsAPI>()
            provider.request(.loginToFriendsApp) { (result) in
                switch result {
                case let .success(Response):
                    let data = try? Response.map(GetUser.self)
                    let statusCode = Response.statusCode
                    print("상태코드 :\(statusCode)")

                    // 상태 코드 처리
                    switch statusCode {
                    case 200: print(statusCode) //홈 탭으로 이동.
                    case 201: self.coordinator?.showNicknameView()
                    default: print("상태코드: \(statusCode) 처리 필요")
                    }
                case let .failure(MoyaError):
                    let errorCode = MoyaError.errorCode
                    print("에러코드: \(errorCode)")
                    print(MoyaError.localizedDescription)
                }
            }
        }
    }
}
