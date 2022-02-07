//
//  HomeViewController.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/01/31.
//

import UIKit
import NMapsMap

final class HomeViewController: BaseViewController {

    override func loadView() {
        super.loadView()

    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let mapView = NMFMapView(frame: view.frame)
        view.addSubview(mapView)

    }

    override func setViewConfig() {
        super.setViewConfig()

    }

    override func textfieldConfig() {
        super.textfieldConfig()
        
    }
}
