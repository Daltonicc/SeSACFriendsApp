//
//  EmailViewModel.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/01/25.
//

import UIKit
import RxSwift
import RxCocoa

// 유효성 검사 로직 필요

final class EmailViewModel {

    weak var coordinator: AuthCoordinator?

    let disposeBag = DisposeBag()

    func checkValidation(textField: UITextField, button: CustomButton) {

        textField.rx.text
            .bind { [weak self] str in
                guard let str = str else { return }
                if str.count >= 11 {
                    button.buttonState = .fill
                    UserDefaultsRepository.saveEmail(email: str)
                } else {
                    button.buttonState = .disable
                }
            }
            .disposed(by: disposeBag)

    }

    func checkButtonState(button: CustomButton) {

        if button.buttonState == .fill {
            coordinator?.showGenderView()
        } else {
            //토스트 메세지!
        }
    }
}
