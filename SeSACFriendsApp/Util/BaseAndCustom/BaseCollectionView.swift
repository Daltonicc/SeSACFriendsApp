//
//  BaseCollectionView.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/02/12.
//

import UIKit

final class BaseCollectionView: UICollectionView {

    override func layoutSubviews() {
        super.layoutSubviews()

        if bounds.size != intrinsicContentSize {
            self.invalidateIntrinsicContentSize()
        }
    }

    override var intrinsicContentSize: CGSize {
        return collectionViewLayout.collectionViewContentSize
    }
}
