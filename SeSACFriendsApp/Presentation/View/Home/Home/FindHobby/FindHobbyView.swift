//
//  FindHobbyView.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/02/10.
//

import UIKit
import SnapKit

final class FindHobbyView: UIView, ViewRepresentable {

    let searchBar: UISearchBar = {
        let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 80, height: 0))
        searchBar.searchTextField.placeholder = "띄어쓰기로 복수 입력이 가능해요"
        return searchBar
    }()
    let aroundHobbyLabel: UILabel = {
        let label = UILabel()
        label.text = "지금 주변에는"
        label.font = .title6r
        return label
    }()
    let aroundHobbyCollectionView: BaseCollectionView = {
        let layout = LeftAlignedCollectionViewFlowLayout()
        let collectionView = BaseCollectionView(frame: .zero, collectionViewLayout: layout)
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .vertical
        return collectionView
    }()
    let youWantHobbyLabel: UILabel = {
        let label = UILabel()
        label.text = "내가 하고싶은"
        label.font = .title6r
        return label
    }()
    let youWantHobbyCollectionView: BaseCollectionView = {
        let layout = LeftAlignedCollectionViewFlowLayout()
        let collectionView = BaseCollectionView(frame: .zero, collectionViewLayout: layout)
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .vertical
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

        aroundHobbyLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).inset(32)
            make.leading.equalToSuperview().inset(16)
            make.width.equalTo(100)
        }
        aroundHobbyCollectionView.snp.makeConstraints { make in
            make.top.equalTo(aroundHobbyLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalToSuperview().inset(16)
        }
        youWantHobbyLabel.snp.makeConstraints { make in
            make.top.equalTo(aroundHobbyCollectionView.snp.bottom).offset(25)
            make.leading.equalToSuperview().inset(16)
            make.width.equalTo(100)
        }
        youWantHobbyCollectionView.snp.makeConstraints { make in
            make.top.equalTo(youWantHobbyLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalToSuperview().inset(16)
        }
        findSeSACButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(self.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(48)
        }
    }
}
