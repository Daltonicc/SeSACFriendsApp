//
//  AroundHobbyCollectionViewCell.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/02/12.
//

import Foundation

import UIKit
import SnapKit

final class AroundHobbyCollectionViewCell: UICollectionViewCell {

    let cellView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 5
        view.layer.borderColor = UIColor.gray4.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    let aroundHobbyLabel: UILabel = {
        let label = UILabel()
        label.font = .title4r
        label.text = "aaaaaaa"
        label.textAlignment = .center
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)

        setUpCell()
        setUpConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setUpCell() {

        contentView.addSubview(cellView)
        cellView.addSubview(aroundHobbyLabel)
    }

    func setUpConstraints() {

        cellView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        aroundHobbyLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.leading.equalToSuperview().inset(8)
            make.trailing.equalToSuperview().inset(8)
            make.bottom.equalToSuperview().inset(8)
        }
    }
}
