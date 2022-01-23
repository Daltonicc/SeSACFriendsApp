//
//  OnboardingCollectionViewCell.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/01/22.
//

import UIKit
import SnapKit

class OnboardingCollectionViewCell: UICollectionViewCell {

    static let identifier = "OnboardingCollectionViewCell"

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
        case 0: imageView.image = UIImage(named: "OnboardingImage1")
        case 1: imageView.image = UIImage(named: "OnboardingImage2")
        case 2: imageView.image = UIImage(named: "OnboardingImage3")
        default: imageView.image = UIImage(named: "OnboardingImage1")
        }
    }
}
