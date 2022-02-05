//
//  MyProfileView.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/02/01.
//

import UIKit
import SnapKit

final class MyProfileView: UIView, ViewRepresentable {

    let topView: UIView = {
        let view = UIView()
        return view
    }()
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Asset.ProfileCategory.ssacProfile.image
        imageView.layer.cornerRadius = 25
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.gray3.cgColor
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    let yourNameLabel: UILabel = {
        let label = UILabel()
        label.text = "박새싹"
        label.font = .title1m
        label.textAlignment = .center
        return label
    }()
    let profileButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        button.tintColor = .black
        return button
    }()

    let tableView: UITableView = {
        let tableView = UITableView()
        return tableView
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

        addSubview(topView)
        addSubview(tableView)

        topView.addSubview(profileImageView)
        topView.addSubview(yourNameLabel)
        topView.addSubview(profileButton)
    }

    func setUpConstraint() {

        topView.snp.makeConstraints { make in
            make.top.equalTo(self).inset(70)
            make.leading.equalTo(self)
            make.trailing.equalTo(self)
            make.height.equalTo(96)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom)
            make.leading.equalTo(self)
            make.trailing.equalTo(self)
            make.bottom.equalTo(self)
        }
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.top).inset(20)
            make.leading.equalTo(topView.snp.leading).inset(15)
            make.bottom.equalTo(topView.snp.bottom).inset(26)
            make.height.width.equalTo(50)
        }
        yourNameLabel.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.top).inset(37)
            make.leading.equalTo(profileImageView.snp.trailing).offset(13)
            make.bottom.equalTo(topView.snp.bottom).inset(33)
        }
        profileButton.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.top).inset(39)
            make.bottom.equalTo(topView.snp.bottom).inset(39)
            make.trailing.equalTo(topView.snp.trailing).inset(22.5)
            make.width.equalTo(9)
        }
    }

}
