//
//  ViewController.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/01/18.
//

import UIKit
import SnapKit

class OnboardingViewController: UIViewController {

    weak var coordinator: MainCoordinator?
    let mainView = OnboardingView()

    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        mainView.collectionView.register(OnboardingCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: OnboardingCollectionViewCell.identifier)
        mainView.collectionView.isPagingEnabled = true

        mainView.startButton.addTarget(self, action: #selector(startButtonClicked), for: .touchUpInside)

    }

    @objc func startButtonClicked(sender: UIButton) {

        addPressAnimationToButton(sender) { _ in

            print("Complete")
            
        }
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

/*
 개선사항
 1. 온보딩뷰 레이아웃(비율로 적절하게. 작은화면에서도 어색함 없게 배치)


 이슈
 1. 텍스트 필드의 보더 중에서 바텀에만 보더를 주고 싶었는데 코드를 구현해도 제대로 보더 표시가 안됐던 이슈 존재.
  -> 해결: viewDidLoad가 아닌 viewDidLayoutSubviews에서 관련 코드를 구현해줘야 함. addSubview가 끝난다음에 호출해야 하기 때문.

 */
