//
//  FindFriendsUseCase.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/02/13.
//

import Foundation

final class FindFriendsUseCase {

    let repository: QueueRepositoryInterface
    let firebaseRepository: FirebaseRepositoryInterface

    init(repository: QueueRepositoryInterface, firebaseRepository: FirebaseRepositoryInterface) {
        self.repository = repository
        self.firebaseRepository = firebaseRepository
    }

    func fetchAroundUserData(parameter: [String: Any], completion: @escaping (Result<OtherUserDataList, QueueNetworkError>) -> Void) {

        repository.fetchAroundUserData(parameter: parameter) { [weak self] (result) in
            switch result {
            case let .success(data):
                completion(.success(data))
            case let .failure(error):
                // 토큰 에러일 경우에만 파베 레포로 넘겨서 갱신요청.
                // 다른 에러면 그대로 뷰모델로 넘겨줌.
                // 성공하면 nil값 넘겨줌.
                if error == .firebaseIdTokenExpired {
                    self?.firebaseRepository.refreshIDToken {
                        self?.repository.fetchAroundUserData(parameter: parameter, completion: { (result) in
                            switch result {
                            case let .success(data): completion(.success(data))
                            case let .failure(error): completion(.failure(error))
                            }
                        })
                    }
                } else {
                    completion(.failure(error))
                }
            }
        }
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

    func checkMyQueueState(completion: @escaping (Result<MyQueueStateData, QueueNetworkError>) -> Void) {

        repository.checkMyQueueState { [weak self] (result) in
            switch result {
            case let .success(data):
                completion(.success(data))
            case let .failure(error):
                // 토큰 에러일 경우에만 파베 레포로 넘겨서 갱신요청.
                // 다른 에러면 그대로 뷰모델로 넘겨줌.
                // 성공하면 nil값 넘겨줌.
                if error == .firebaseIdTokenExpired {
                    self?.firebaseRepository.refreshIDToken {
                        self?.repository.checkMyQueueState { (result) in
                            switch result {
                            case let .success(data): completion(.success(data))
                            case let .failure(error): completion(.failure(error))
                            }
                        }
                    }
                } else {
                    completion(.failure(error))
                }
            }
        }
    }
}
