//
//  HomeView.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/02/07.
//

import UIKit
import SnapKit
import NMapsMap

final class HomeView: UIView, ViewRepresentable {

    let mapView: NMFMapView = {
        let mapView = NMFMapView()
        return mapView
    }()
    let genderStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()
    let allGenderButton: CustomButton = {
        let button = CustomButton()
        button.setTitle("전체", for: .normal)
        return button
    }()
    let manButton: CustomButton = {
        let button = CustomButton()
        button.setTitle("남자", for: .normal)
        return button
    }()
    let womanButton: CustomButton = {
        let button = CustomButton()
        button.setTitle("여자", for: .normal)
        return button
    }()
    let gpsButton: CustomButton = {
        let button = CustomButton()
        
        return button
    }()
    let statusButton: CustomButton = {
        let button = CustomButton()
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setUpView()
        setUpConstraint()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setUpView() {

        addSubview(mapView)
        addSubview(genderStackView)
        addSubview(gpsButton)
        addSubview(statusButton)

        genderStackView.addSubview(allGenderButton)
        genderStackView.addSubview(manButton)
        genderStackView.addSubview(womanButton)
    }

    func setUpConstraint() {

        mapView.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(40)
        }
        genderStackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.equalToSuperview().inset(40)
            make.width.equalTo(48)
            make.height.equalTo(144)
        }

    }
}
