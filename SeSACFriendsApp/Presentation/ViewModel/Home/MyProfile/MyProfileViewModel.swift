//
//  ProfileViewModel.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/02/05.
//

import UIKit
import RxCocoa
import RxSwift

final class MyProfileViewModel: ViewModel {

    weak var coordinator: MyProfileCoordinator?

    var userData: UserData?

    init(coordinator: MyProfileCoordinator) {
        self.coordinator = coordinator
    }

    deinit {
        print("MyProfileViewModel Deinit")
    }

    func showDetailProfile() {
        coordinator?.showProfileView()
    }
}
