//
//  OnboardingView.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/01/20.
//

import UIKit
import SnapKit

final class OnboardingView: UIView {

    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "위치 기반으로 빠르게\n주위 친구들 확인"
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont(name: Font.notoSansKRm, size: 24)
        label.numberOfLines = 2

        let attribute = NSMutableAttributedString(string: label.text!)
        attribute.addAttribute(.foregroundColor, value: UIColor.baseGreen, range: (label.text! as NSString).range(of: "위치 기반"))
        label.attributedText = attribute
        return label
    }()
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        layout.minimumLineSpacing = 5
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 250)
        return collectionView
    }()
    let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPage = 0
        pageControl.numberOfPages = 3
        pageControl.pageIndicatorTintColor = .gray3
        pageControl.currentPageIndicatorTintColor = .black
        return pageControl
    }()
    let startButton: CustomButton = {
        let button = CustomButton()
        button.buttonState = .fill
        button.setTitle("시작하기", for: .normal)
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

        addSubview(titleLabel)
        addSubview(collectionView)
        addSubview(pageControl)
        addSubview(startButton)
    }

    func setUpConstraint() {

        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.snp.top).inset(100)
        }
        collectionView.snp.makeConstraints { make in
            make.center.equalToSuperview()
//            make.top.equalTo(titleLabel.snp.bottom).offset(50)
            make.width.equalTo(self.snp.width)
            make.height.equalTo(self.snp.height).multipliedBy(0.45)
        }
        pageControl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
//            make.top.equalTo(collectionView.snp.bottom).offset(50)
            make.bottom.equalTo(startButton.snp.top).offset(-42)

        }
        startButton.snp.makeConstraints { make in
            make.bottom.equalTo(self.snp.bottom).inset(42)
            make.leading.equalTo(self.snp.leading).inset(16)
            make.trailing.equalTo(self.snp.trailing).inset(16)
            make.height.equalTo(48)
        }
    }
}
