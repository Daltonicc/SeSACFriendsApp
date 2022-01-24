//
//  OnboardingCoordinator.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/01/24.
//

import UIKit

final class OnboardingCoordinator: NSObject, Coordinator {

    var presenter: UINavigationController

    var childCoordinators: [Coordinator]

    init(presenter: UINavigationController) {
        self.presenter = presenter
        self.childCoordinators = []
    }

    func start() {

        let OnboardingView = OnboardingViewController()
        presenter.pushViewController(OnboardingView, animated: true)
    }

}
