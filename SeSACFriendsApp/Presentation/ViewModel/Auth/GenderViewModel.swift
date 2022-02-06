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
    let useCase: GenderUseCase

    let disposeBag = DisposeBag()
    
    var genderNumber = -1

    init(coordinator: AuthCoordinator, useCase: GenderUseCase) {
        self.coordinator = coordinator
        self.useCase = useCase
    }

    deinit {
        print("GenderViewModel Deinit")
    }

    func checkValidation(manButton: CustomButton, womanButton: CustomButton, nextButton: CustomButton) {

        manButton.rx.tap
            .bind { [weak self] _ in
                if manButton.backgroundColor == .white {
                    manButton.backgroundColor = .whiteGreen
                    womanButton.backgroundColor = .white
                    self?.genderNumber = 1
                    nextButton.buttonState = .fill
                    UserDefaultsRepository.saveGender(gender: self!.genderNumber)
                }
            }
            .disposed(by: disposeBag)

        womanButton.rx.tap
            .bind { [weak self] _ in
                if womanButton.backgroundColor == .white {
                    womanButton.backgroundColor = .whiteGreen
                    manButton.backgroundColor = .white
                    self?.genderNumber = 0
                    nextButton.buttonState = .fill
                    UserDefaultsRepository.saveGender(gender: self!.genderNumber)
                }
            }
            .disposed(by: disposeBag)
    }

    func checkButtonState(button: CustomButton) {

        if button.buttonState == .fill {

            useCase.requestRegisterUserByUseCase { [weak self] statusCode in
                switch statusCode {
                case 200: self?.coordinator?.finish() // 홈 탭으로 이동
                case 401: print("401")
                default: print(statusCode)
                }
            }

        } else {
            //토스트 메세지!
        }
    }
}
