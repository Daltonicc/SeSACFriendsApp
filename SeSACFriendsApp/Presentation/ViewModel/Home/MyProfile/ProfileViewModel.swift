//
//  ProfileViewModel.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/02/05.
//

import UIKit

final class ProfileViewModel {

    weak var coordinator: MyProfileCoordinator?

    let useCase: ProfileUseCase

    init(coordinator: MyProfileCoordinator, useCase: ProfileUseCase) {
        self.coordinator = coordinator
        self.useCase = useCase
    }
}
