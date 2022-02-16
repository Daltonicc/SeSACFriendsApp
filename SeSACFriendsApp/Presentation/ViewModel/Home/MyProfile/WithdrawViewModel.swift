//
//  WithdrawViewModel.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/02/06.
//

import UIKit

final class WithdrawViewModel: ViewModel {

    weak var coordinator: MyProfileCoordinator?

    let useCase: WithdrawUseCase

    init(coordinator: MyProfileCoordinator, useCase: WithdrawUseCase) {
        self.coordinator = coordinator
        self.useCase = useCase
    }

    func withdrawUserData(completion: @escaping (String?) -> Void) {

        useCase.withdrawUserData { [weak self] error in
            if let error = error {
                // 에러가 존재하면 관련 에러 토스트 메세지
                completion(error.errorDescription)
            } else {
                // 에러 없으면 업뎃 성공!
                self?.coordinator?.finish()
            }
        }
    }
}
