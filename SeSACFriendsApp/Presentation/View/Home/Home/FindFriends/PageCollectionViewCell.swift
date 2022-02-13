//
//  PageCollectionViewCell.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/02/13.
//

import UIKit
import SnapKit

final class PageCollectionViewCell: UICollectionViewCell {

    let cardTableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()

    var item = 0

    override init(frame: CGRect) {
        super.init(frame: frame)

        setUpView()
        setUpConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

    }

    func setUpView() {

        addSubview(cardTableView)

        cardTableView.delegate = self
        cardTableView.dataSource = self
        cardTableView.register(CardTableViewCell.self, forCellReuseIdentifier: CardTableViewCell.identifier)
    }

    func setUpConstraints() {

        cardTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    func cellConfig(item: Int) {

        if item == 0 {

        } else {

        }
    }
}

extension PageCollectionViewCell: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: CardTableViewCell.identifier, for: indexPath) as? CardTableViewCell else { return UITableViewCell() }

        cell.cellConfig(item: item)

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 272
    }

}
