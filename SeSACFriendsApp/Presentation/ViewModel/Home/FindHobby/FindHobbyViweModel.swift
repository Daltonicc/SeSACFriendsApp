//
//  FindHobbyViweModel.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/02/12.
//

import UIKit

final class FindHobbyViewModel {

    weak var coordinator: HomeCoordinator?
    let useCase: HomeUseCase

    init(coordinator: HomeCoordinator, useCase: HomeUseCase) {
        self.coordinator = coordinator
        self.useCase = useCase
    }
    
}
