//
//  MyChatTableViewCell.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/02/21.
//

import UIKit
import SnapKit

final class MyChatTableViewCell: UITableViewCell {

    let myChatView: UIView = {
        let view = UIView()
        return view
    }()
    let myChatLabel: UILabel = {
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

        contentView.addSubview(myChatView)
        myChatView.addSubview(myChatLabel)
    }

    func setUpConstraints() {

        myChatView.snp.makeConstraints { make in
            make.top.bottom.trailing.equalToSuperview().inset(5)
            make.leading.greaterThanOrEqualTo(contentView).inset(100)
        }
        myChatLabel.snp.makeConstraints { make in
            make.leading.bottom.top.equalToSuperview().inset(10)
            make.trailing.equalToSuperview().inset(25)
        }

    }
}
