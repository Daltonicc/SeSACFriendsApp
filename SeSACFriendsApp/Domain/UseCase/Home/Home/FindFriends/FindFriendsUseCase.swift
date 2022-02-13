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
}
