//
//  FindHobbyView.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/02/10.
//

import UIKit
import SnapKit

final class FindHobby: UIView, ViewRepresentable {

    let searchController: UISearchController = {
        let searchController = UISearchController()
        searchController.searchBar.searchTextField.placeholder = "띄어쓰기로 복수 입력이 가능해요"
        return searchController
    }()
    let aroundHobbyLabel: UILabel = {
        let label = UILabel()
        label.text = "지금 주변에는"
        label.font = .title6r
        return label
    }()
    let aroundHobbyCollectionView: UICollectionView = {
        let collectionView = UICollectionView()
        return collectionView
    }()
    let youWantHobbyLabel: UILabel = {
        let label = UILabel()
        label.text = "내가 하고싶은"
        label.font = .title6r
        return label
    }()
    let youWantHobbyCollectionView: UICollectionView = {
        let collectionView = UICollectionView()
        return collectionView
    }()
    let findSeSACButton: CustomButton = {
        let button = CustomButton()
        button.buttonState = .fill
        button.setTitle("새싹 찾기", for: .normal)
        return button
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)

        setUpView()
        setUpConstraint()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setUpView() {

        addSubview(aroundHobbyLabel)
        addSubview(aroundHobbyCollectionView)
        addSubview(youWantHobbyLabel)
        addSubview(youWantHobbyCollectionView)
        addSubview(findSeSACButton)
    }

    func setUpConstraint() {

    }
}
