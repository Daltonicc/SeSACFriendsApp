//
//  HomeViewController.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/01/31.
//

import UIKit
import NMapsMap

final class HomeViewController: BaseViewController {

    let mainView = HomeView()

    var viewModel: HomeViewModel?

    let centerMarker = NMFMarker()

    override func loadView() {
        super.loadView()

        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func setViewConfig() {
        super.setViewConfig()

        mainView.mapView.addCameraDelegate(delegate: self)
        centerMarker.iconImage = NMFOverlayImage(image: Asset.Home.markerImage.image.resized(to: CGSize(width: 34, height: 45)))

    }

    override func textfieldConfig() {
        super.textfieldConfig()
        
    }
}

extension HomeViewController: NMFMapViewCameraDelegate {

    func mapView(_ mapView: NMFMapView, cameraIsChangingByReason reason: Int) {

    }

    func mapView(_ mapView: NMFMapView, cameraDidChangeByReason reason: Int, animated: Bool) {

        let cameraPosition = mapView.cameraPosition
        centerMarker.position = NMGLatLng(lat: cameraPosition.target.lat, lng: cameraPosition.target.lng)
        centerMarker.mapView = mapView
        print("reason")
    }
}
