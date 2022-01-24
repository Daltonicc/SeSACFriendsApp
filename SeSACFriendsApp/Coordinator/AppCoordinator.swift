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

        let coordinator = OnboardingCoordinator(presenter: presenter)
        childCoordinators.append(coordinator)
        coordinator.start()

        window.makeKeyAndVisible()
    }

}
