//
//  FindFriendsViewModel.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/02/13.
//

import Foundation
import Alamofire
import UIKit

enum SuspendFindFriendsCase {
    case tapFindingSuspendButton
    case tapChangeHobbyButton
}

final class FindFriendsViewModel: ViewModel {

    weak var coordinator: HomeCoordinator?
    let useCase: FindFriendsUseCase

    var yourRegion: Int
    var yourLatitude: Double
    var yourLongitude: Double
    var youWantHobbyList: [String] = []

    var friendsNameArray: [String] = []
    var friendsSeSACImageArray: [UIImage] = []
    var friendsBackgroundImage: [UIImage] = []
    var friendsIDArray: [String] = []

    var acceptFriendsNameArray: [String] = []
    var acceptFriendsSeSACImageArray: [UIImage] = []
    var acceptFriendsBackgroundImage: [UIImage] = []
    var acceptFriendsIDArray: [String] = []

    var suspendFindFriendsCase: SuspendFindFriendsCase?

    init(coordinator: HomeCoordinator, yourRegion: Int, yourLatitude: Double, yourLongitude: Double, youWantHobbyList: [String], useCase: FindFriendsUseCase) {
        self.coordinator = coordinator
        self.yourRegion = yourRegion
        self.yourLatitude = yourLatitude
        self.yourLongitude = yourLongitude
        self.youWantHobbyList = youWantHobbyList
        self.useCase = useCase
    }

    deinit {
        print("FindFriendsViewModel Deinit")
    }

    func fetchAroundUserData(completion: @escaping (String?) -> Void) {

        let parameter: [String: Any] = [
            "region": yourRegion,
            "lat": yourLatitude,
            "long": yourLongitude
        ]

        // 중복 취미 안쌓이게 처리. -> 처리는 했지만 너무 코드가 더러움;; 개선 필요.
        useCase.fetchAroundUserData(parameter: parameter) { [weak self] (result) in
            switch result {
            case let .success(data):
                for i in data.otherUsers {
                    for j in i.wantHobby {
                        if self?.youWantHobbyList.contains(j) ?? false {
                            if !(self?.friendsNameArray.contains(i.nickname) ?? false) {
                                self?.friendsIDArray.append(i.userId)
                                self?.friendsNameArray.append(i.nickname)
                                self?.friendsBackgroundImage.append((self?.sesacBackgroundImageIntToUIImage(backgroundImage: i.backgroundImage))!)
                                self?.friendsSeSACImageArray.append((self?.sesacImageChangeIntToUIImage(sesacimage: i.sesacImage))!)
                            }
                        }
                    }
                }
                for i in data.otherRequestUsers {
                    self?.acceptFriendsIDArray.append(i.userId)
                    self?.acceptFriendsNameArray.append(i.nickname)
                    self?.acceptFriendsBackgroundImage.append((self?.sesacBackgroundImageIntToUIImage(backgroundImage: i.backgroundImage))!)
                    self?.acceptFriendsSeSACImageArray.append((self?.sesacImageChangeIntToUIImage(sesacimage: i.sesacImage))!)
                }
                completion(nil)
            case let .failure(error):
                completion(error.errorDescription)
            }
        }
    }

    func suspendFindFriends(completion: @escaping (String) -> Void) {

        useCase.suspendFindFriends { [weak self] error in
            if let error = error {
                completion(error.errorDescription!)
            } else {
                // 어떤 버튼 눌렀는지에 따라 분기처리.
                switch self?.suspendFindFriendsCase {
                case .tapChangeHobbyButton: self?.coordinator?.presenter.popViewController(animated: true)
                case .tapFindingSuspendButton: self?.coordinator?.presenter.popToRootViewController(animated: true)
                default: self?.coordinator?.presenter.popViewController(animated: true)
                }
            }
        }
    }

    func checkMyQueueState(completion: @escaping (String?) -> Void) {

        useCase.checkMyQueueState { (result) in
            switch result {
            case let .success(data):
                if data.matched == 1 {
                    
                } else {
                    completion(nil)
                }
            case let .failure(error):
                completion(error.errorDescription)
            }
        }
    }

    func showRequestView(friendsID: String) {
        coordinator?.showAlertView(alertStyle: .friendsRequest, friendsID: friendsID)
    }

    func showAcceptView(friendsID: String) {
        coordinator?.showAlertView(alertStyle: .friendsAccept, friendsID: friendsID)
    }
}
