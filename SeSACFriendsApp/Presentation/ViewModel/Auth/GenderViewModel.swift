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

    let disposeBag = DisposeBag()
    var genderNumber = -1

    func checkValidation(manButton: CustomButton, womanButton: CustomButton) {

        manButton.rx.tap
            .bind {
                if manButton.backgroundColor == .white {
                    manButton.backgroundColor = .whiteGreen
                    womanButton.backgroundColor = .white
                    self.genderNumber = 1
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
                    UserDefaults.standard.set(self.genderNumber, forKey: "gender")
                }
            }
            .disposed(by: disposeBag)
    } 
}
