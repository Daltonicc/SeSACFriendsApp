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
            make.top.equalTo(self).inset(24)
            make.bottom.equalTo(self).inset(24)
            make.leading.equalTo(self).inset(15)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self).inset(24)
            make.leading.equalTo(iconImageView.snp.trailing).offset(10)
            make.bottom.equalTo(self).inset(24)
            make.width.equalTo(100)
        }
    }

    func cellConfiguration(row: Int) {

        switch row {
        case 0:
            titleLabel.text = "공지사항"
            iconImageView.image = Asset.ProfileCategory.info.image
        case 1:
            titleLabel.text = "자주 묻는 질문"
            iconImageView.image = Asset.ProfileCategory.faq.image
        case 2:
            titleLabel.text = "1:1 문의"
            iconImageView.image = Asset.ProfileCategory.qa.image
        case 3:
            titleLabel.text = "알림 설정"
            iconImageView.image = Asset.ProfileCategory.alert.image
        case 4:
            titleLabel.text = "이용 약관"
            iconImageView.image = Asset.ProfileCategory.permit.image
        default:
            titleLabel.text = "default"
            iconImageView.image = Asset.ProfileCategory.info.image
        }
    }
}
