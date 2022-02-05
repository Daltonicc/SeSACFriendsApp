//
//  HomeCoordinator.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/01/24.
//

import UIKit

final class AuthCoordinator: NSObject, Coordinator {

    weak var parentCoordinator: AppCoordinator?

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
        onboardingView.viewModel.coordinator = self
        presenter.pushViewController(onboardingView, animated: true)
    }

    func showLoginAuthView() {

        let loginAuthView = LoginViewController()
        loginAuthView.viewModel.coordinator = self
        presenter.pushViewController(loginAuthView, animated: true)
    }

    func showLogin2AuthView() {

        let login2AuthView = Login2ViewController()
        login2AuthView.viewModel = Login2ViewModel(coordinator: self,
                                                   useCase: Login2UseCase(
                                                    repository: Login2Repository()))
        presenter.pushViewController(login2AuthView, animated: true)
    }

    func showNicknameView() {

        let nicknameView = NicknameViewController()
        nicknameView.viewModel.coordinator = self
        presenter.pushViewController(nicknameView, animated: true)
    }

    func showBirthView() {

        let birthView = BirthViewController()
        birthView.viewModel.coordinator = self
        presenter.pushViewController(birthView, animated: true)
    }

    func showEmailView() {

        let emailView = EmailViewController()
        emailView.viewModel.coordinator = self
        presenter.pushViewController(emailView, animated: true)
    }

    func showGenderView() {

        let genderView = GenderViewController()
        genderView.viewModel = GenderViewModel(coordinator: self,
                                               useCase: GenderUseCase(
                                                repository: GenderRepository()))
        presenter.pushViewController(genderView, animated: true)
    }

    func finish() {

        parentCoordinator?.childDidFinish(self, completion: {
            self.parentCoordinator?.startHome()
        })

    }
}
