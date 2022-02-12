//
//  HomeViewController.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/01/31.
//

import UIKit
import CoreLocation
import NMapsMap
import RxCocoa
import RxSwift
import Toast

final class HomeViewController: BaseViewController {

    let mainView = HomeView()

    var viewModel: HomeViewModel?

    var locationManager: CLLocationManager!
    let centerMarker = NMFMarker()

    var requestGreedRegion = 0
    var requestLatitude: Double = 0
    var requestLongitude: Double = 0

    let disposeBag = DisposeBag()

    override func loadView() {
        super.loadView()

        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let moveToUserLocation = NMFCameraUpdate(scrollTo: NMGLatLng(lat: 37.517819364682694, lng: 126.88647317074734))
        mainView.mapView.mapView.moveCamera(moveToUserLocation)

        //나중에 지우삼
        print(UserDefaults.standard.string(forKey: UserDefaultKey.idToken))

    }

    override func setViewConfig() {
        super.setViewConfig()

        // 위치 권한 설정
        locationManager = CLLocationManager()
        locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()

        // 센터 마커 설정
        mainView.mapView.showZoomControls = false
        mainView.mapView.mapView.addCameraDelegate(delegate: self)
        centerMarker.iconImage = NMFOverlayImage(image: Asset.Home.markerImage.image.resized(to: CGSize(width: 34, height: 45)))

        // 버튼 세팅
        mainView.gpsButton.rx.tap
            .bind { [weak self] in
                self?.viewModel?.fetchAroundUserData(region: self?.requestGreedRegion ?? 0,
                                                     latitude: self?.requestLatitude ?? 0,
                                                     longitude: self?.requestLongitude ?? 0,
                                                     mapView: self?.mainView.mapView.mapView ?? NMFMapView(),
                                                     completion: { [weak self] errorMessage in
                    self?.mainView.makeToast(errorMessage)
                })
            }
            .disposed(by: disposeBag)
        
        viewModel?.checkLookingForGender(allButton: mainView.allGenderButton,
                                         manButton: mainView.manButton,
                                         womanButton: mainView.womanButton,
                                         completion: { [weak self] in
            self?.viewModel?.fetchAroundUserData(region: self?.requestGreedRegion ?? 0,
                                                 latitude: self?.requestLatitude ?? 0,
                                                 longitude: self?.requestLongitude ?? 0,
                                                 mapView: self?.mainView.mapView.mapView ?? NMFMapView(),
                                                 completion: { [weak self] errorMessage in
                self?.mainView.makeToast(errorMessage)
            })
        })

        mainView.statusButton.rx.tap
            .bind { [weak self] in
                self?.addPressAnimationToButton(self?.mainView.statusButton ?? CustomButton()) { [weak self] _ in
                    self?.viewModel?.showFindHobbyView()
                }
            }
            .disposed(by: disposeBag)

    }
}

extension HomeViewController: NMFMapViewCameraDelegate {

    func mapView(_ mapView: NMFMapView, cameraDidChangeByReason reason: Int, animated: Bool) {

        requestLatitude = mapView.cameraPosition.target.lat
        requestLongitude = mapView.cameraPosition.target.lng

        centerMarker.position = NMGLatLng(lat: requestLatitude, lng: requestLongitude)
        centerMarker.mapView = mapView

        requestGreedRegion = Int(String(requestLatitude.changeToGreedLatitude) + String(requestLongitude.changeToGreedLongitude))!

    }

    func mapViewCameraIdle(_ mapView: NMFMapView) {

        viewModel?.fetchAroundUserData(region: requestGreedRegion,
                                             latitude: requestLatitude,
                                             longitude: requestLongitude,
                                             mapView: mainView.mapView.mapView,
                                             completion: { [weak self] message in
            self?.mainView.makeToast(message)
        })
    }
}

// 위치 권한 메서드
extension HomeViewController: CLLocationManagerDelegate {

    func checkUserLocationServicesAuthorization() {

        let authorizationStatus: CLAuthorizationStatus

        authorizationStatus = locationManager.authorizationStatus

        if CLLocationManager.locationServicesEnabled() {
            checkCurrentLocationAuthorization(authorizationStatus)
        } else {
            locationAlertConfigure()
        }
    }

    func checkCurrentLocationAuthorization(_ authorizationStatus: CLAuthorizationStatus) {

        switch authorizationStatus {
        case .notDetermined:
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        case .restricted, .denied:
            locationAlertConfigure()
        case .authorizedAlways:
            print("Always")
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        @unknown default:
            print("Default")
        }

        //정확도 체크 - 풀 정확도시 정확한 위치, 리듀스 정확도시에는 인근의 주요 관공서나 위치를 찍어줌.
        let accurancyState = locationManager.accuracyAuthorization
        switch accurancyState {
        case .fullAccuracy:
            print("Full Accuracy")
        case .reducedAccuracy:
            print("Reduce Accuracy")
        @unknown default:
            print("Default Accuracy")
        }
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {

        checkUserLocationServicesAuthorization()
    }
}
