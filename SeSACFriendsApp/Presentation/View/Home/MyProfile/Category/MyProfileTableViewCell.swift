//
//  MyProfileTableViewCell.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/02/02.
//

import UIKit
import SnapKit

final class MyProfileTableViewCell: UITableViewCell {

    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .title2r
        label.text = "titletitletitletitle"
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setUpView()
        setUpConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

    }

    func setUpView() {

        contentView.addSubview(iconImageView)
        contentView.addSubview(titleLabel)
    }

    func setUpConstraints() {

        iconImageView.snp.makeConstraints { make in
            make.width.height.equalTo(24)
        }
        titleLabel.snp.makeConstraints { make in

        }
    }
}
