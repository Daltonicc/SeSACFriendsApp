//
//  FindFriendsUseCase.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/02/13.
//

import UIKit

final class FindFriendsUseCase {

    let repository: QueueRepositoryInterface
    let firebaseRepository: FirebaseRepositoryInterface

    init(repository: QueueRepositoryInterface, firebaseRepository: FirebaseRepositoryInterface) {
        self.repository = repository
        self.firebaseRepository = firebaseRepository
    }

    func suspendFindFriends(completion: @escaping (QueueNetworkError?) -> Void) {

        repository.suspendFindFriends { [weak self] error in
            if let error = error {
                // 토큰 에러일 경우에만 파베 레포로 넘겨서 갱신요청.
                // 다른 에러면 그대로 뷰모델로 넘겨줌.
                // 성공하면 nil값 넘겨줌.
                if error == .firebaseIdTokenExpired {
                    self?.firebaseRepository.refreshIDToken {
                        self?.repository.suspendFindFriends { _ in
                            completion(nil)
                        }
                    }
                } else {
                    completion(error)
                }
            } else {
                completion(nil)
            }
        }
    }
}
