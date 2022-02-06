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

    let disposeBag = DisposeBag()

    init(coordinator: MyProfileCoordinator, userData: UserData, useCase: ProfileUseCase) {
        self.coordinator = coordinator
        self.useCase = useCase
        self.userData = userData
    }

    deinit {
        print("ProfileViewModel Deinit")
    }

    func checkGender(manButton: CustomButton, womanButton: CustomButton) {

        manButton.rx.tap
            .bind { [weak self] in
                if manButton.backgroundColor == .white {
                    manButton.backgroundColor = .baseGreen
                    manButton.setTitleColor(.white, for: .normal)
                    womanButton.backgroundColor = .white
                    womanButton.setTitleColor(.black, for: .normal)
                    self?.userData?.gender = 1
                }
            }
            .disposed(by: disposeBag)

        womanButton.rx.tap
            .bind { [weak self] in
                if womanButton.backgroundColor == .white {
                    womanButton.backgroundColor = .baseGreen
                    womanButton.setTitleColor(.white, for: .normal)
                    manButton.backgroundColor = .white
                    manButton.setTitleColor(.black, for: .normal)
                    self?.userData?.gender = 0
                }
            }
            .disposed(by: disposeBag)
    }

    func checkHobby(textField: UITextField) {

        textField.rx.text
            .bind { [weak self] str in
                guard let str = str else { return }
                if str.count >= 1 {
                    self?.userData?.hobby = str
                }
            }
            .disposed(by: disposeBag)
    }

    func checkNumberSearchable(searchSwitch: UISwitch) {

        searchSwitch.rx.controlEvent(.valueChanged)
            .bind { [weak self] in
                if searchSwitch.isOn {
                    self?.userData?.numberSearchable = 1
                } else {
                    self?.userData?.numberSearchable = 0
                }
            }
            .disposed(by: disposeBag)
    }

    func updateUserData(completion: @escaping () -> Void) {

        let parameter: [String: Any] = [
            "searchable": userData!.numberSearchable,
            "ageMin": userData!.ageMin,
            "ageMax": userData!.ageMax,
            "gender": userData!.gender,
            "hobby": userData!.hobby
        ]

        useCase.updateUserData(parameter: parameter) { statusCode in
            completion()
        }
    }

    func withdrawButtonConfig() {

        coordinator?.showWithdrawView()
    }
}
