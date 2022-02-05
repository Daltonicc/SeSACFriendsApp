//
//  ProfileUseCase.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/02/05.
//

import UIKit

final class ProfileUseCase {

    let repository: ProfileRepository

    init(repository: ProfileRepository) {
        self.repository = repository
    }
}
