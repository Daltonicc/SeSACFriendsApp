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

    var suspendFindFriendsCase: SuspendFindFriendsCase?

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
                // 어떤 버튼 눌렀는지에 따라 분기처리.
                switch self?.suspendFindFriendsCase {
                case .tapChangeHobbyButton: self?.coordinator?.presenter.popViewController(animated: true)
                case .tapFindingSuspendButton: self?.coordinator?.presenter.popToRootViewController(animated: true)
                default: self?.coordinator?.presenter.popViewController(animated: true)
                }
            }
        }
    }
}

enum SuspendFindFriendsCase {
    case tapFindingSuspendButton
    case tapChangeHobbyButton
}
