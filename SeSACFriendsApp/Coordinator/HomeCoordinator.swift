//
//  HomeCoordinator.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/01/24.
//

import UIKit

class HomeCoordinator: NSObject, Coordinator {

    var presenter: UINavigationController

    var childCoordinators: [Coordinator]

    init(presenter: UINavigationController) {
        self.presenter = presenter
        self.childCoordinators = []
    }

    func start() {

    }

    func startOnboardingView() {

        let onboardingView = OnboardingViewController()
        onboardingView.coordinator = self
        presenter.pushViewController(onboardingView, animated: true)
    }

    func showLoginAuthView() {

        let loginAuthView = LoginViewController()
        loginAuthView.coordinator = self
        presenter.pushViewController(loginAuthView, animated: true)
    }

    func showLogin2AuthView() {

        let login2AuthView = Login2ViewController()
        login2AuthView.coordinator = self
        presenter.pushViewController(login2AuthView, animated: true)
    }

}
