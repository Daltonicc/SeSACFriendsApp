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

    let mapView: NMFNaverMapView = {
        let mapView = NMFNaverMapView()
        return mapView
    }()
    let genderStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.backgroundColor = .white
        stackView.layer.cornerRadius = 5
        stackView.layer.shadowOpacity = 0.5
        stackView.layer.shadowRadius = 5
        stackView.layer.shadowColor = UIColor.gray.cgColor
        stackView.layer.shadowOffset = CGSize(width: 1, height: 1)
        return stackView
    }()
    let allGenderButton: CustomButton = {
        let button = CustomButton()
        button.setTitle("전체", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .title4r
        button.layer.cornerRadius = 5
        return button
    }()
    let manButton: CustomButton = {
        let button = CustomButton()
        button.setTitle("남자", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .title4r
        button.layer.cornerRadius = 0
        return button
    }()
    let womanButton: CustomButton = {
        let button = CustomButton()
        button.setTitle("여자", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .title4r
        button.layer.cornerRadius = 5
        return button
    }()
    let gpsButton: CustomButton = {
        let button = CustomButton()
        button.setImage(Asset.Home.gpsImage.image, for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 5
        button.layer.shadowColor = UIColor.gray.cgColor
        button.layer.shadowOffset = CGSize(width: 1, height: 1)
        return button
    }()
    let statusButton: CustomButton = {
        let button = CustomButton()
        button.backgroundColor = .black
        button.setImage(Asset.Home.basicStatusFriendsImage.image, for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        button.layer.cornerRadius = 32
        button.tintColor = .white
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

        genderStackView.addArrangedSubview(allGenderButton)
        genderStackView.addArrangedSubview(manButton)
        genderStackView.addArrangedSubview(womanButton)
    }

    func setUpConstraint() {

        mapView.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview()
            make.bottom.equalTo(self.safeAreaLayoutGuide)
        }
        genderStackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.equalToSuperview().inset(60)
            make.width.equalTo(48)
            make.height.equalTo(144)
        }
        gpsButton.snp.makeConstraints { make in
            make.top.equalTo(genderStackView.snp.bottom).offset(16)
            make.leading.equalToSuperview().inset(16)
            make.width.height.equalTo(48)
        }
        statusButton.snp.makeConstraints { make in
            make.bottom.equalTo(self.safeAreaLayoutGuide).inset(16)
            make.trailing.equalToSuperview().inset(16)
            make.width.height.equalTo(64)
        }

    }
}
