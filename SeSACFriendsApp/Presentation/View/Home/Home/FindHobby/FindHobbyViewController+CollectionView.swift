//
//  FindHobbyViewController+CollectionView.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/02/13.
//

import UIKit

extension FindHobbyViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        if collectionView == mainView.aroundHobbyCollectionView {
            return viewModel?.hobbyList.count ?? 0
        } else {
            return viewModel?.youWantHobbyList.count ?? 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if collectionView == mainView.aroundHobbyCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AroundHobbyCollectionViewCell.identifier, for: indexPath) as? AroundHobbyCollectionViewCell else { return UICollectionViewCell() }

            if indexPath.item < 4 {
                cell.aroundHobbyLabel.text = viewModel?.hobbyList[indexPath.item]
                cell.aroundHobbyLabel.textColor = .red
                cell.cellView.layer.borderColor = UIColor.red.cgColor
            } else {
                cell.aroundHobbyLabel.text = viewModel?.hobbyList[indexPath.item]
                cell.aroundHobbyLabel.textColor = .black
                cell.cellView.layer.borderColor = UIColor.gray4.cgColor
            }

            return cell

        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: YouWantHobbyCollectionViewCell.identifier, for: indexPath) as? YouWantHobbyCollectionViewCell else { return UICollectionViewCell() }

            cell.youWantHobbyLabel.text = viewModel?.youWantHobbyList[indexPath.item]

            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        if collectionView == mainView.aroundHobbyCollectionView {
            guard let item = viewModel?.hobbyList[indexPath.item] else { return }
            guard let cell = collectionView.cellForItem(at: indexPath) as? AroundHobbyCollectionViewCell else { return }
            addPressAnimationToButton(cell) { [weak self] _ in
                if self?.viewModel?.youWantHobbyList.count == 8 {
                    self?.mainView.makeToast("취미를 더 이상 추가할 수 없습니다.")
                } else {
                    self?.viewModel?.hobbyList.remove(at: indexPath.item)
                    self?.viewModel?.youWantHobbyList.append(item)
                    self?.mainView.aroundHobbyCollectionView.reloadData()
                    self?.mainView.youWantHobbyCollectionView.reloadData()
                }
            }
        } else {
            guard let item = viewModel?.youWantHobbyList[indexPath.item] else { return }
            guard let cell = collectionView.cellForItem(at: indexPath) as? YouWantHobbyCollectionViewCell else { return }
            addPressAnimationToButton(cell) { [weak self] _ in
                self?.viewModel?.youWantHobbyList.remove(at: indexPath.item)
                // 사용자가 추가한 취미이면 삭제했을 때 주변취미로 추가 안되게 처리
                if self?.viewModel?.youAddHobbyList.contains(item) ?? true == false {
                    self?.viewModel?.hobbyList.append(item)
                }
                self?.mainView.aroundHobbyCollectionView.reloadData()
                self?.mainView.youWantHobbyCollectionView.reloadData()
            }
        }
    }
}

extension FindHobbyViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 길이 측정을 위한 더미 레이블 만들어줌.
        if collectionView == mainView.aroundHobbyCollectionView {
            let dummyLabel: UILabel = {
                let label = UILabel()
                label.font = .title4r
                label.text = viewModel?.hobbyList[indexPath.item]
                label.sizeToFit()
                return label
            }()
            let size = dummyLabel.frame.size
            return CGSize(width: size.width + 20, height: 32)
        } else {
            let dummyLabel: UILabel = {
                let label = UILabel()
                label.font = .title4r
                label.text = viewModel?.youWantHobbyList[indexPath.item]
                label.sizeToFit()
                return label
            }()
            let size = dummyLabel.frame.size
            return CGSize(width: size.width + 40, height: 32)
        }

    }
}
