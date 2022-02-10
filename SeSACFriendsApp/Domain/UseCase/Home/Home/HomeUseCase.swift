//
//  HomeUseCase.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/02/08.
//

import UIKit

final class HomeUseCase {

    let repository: QueueRepository
    let firebaseRepository: FirebaseRepository

    init(repository: QueueRepository, firebaseRepository: FirebaseRepository) {
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
}
