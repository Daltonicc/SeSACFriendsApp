//
//  AppCoordinator.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/01/24.
//

import UIKit

final class AppCoordinator: NSObject, Coordinator {

    var presenter: UINavigationController
    var childCoordinators: [Coordinator]

    let window: UIWindow

    init(window: UIWindow) {
        self.window = window
        self.presenter = UINavigationController()
        self.childCoordinators = []
    }

    func start() {

        window.rootViewController = presenter

        let coordinator = AuthCoordinator(presenter: presenter)
        childCoordinators.append(coordinator)

        coordinator.parentCoordinator = self
        coordinator.startOnboardingView()

        window.makeKeyAndVisible()
    }

    func startHome() {

        window.rootViewController = presenter

        presenter.viewControllers.removeAll()
        presenter.isNavigationBarHidden = true

        let coordinator = TabBarCoordinator(presenter: presenter)
        childCoordinators.append(coordinator)

        coordinator.parentCoordinator = self
        coordinator.start()

    }

    func finish() {

    }

    func childDidFinish(_ child: Coordinator?, completion: () -> Void) {
        print("차일드 코디 확인1: \(childCoordinators)")
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                print("차일드 코디 확인2: \(childCoordinators)")
                completion()
                break
            }
        }
    }
}
