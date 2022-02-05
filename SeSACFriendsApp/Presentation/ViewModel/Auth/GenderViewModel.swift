//
//  GenderViewModel.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/01/25.
//

import UIKit
import RxSwift
import RxCocoa

final class GenderViewModel {

    weak var coordinator: AuthCoordinator?
    let repository = GenderRepository()
    let useCase: GenderUseCase

    let disposeBag = DisposeBag()
    
    var genderNumber = -1

    init(coordinator: AuthCoordinator, useCase: GenderUseCase) {
        self.coordinator = coordinator
        self.useCase = useCase
    }

    func checkValidation(manButton: CustomButton, womanButton: CustomButton, nextButton: CustomButton) {

        manButton.rx.tap
            .bind {
                if manButton.backgroundColor == .white {
                    manButton.backgroundColor = .whiteGreen
                    womanButton.backgroundColor = .white
                    self.genderNumber = 1
                    nextButton.buttonState = .fill
                    UserDefaults.standard.set(self.genderNumber, forKey: "gender")
                }
            }
            .disposed(by: disposeBag)

        womanButton.rx.tap
            .bind {
                if womanButton.backgroundColor == .white {
                    womanButton.backgroundColor = .whiteGreen
                    manButton.backgroundColor = .white
                    self.genderNumber = 0
                    nextButton.buttonState = .fill
                    UserDefaults.standard.set(self.genderNumber, forKey: "gender")
                }
            }
            .disposed(by: disposeBag)
    }

    func checkButtonState(button: CustomButton) {

        if button.buttonState == .fill {

            repository.requestRegisterUser()

        } else {
            //토스트 메세지!
        }
    }
}
