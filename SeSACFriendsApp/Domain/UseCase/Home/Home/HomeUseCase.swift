//
//  HomeUseCase.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/02/08.
//

import UIKit

final class HomeUseCase {

    let repository: HomeRepository

    init(repository: HomeRepository) {
        self.repository = repository
    }
}
