//
//  HomeViewModel.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/02/08.
//

import UIKit

final class HomeViewModel {

    weak var coordinator: HomeCoordinator?

    let useCase: HomeUseCase

    init(coordinator: HomeCoordinator, useCase: HomeUseCase) {
        self.coordinator = coordinator
        self.useCase = useCase
    }

    func fetchAroundUserData(region: Int, latitude: Double, longitude: Double, completion: @escaping ([Double], [Double], [UIImage], String?) -> Void) {

        var friendsLatitudeArray: [Double] = []
        var friendsLongitudeArray: [Double] = []
        var friendsSeSACImageArray: [UIImage] = []

        let parameter: [String: Any] = [
            "region": region,
            "lat": latitude,
            "long": longitude
        ]

        useCase.fetchAroundUserData(parameter: parameter) { [weak self] (result) in
            switch result {
            case let .success(data):
                for i in data.otherUsers {
                    friendsLatitudeArray.append(i.userLatitude)
                    friendsLongitudeArray.append(i.userLongitude)

                    let image = self?.sesacImageChangeIntToUIImage(sesacimage: i.sesacImage)
                    friendsSeSACImageArray.append(image!)
                }
                completion(friendsLatitudeArray, friendsLongitudeArray, friendsSeSACImageArray, nil)

            case let .failure(error):
                completion(friendsLatitudeArray, friendsLongitudeArray, friendsSeSACImageArray, error.errorDescription)
            }
        }

    }

    func sesacImageChangeIntToUIImage(sesacimage: Int) -> UIImage {

        switch sesacimage {
        case 0: return Asset.Home.basicSeSACImage.image
        case 1: return Asset.Home.strongSeSACImage.image
        case 2: return Asset.Home.mintSeSACImage.image
        case 3: return Asset.Home.basicSeSACImage.image
        case 4: return Asset.Home.goldSeSACImage.image
        default: return Asset.Home.basicSeSACImage.image
        }
    }
}
