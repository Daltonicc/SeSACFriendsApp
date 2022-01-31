//
//  CoordinatorFinishDelegate.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/01/31.
//

import Foundation

protocol CoordinatorFinishDelegate: AnyObject {
    func coordinatorDidFinish(childCoordinator: Coordinator)
}
