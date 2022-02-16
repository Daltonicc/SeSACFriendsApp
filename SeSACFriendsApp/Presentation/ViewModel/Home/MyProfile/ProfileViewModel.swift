//
//  ProfileViewModel.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/02/05.
//

import UIKit
import RxCocoa
import RxSwift

final class ProfileViewModel: ViewModel {

    weak var coordinator: MyProfileCoordinator?

    let useCase: ProfileUseCase

    var userData: UserData?

    let disposeBag = DisposeBag()

    init(coordinator: MyProfileCoordinator, useCase: ProfileUseCase) {
        self.coordinator = coordinator
        self.useCase = useCase
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

    func getUserData(completion: @escaping (String?) -> Void) {

        useCase.getUserData { [weak self] (result) in
            switch result {
            case let .success(data):
                self?.userData = data
                completion(nil)
            case let .failure(error):
                completion(error.errorDescription)
            }
        }
    }

    func updateUserData(completion: @escaping (String?) -> Void) {

        let parameter: [String: Any] = [
            "searchable": userData!.numberSearchable,
            "ageMin": userData!.ageMin,
            "ageMax": userData!.ageMax,
            "gender": userData!.gender,
            "hobby": userData!.hobby
        ]

        useCase.updateUserData(parameter: parameter) { [weak self] error in
            if let error = error {
                // 에러가 존재하면 관련 에러 토스트 메세지
                completion(error.errorDescription)
            } else {
                // 에러 없으면 업뎃 성공!
                self?.coordinator?.presenter.popViewController(animated: true)
            }
        }
    }

    func withdrawButtonConfig() {
        coordinator?.showWithdrawView()
    }
}
