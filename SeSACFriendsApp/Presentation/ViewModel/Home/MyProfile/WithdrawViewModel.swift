//
//  WithdrawViewModel.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/02/06.
//

import UIKit

final class WithdrawViewModel {

    weak var coordinator: MyProfileCoordinator?

    let useCase: WithdrawUseCase

    init(coordinator: MyProfileCoordinator, useCase: WithdrawUseCase) {
        self.coordinator = coordinator
        self.useCase = useCase
    }

    func withdrawUserData() {

        useCase.withdrawUserData { [weak self] in
            self?.coordinator?.finish()
        }
    }
}
