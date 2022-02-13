//
//  FindFriendsViewModel.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/02/13.
//

import Foundation
import Alamofire

final class FindFriendsViewModel {

    weak var coordinator: HomeCoordinator?
    let useCase: FindFriendsUseCase

    init(coordinator: HomeCoordinator, useCase: FindFriendsUseCase) {
        self.coordinator = coordinator
        self.useCase = useCase
    }

    deinit {
        print("FindFriendsViewModel Deinit")
    }

    func suspendFindFriends(completion: @escaping (String) -> Void) {

        useCase.suspendFindFriends { [weak self] error in
            if let error = error {
                completion(error.errorDescription!)
            } else {
                self?.coordinator?.presenter.popToRootViewController(animated: true)
            }
        }
    }
}
