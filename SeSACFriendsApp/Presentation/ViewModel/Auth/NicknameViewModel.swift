//
//  NicknameViewModel.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/01/25.
//

import UIKit
import RxSwift
import RxCocoa

final class NicknameViewModel: ViewModel {

    weak var coordinator: AuthCoordinator?

    let disposeBag = DisposeBag()

    deinit {
        print("NicknameViewModel Deinit")
    }

    func checkValidation(textField: UITextField, button: CustomButton) {

        textField.rx.text
            .bind { str in
                guard let str = str else { return }
                if str.count >= 1 {
                    button.buttonState = .fill
                    UserDefaultsRepository.saveNickname(nickname: str)
                } else {
                    button.buttonState = .disable
                }
            }
            .disposed(by: disposeBag)
    }

    func checkButtonState(button: CustomButton) {

        if button.buttonState == .fill {
            coordinator?.showBirthView()
        } else {
            //토스트 메세지!
        }
    }
}
