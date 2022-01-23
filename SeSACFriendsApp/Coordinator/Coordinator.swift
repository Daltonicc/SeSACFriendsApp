//
//  Coordinator.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/01/23.
//

import Foundation
import UIKit

protocol Coordinator {

    var childCoordinators: [Coordinator] { get set}
    var nav: UINavigationController { get set }

    func startVC()
}

class MainCoordinator: Coordinator {

    var childCoordinators = [Coordinator]()
    var nav: UINavigationController

    init(nav: UINavigationController) {
        self.nav = nav
    }

    func startOnboardingVC() {

        let vc = OnboardingViewController()
        vc.coordinator = self
        nav.pushViewController(vc, animated: true)
    }

    func startVC() {

    }

}
