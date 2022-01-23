//
//  OnboardingCollectionViewCell.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/01/22.
//

import UIKit
import SnapKit

final class OnboardingCollectionViewCell: UICollectionViewCell {

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

    func cellConfiguration(item: Int) {

        switch item {
        case 0: imageView.image = Asset.onboardingImage1.image
        case 1: imageView.image = Asset.onboardingImage2.image
        case 2: imageView.image = Asset.onboardingImage3.image
        default: imageView.image = Asset.onboardingImage1.image
        }
    }
}
