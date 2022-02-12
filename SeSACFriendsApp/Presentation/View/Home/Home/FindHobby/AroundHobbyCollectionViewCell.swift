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

    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .white
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

        contentView.addSubview(imageView)
    }

    func setUpConstraints() {

        imageView.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top)
            make.leading.equalTo(self.snp.leading)
            make.trailing.equalTo(self.snp.trailing)
            make.bottom.equalTo(self.snp.bottom)
        }
    }
}
