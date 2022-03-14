//
//  FindHobbyUseCase.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/02/12.
//

import Foundation

final class FindHobbyUseCase {

    let repository: QueueRepositoryInterface
    let firebaseRepository: FirebaseRepositoryInterface

    init(repository: QueueRepositoryInterface, firebaseRepository: FirebaseRepositoryInterface) {
        self.repository = repository
        self.firebaseRepository = firebaseRepository
    }

    func fetchAroundUserData(parameter: [String: Any], completion: @escaping (Result<OtherUserDataList, QueueNetworkError>) -> Void) {

        repository.fetchAroundUserData(parameter: parameter) { (result) in
            switch result {
            case let .success(data):
                completion(.success(data))
            case let .failure(error):
                if error == .firebaseIdTokenExpired {
                    self.firebaseRepository.refreshIDToken {
                        self.repository.fetchAroundUserData(parameter: parameter, completion: { (result) in
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

    func requestFindFriends(parameter: [String: Any], completion: @escaping (QueueNetworkError?) -> Void) {

        repository.requestFindFriends(parameter: parameter) { [weak self] error in
            if let error = error {
                if error == .firebaseIdTokenExpired {
                    self?.firebaseRepository.refreshIDToken {
                        self?.repository.requestFindFriends(parameter: parameter, completion: { _ in
                            completion(nil)
                        })
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
