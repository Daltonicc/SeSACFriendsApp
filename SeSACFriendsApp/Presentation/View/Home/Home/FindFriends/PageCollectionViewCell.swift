//
//  PageCollectionViewCell.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/02/13.
//

import UIKit
import SnapKit

final class PageCollectionViewCell: UICollectionViewCell {

    var viewlabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 40, weight: .bold)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setUpView()
        setUpConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

    }

    func setUpView() {

        self.addSubview(viewlabel)
    }

    func setUpConstraints() {

        viewlabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
