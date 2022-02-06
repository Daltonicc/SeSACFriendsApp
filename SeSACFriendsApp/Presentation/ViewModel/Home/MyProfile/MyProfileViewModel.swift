//
//  ProfileViewModel.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/02/05.
//

import UIKit
import RxCocoa
import RxSwift

final class MyProfileViewModel {

    weak var coordinator: MyProfileCoordinator?

    let useCase: MyProfileUseCase

    var userData: UserData?

    init(coordinator: MyProfileCoordinator, useCase: MyProfileUseCase) {
        self.coordinator = coordinator
        self.useCase = useCase
    }

    func getUserInfo(completion: @escaping (UserData) -> Void) {
        useCase.getUserData { [weak self] userData in
            self?.userData = userData
            completion(userData)
        }
    }

    func showDetailProfile() {
        coordinator?.showProfileView(userData: userData!)
    }
}
