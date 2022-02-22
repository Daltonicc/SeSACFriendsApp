//
//  YourChatTableViewCell.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/02/21.
//

import UIKit
import SnapKit

final class YourChatTableViewCell: UITableViewCell {

    let yourChatView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.gray3.cgColor
        return view
    }()
    var yourChatLabel: UILabel = {
        let label = UILabel()
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

        contentView.addSubview(yourChatView)
        yourChatView.addSubview(yourChatLabel)
    }

    func setUpConstraints() {

        yourChatView.snp.makeConstraints { make in
            make.top.bottom.leading.equalToSuperview().inset(5)
            make.trailing.lessThanOrEqualTo(contentView).inset(100)
        }
        yourChatLabel.snp.makeConstraints { make in
            make.trailing.bottom.top.equalToSuperview().inset(10)
            make.leading.equalToSuperview().inset(25)
        }

    }
}
