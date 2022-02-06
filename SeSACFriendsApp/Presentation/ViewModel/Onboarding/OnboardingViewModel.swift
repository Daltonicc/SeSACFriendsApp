//
//  OnboardingViewModel.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/01/25.
//

import UIKit

final class OnboardingViewModel {

    weak var coordinator: AuthCoordinator?

    func showLoginView() {
        coordinator?.showLoginAuthView()
//        coordinator?.finish()
    }
}
