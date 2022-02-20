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
    let emptyImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Asset.Home.emptyAroundImage.image
        return imageView
    }()

    var viewModel: FindFriendsViewModel?

    var item = 0
    var friendsCount = 0

    var friendsNameArray: [String] = []
    var friendsSeSACImageArray: [UIImage] = []
    var friendsBackgroundImage: [UIImage] = []
    var friendsIDArray: [String] = []

    var acceptFriendsNameArray: [String] = []
    var acceptFriendsSeSACImageArray: [UIImage] = []
    var acceptFriendsBackgroundImage: [UIImage] = []
    var acceptFriendsIDArray: [String] = []

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
        addSubview(emptyImageView)

        cardTableView.delegate = self
        cardTableView.dataSource = self
        cardTableView.register(CardTableViewCell.self, forCellReuseIdentifier: CardTableViewCell.identifier)
    }

    func setUpConstraints() {

        cardTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        emptyImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-50)
            make.width.equalTo(252)
            make.height.equalTo(158)
        }
        
    }

    func requestCellConfig() {

        if friendsNameArray.isEmpty {
            emptyImageView.isHidden = false
            emptyImageView.image = Asset.Home.emptyAroundImage.image
        } else {
            emptyImageView.isHidden = true
            cardTableView.reloadData()
        }
    }

    func acceptCellConfig() {

        if acceptFriendsNameArray.isEmpty {
            emptyImageView.isHidden = false
            emptyImageView.image = Asset.Home.emptyRequestImage.image
        } else {
            emptyImageView.isHidden = true
            cardTableView.reloadData()
        }
    }

    @objc func requestCardButtonClicked(selectedButton: CustomButton) {
        addPressAnimationToButton(selectedButton) { [weak self] _ in
            self?.viewModel?.showRequestView(friendsID: self?.friendsIDArray[selectedButton.tag] ?? "")
        }
    }

    @objc func acceptCardButtonClicked(selectedButton: CustomButton) {
        addPressAnimationToButton(selectedButton) { [weak self] _ in
            self?.viewModel?.showAcceptView(friendsID: self?.acceptFriendsIDArray[selectedButton.tag] ?? "")
        }
    }
}

extension PageCollectionViewCell: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if item == 0 {
            return friendsNameArray.count
        } else {
            return acceptFriendsNameArray.count
        }

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: CardTableViewCell.identifier, for: indexPath) as? CardTableViewCell else { return UITableViewCell() }

        cell.cellConfig(item: item)

        let row = indexPath.row

        if item == 0 {
            cell.cardView.nameLabel.text = friendsNameArray[row]
            cell.cardView.cardSesacImageView.image = friendsSeSACImageArray[row]
            cell.cardView.cardBackgroundImageView.image = friendsBackgroundImage[row]

            cell.cardView.cardButton.tag = row
            cell.cardView.cardButton.addTarget(self, action: #selector(requestCardButtonClicked(selectedButton:)), for: .touchUpInside)
        } else {
            cell.cardView.nameLabel.text = acceptFriendsNameArray[row]
            cell.cardView.cardSesacImageView.image = acceptFriendsSeSACImageArray[row]
            cell.cardView.cardBackgroundImageView.image = acceptFriendsBackgroundImage[row]

            cell.cardView.cardButton.tag = row
            cell.cardView.cardButton.addTarget(self, action: #selector(acceptCardButtonClicked(selectedButton:)), for: .touchUpInside)
        }

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 272
    }

}
