//
//  HomeViewModel.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/02/08.
//

import UIKit
import RxSwift
import RxCocoa
import NMapsMap

final class HomeViewModel {

    weak var coordinator: HomeCoordinator?

    let useCase: HomeUseCase

    let disposeBag = DisposeBag()

    var gender = -1
    var markerList: [NMFMarker] = []

    var yourRegion: Int = 0
    var yourLatitude: Double = 0
    var yourLongitude: Double = 0

    init(coordinator: HomeCoordinator, useCase: HomeUseCase) {
        self.coordinator = coordinator
        self.useCase = useCase
    }

    func fetchAroundUserData(region: Int, latitude: Double, longitude: Double, mapView: NMFMapView, completion: @escaping (String?) -> Void) {

        let parameter: [String: Any] = [
            "region": region,
            "lat": latitude,
            "long": longitude
        ]

        yourRegion = region
        yourLatitude = latitude
        yourLongitude = longitude

        var friendsLatitudeArray: [Double] = []
        var friendsLongitudeArray: [Double] = []
        var friendsSeSACImageArray: [UIImage] = []

        useCase.fetchAroundUserData(parameter: parameter) { [weak self] (result) in
            switch result {
            case let .success(data):
                for i in data.otherUsers {
                    if i.gender == self?.gender {
                        friendsLatitudeArray.append(i.userLatitude)
                        friendsLongitudeArray.append(i.userLongitude)
                        let image = self?.sesacImageChangeIntToUIImage(sesacimage: i.sesacImage)
                        friendsSeSACImageArray.append(image!)
                    } else if self?.gender == -1 {
                        friendsLatitudeArray.append(i.userLatitude)
                        friendsLongitudeArray.append(i.userLongitude)
                        let image = self?.sesacImageChangeIntToUIImage(sesacimage: i.sesacImage)
                        friendsSeSACImageArray.append(image!)
                    }
                }
                self?.AddFriends(mapView: mapView, latitude: friendsLatitudeArray, longitude: friendsLongitudeArray, image: friendsSeSACImageArray)

                completion(nil)

            case let .failure(error):
                completion(error.errorDescription)
            }
        }
    }

    func AddFriends(mapView: NMFMapView, latitude: [Double], longitude: [Double], image: [UIImage]) {

        // 기존 마커 제거
        for i in 0..<markerList.count {
            markerList[i].mapView = nil
        }

        // 새로운 마커 추가
        for i in 0..<latitude.count {
            let sesacMarker = NMFMarker()
            sesacMarker.position = NMGLatLng(lat: latitude[i], lng: longitude[i])
            sesacMarker.iconImage = NMFOverlayImage(image: image[i].resized(to: CGSize(width: 83, height: 83)))
            markerList.append(sesacMarker)
            sesacMarker.mapView = mapView
        }
    }

    func checkLookingForGender(allButton: CustomButton, manButton: CustomButton, womanButton: CustomButton, completion: @escaping () -> Void) {

        allButton.rx.tap
            .bind { [weak self] in
                // 전체 버튼만 유독 안눌림;
                if allButton.buttonState == .base {
                    allButton.buttonState = .fill
                    womanButton.buttonState = .base
                    manButton.buttonState = .base
                    self?.gender = -1
                    completion()
                }
            }
            .disposed(by: disposeBag)

        manButton.rx.tap
            .bind { [weak self] in
                if manButton.buttonState == .base {
                    manButton.buttonState = .fill
                    womanButton.buttonState = .base
                    allButton.buttonState = .base
                    self?.gender = 1
                    completion()

                }
            }
            .disposed(by: disposeBag)

        womanButton.rx.tap
            .bind { [weak self] in
                if womanButton.buttonState == .base {
                    womanButton.buttonState = .fill
                    manButton.buttonState = .base
                    allButton.buttonState = .base
                    self?.gender = 0
                    completion()
                    
                }
            }
            .disposed(by: disposeBag)
    }

    func showFindHobbyView() {
        coordinator?.showFindHobbyView(region: yourRegion, yourLatitude: yourLatitude, yourLongitude: yourLongitude)
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
