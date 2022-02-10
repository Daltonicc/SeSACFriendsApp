//
//  HomeCoordinator.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/01/31.
//

import UIKit

final class TabBarCoordinator: NSObject, Coordinator {

    weak var parentCoordinator: AppCoordinator?

    var presenter: UINavigationController
    var childCoordinators: [Coordinator]

    init(presenter: UINavigationController) {
        self.presenter = presenter
        self.childCoordinators = []
    }

    func start() {

        let tabBarController = UITabBarController()

        let homeRoot = HomeViewController()
        let home = tabBarConfig(rootViewController: homeRoot,
                                tabBartitle: "홈",
                                tabBarImage: Asset.MainTab.home.image.resized(to: CGSize(width: 20, height: 20)))
        let homeCoordinator = HomeCoordinator(presenter: home)
        homeCoordinator.parentCoordinator = self
        homeRoot.viewModel = HomeViewModel(coordinator: homeCoordinator,
                                           useCase: HomeUseCase(
                                            repository: HomeRepository()))
        childCoordinators.append(homeCoordinator)

        let shop = tabBarConfig(rootViewController: ShopViewController(),
                                tabBartitle: "새싹샵",
                                tabBarImage: Asset.MainTab.shop.image.resized(to: CGSize(width: 20, height: 20)))
        let shopCoordinator = ShopCoordinator(presenter: shop)
        shopCoordinator.parentCoordinator = self
        childCoordinators.append(shopCoordinator)

        let friends = tabBarConfig(rootViewController: FriendsViewController(),
                                   tabBartitle: "새싹친구",
                                   tabBarImage: Asset.MainTab.friends.image.resized(to: CGSize(width: 20, height: 20)))
        let friendsCoordinator = FriendsCoordinator(presenter: friends)
        friendsCoordinator.parentCoordinator = self
        childCoordinators.append(friendsCoordinator)

        let myProfileRoot = MyProfileViewController()
        let myProfile = tabBarConfig(rootViewController: myProfileRoot,
                                     tabBartitle: "내정보",
                                     tabBarImage: Asset.MainTab.profile.image.resized(to: CGSize(width: 20, height: 20)))
        let myProfileCoordinator = MyProfileCoordinator(presenter: myProfile)
        myProfileCoordinator.parentCoordinator = self
        myProfileRoot.viewModel = MyProfileViewModel(coordinator: myProfileCoordinator)
        childCoordinators.append(myProfileCoordinator)

        tabBarController.tabBar.tintColor = .baseGreen
        tabBarController.viewControllers = [home, shop, friends, myProfile]

        presenter.pushViewController(tabBarController, animated: true)
    }

    func tabBarConfig(rootViewController: UIViewController, tabBartitle: String, tabBarImage: UIImage) -> UINavigationController {

        let rootViewController = rootViewController
        let navigationController = UINavigationController(rootViewController: rootViewController)
        navigationController.tabBarItem.title = tabBartitle
        navigationController.tabBarItem.image = tabBarImage
        return navigationController
    }

    func childDidFinish(_ child: Coordinator?, completion: () -> Void) {

        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                completion()
                break
            }
        }
    }

    func finish() {

        parentCoordinator?.childDidFinish(self, completion: { [weak self] in
            self?.parentCoordinator?.start()
        })
    }
}
