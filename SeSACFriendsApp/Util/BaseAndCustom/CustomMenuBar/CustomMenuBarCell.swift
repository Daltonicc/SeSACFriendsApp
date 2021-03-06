//
//  CustomMenuBarCell.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/02/13.
//

import UIKit
import SnapKit

class CustomMenuBarCell: UICollectionViewCell {

    var tablabel: UILabel = {
        let label = UILabel()
        label.text = "Tab"
        label.textAlignment = .center
        label.font = .title3m
        label.textColor = .gray6
        return label
    }()

    override var isSelected: Bool {
        didSet{
            self.tablabel.textColor = isSelected ? .baseGreen : .gray6
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        setUpView()
        setUpConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

    }

    func setUpView() {

        self.addSubview(tablabel)
    }

    func setUpConstraints() {

        tablabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
