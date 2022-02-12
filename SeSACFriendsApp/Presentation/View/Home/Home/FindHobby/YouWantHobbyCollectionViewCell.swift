//
//  YouWantHobbyCollectionViewCell.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/02/12.
//

import Foundation

import UIKit
import SnapKit

final class YouWantHobbyCollectionViewCell: UICollectionViewCell {

    let cellView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 5
        view.layer.borderColor = UIColor.baseGreen.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    let youWantHobbyLabel: UILabel = {
        let label = UILabel()
        label.font = .title4r
        label.textColor = .baseGreen
        label.text = "aaaaaaa"
        label.textAlignment = .center
        return label
    }()
    let cancelImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "xmark")
        imageView.tintColor = .baseGreen
        imageView.contentMode = .scaleAspectFill
        return imageView
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
        cellView.addSubview(youWantHobbyLabel)
        cellView.addSubview(cancelImage)

    }

    func setUpConstraints() {

        cellView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        youWantHobbyLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(8)
        }
        cancelImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(youWantHobbyLabel.snp.trailing).offset(5)
            make.width.height.equalTo(16)
        }
    }
}
