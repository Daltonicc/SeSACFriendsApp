//
//  ProfileViewModel.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/02/05.
//

import UIKit
import RxCocoa
import RxSwift

final class ProfileViewModel {

    weak var coordinator: MyProfileCoordinator?

    let useCase: ProfileUseCase

    var userData: UserData?

    var genderNumber = -1

    let disposeBag = DisposeBag()

    init(coordinator: MyProfileCoordinator, userData: UserData, useCase: ProfileUseCase) {
        self.coordinator = coordinator
        self.useCase = useCase
        self.userData = userData
    }

    func checkGender(manButton: CustomButton, womanButton: CustomButton) {

        manButton.rx.tap
            .bind {
                if manButton.backgroundColor == .white {
                    manButton.backgroundColor = .baseGreen
                    manButton.setTitleColor(.white, for: .normal)
                    womanButton.backgroundColor = .white
                    womanButton.setTitleColor(.black, for: .normal)
                    self.genderNumber = 1
                }
            }
            .disposed(by: disposeBag)

        womanButton.rx.tap
            .bind {
                if womanButton.backgroundColor == .white {
                    womanButton.backgroundColor = .baseGreen
                    womanButton.setTitleColor(.white, for: .normal)
                    manButton.backgroundColor = .white
                    manButton.setTitleColor(.black, for: .normal)
                    self.genderNumber = 0
                }
            }
            .disposed(by: disposeBag)
    }
    
}
