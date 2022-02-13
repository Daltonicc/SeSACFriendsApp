//
//  CustomCardView.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/02/13.
//

import UIKit
import SnapKit

final class CustomCardView: UIView, ViewRepresentable {

    let cardBackgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Asset.ProfileDetail.seSACBackground.image
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()
    let cardSesacImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Asset.ProfileDetail.seSACImage.image
        return imageView
    }()
    let cardButton: CustomButton = {
        let button = CustomButton()
        button.backgroundColor = .error
        button.setTitle("요청하기", for: .normal)
        button.titleLabel?.font = .title3m
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    let titleView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.gray3.cgColor
        return view
    }()
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "김새싹"
        label.font = .title1m
        return label
    }()
    let detailButton: UIButton = {
        let button = UIButton()
        button.tintColor = .black
        button.setImage(UIImage(systemName: "chevron.down"), for: .normal)
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

        addSubview(cardBackgroundImageView)
        addSubview(cardSesacImageView)
        addSubview(cardButton)
        addSubview(titleView)
        titleView.addSubview(nameLabel)
        titleView.addSubview(detailButton)
    }

    func setUpConstraint() {

        cardBackgroundImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(194)
        }
        cardSesacImageView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-60)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(184)
        }
        cardButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(12)
            make.trailing.equalToSuperview().inset(12)
            make.width.equalTo(80)
            make.height.equalTo(40)
        }
        titleView.snp.makeConstraints { make in
            make.top.equalTo(cardBackgroundImageView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(58)
        }
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(titleView).inset(16)
            make.bottom.equalTo(titleView).inset(16)
            make.leading.equalTo(titleView).inset(16)
        }
        detailButton.snp.makeConstraints { make in
            make.top.equalTo(titleView).inset(16)
            make.bottom.equalTo(titleView).inset(16)
            make.trailing.equalTo(titleView).inset(16)
            make.width.equalTo(16)
        }

    }
}
