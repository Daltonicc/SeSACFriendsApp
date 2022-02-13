//
//  CardTableViewCell.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/02/13.
//

import UIKit
import SnapKit

final class CardTableViewCell: UITableViewCell {

    let cardView: CustomCardView = {
        let cardView = CustomCardView()
        return cardView
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

        contentView.addSubview(cardView)
    }

    func setUpConstraints() {

        cardView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(10)
            make.centerX.equalToSuperview()
            make.height.equalTo(252)
            make.width.equalTo(UIScreen.main.bounds.width - 32)
        }
    }

    func cellConfig(item: Int) {

        if item == 0 {
            cardView.cardButton.setTitle("요청하기", for: .normal)
            cardView.cardButton.buttonState = .request
        } else {
            cardView.cardButton.setTitle("수락하기", for: .normal)
            cardView.cardButton.buttonState = .accept
        }
    }
}
