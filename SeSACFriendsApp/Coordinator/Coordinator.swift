//
//  Coordinator.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/01/23.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {

    var presenter: UINavigationController { get set }

    var childCoordinators: [Coordinator] { get set }

    func start()
}
