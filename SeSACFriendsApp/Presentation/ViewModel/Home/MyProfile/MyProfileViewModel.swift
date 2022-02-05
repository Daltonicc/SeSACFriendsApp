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

    init(coordinator: MyProfileCoordinator, useCase: MyProfileUseCase) {
        self.coordinator = coordinator
        self.useCase = useCase
    }

}
