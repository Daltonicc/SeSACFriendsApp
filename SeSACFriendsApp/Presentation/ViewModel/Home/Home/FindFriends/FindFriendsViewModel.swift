//
//  FindFriendsViewModel.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/02/13.
//

import Foundation

final class FindFriendsViewModel {

    weak var coordinator: HomeCoordinator?
    let useCase: FindFriendsUseCase

    init(coordinator: HomeCoordinator, useCase: FindFriendsUseCase) {
        self.coordinator = coordinator
        self.useCase = useCase
    }
}
