//
//  FindHobbyViweModel.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/02/12.
//

import UIKit

final class FindHobbyViewModel {

    weak var coordinator: HomeCoordinator?
    let useCase: HomeUseCase

    var yourRegion: Int
    var yourLatitude: Double
    var yourLongitude: Double

    var hobbyList: [String] = []
    var youWantHobbyList: [String] = []
    var youAddHobbyList: [String] = []

    init(coordinator: HomeCoordinator, yourRegion: Int, yourLatitude: Double, yourLongitude: Double, useCase: HomeUseCase) {
        self.coordinator = coordinator
        self.yourRegion = yourRegion
        self.yourLatitude = yourLatitude
        self.yourLongitude = yourLongitude
        self.useCase = useCase
    }

    func fetchHobbyData(completion: @escaping (String?) -> Void) {

        let parameter: [String: Any] = [
            "region": yourRegion,
            "lat": yourLatitude,
            "long": yourLongitude
        ]

        useCase.fetchAroundUserData(parameter: parameter) { [weak self] (result) in
            switch result {
            case let .success(data):
                self?.hobbyList = data.recommendHobbyList
                for i in data.otherUsers {
                    for j in i.wantHobby {
                        self?.hobbyList.append(j)
                    }
                }
                print(self?.hobbyList)
                completion(nil)

            case let .failure(error):
                completion(error.errorDescription)
            }
        }
    }
    
}
