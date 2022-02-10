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
    }

    override func setViewConfig() {
        super.setViewConfig()

        locationManager = CLLocationManager()
        locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()

        mainView.mapView.showZoomControls = false
        mainView.mapView.mapView.addCameraDelegate(delegate: self)
        centerMarker.iconImage = NMFOverlayImage(image: Asset.Home.markerImage.image.resized(to: CGSize(width: 34, height: 45)))

        mainView.gpsButton.rx.tap
            .bind { [weak self] in
                self?.mainView.mapView.mapView.positionMode = .compass
                self?.viewModel?.fetchAroundUserData(region: self?.requestGreedRegion ?? 0,
                                                     latitude: self?.requestLatitude ?? 0,
                                                     longitude: self?.requestLongitude ?? 0,
                                                     completion: { [weak self] latitude, longitude, image, message in
                    self?.checkErrorAndThenAddFriends(message: message, latitude: latitude, longitude: longitude, image: image)
                })
            }
            .disposed(by: disposeBag)
    }

    func checkErrorAndThenAddFriends(message: String?, latitude: [Double], longitude: [Double], image: [UIImage]) {
        //에러 있으면 토스트
        guard message == nil else {
            mainView.makeToast(message)
            return
        }

        for i in 0..<latitude.count {
            let sesacMarker = NMFMarker()
            sesacMarker.position = NMGLatLng(lat: latitude[i], lng: longitude[i])
            sesacMarker.iconImage = NMFOverlayImage(image: image[i].resized(to: CGSize(width: 83, height: 83)))
            sesacMarker.mapView = mainView.mapView.mapView
        }
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

        viewModel?.fetchAroundUserData(region: self.requestGreedRegion,
                                             latitude: self.requestLatitude,
                                             longitude: self.requestLongitude,
                                             completion: { [weak self] latitude, longitude, image, message in
            self?.checkErrorAndThenAddFriends(message: message, latitude: latitude, longitude: longitude, image: image)
        })
    }
}

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
