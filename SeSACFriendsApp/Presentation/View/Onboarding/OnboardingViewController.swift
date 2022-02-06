//
//  ViewController.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/01/18.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class OnboardingViewController: BaseViewController {

    var viewModel = OnboardingViewModel()
    let mainView = OnboardingView()

    let disposeBag = DisposeBag()

    override func loadView() {
        super.loadView()
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func setViewConfig() {
        super.setViewConfig()

        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        mainView.collectionView.register(OnboardingCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: OnboardingCollectionViewCell.identifier)
        mainView.collectionView.isPagingEnabled = true

        mainView.startButton.rx.tap
            .bind {
                self.addPressAnimationToButton(self.mainView.startButton) { _ in
                    self.viewModel.showLoginView()
                }
            }
            .disposed(by: disposeBag)

    }
}

extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCollectionViewCell.identifier, for: indexPath) as? OnboardingCollectionViewCell else { return UICollectionViewCell() }

        let item = indexPath.item

        cell.cellConfiguration(item: item)

        return cell

    }

    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {

        let page = Int(targetContentOffset.pointee.x / mainView.collectionView.frame.width)
        self.mainView.pageControl.currentPage = page

        switch page {
        case 0:
            mainView.titleLabel.text = "위치 기반으로 빠르게\n주위 친구들 확인"
            addTitleColorAttribute(colorText: "위치 기반")
        case 1: mainView.titleLabel.text = "관심사가 같은 친구를\n찾을 수 있어요"
            addTitleColorAttribute(colorText: "관심사가 같은 친구를")
        case 2: mainView.titleLabel.text = "SeSAC Friends"
        default: print("default titleLabel")
        }
    }

    func addTitleColorAttribute(colorText: String) {

        let attribute = NSMutableAttributedString(string: mainView.titleLabel.text!)
        attribute.addAttribute(.foregroundColor, value: UIColor.baseGreen, range: (mainView.titleLabel.text! as NSString).range(of: colorText))
        mainView.titleLabel.attributedText = attribute
    }

}
