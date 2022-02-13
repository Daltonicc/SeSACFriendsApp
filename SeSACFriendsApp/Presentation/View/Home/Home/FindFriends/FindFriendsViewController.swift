//
//  FindFriendsViewController.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/02/13.
//

import UIKit
import RxSwift
import RxCocoa

final class FindFriendsViewController: BaseViewController, CustomMenuBarDelegate {

    let customMenuBar = CustomMenuBar()
    let suspendBarButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem()
        barButton.title = "찾기중단"
        barButton.tintColor = .black
        return barButton
    }()
    let pageCollectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        return collectionView
    }()

    var viewModel: FindFriendsViewModel?

    let disposeBag = DisposeBag()

    deinit {
        print("FindFriendsViewController Deinit")
    }

    override func loadView() {
        super.loadView()

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

    }

    override func setViewConfig() {
        super.setViewConfig()

        view.addSubview(customMenuBar)
        view.addSubview(pageCollectionView)

        customMenuBar.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.height.equalTo(40)
        }
        pageCollectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(self.view.safeAreaLayoutGuide)
            make.top.equalTo(customMenuBar.snp.bottom)
        }

        customMenuBar.delegate = self
        customMenuBar.indicatorViewWidthConstraint.constant = self.view.frame.width / 2

        pageCollectionView.delegate = self
        pageCollectionView.dataSource = self
        pageCollectionView.register(PageCollectionViewCell.self, forCellWithReuseIdentifier: PageCollectionViewCell.identifier)

    }

    override func navigationItemConfig() {
        super.navigationItemConfig()

        title = "새싹 찾기"
        navigationItem.leftBarButtonItem = backBarButton
        navigationItem.rightBarButtonItem = suspendBarButton

        backBarButton.target = self
        backBarButton.rx.tap
            .bind { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            }
            .disposed(by: disposeBag)
    }

    func customMenuBar(scrollTo index: Int) {
        let indexPath = IndexPath(row: index, section: 0)
        pageCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
}

extension FindFriendsViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PageCollectionViewCell.identifier, for: indexPath) as? PageCollectionViewCell else { return UICollectionViewCell() }
        let tableViewCell = cell.cardTableView.dequeueReusableCell(withIdentifier: CardTableViewCell.identifier, for: indexPath) as? CardTableViewCell

        if indexPath.item == 0 {
//            tableViewCell!.cardView.cardButton.setTitle("요청하기", for: .normal)
            cell.item = 0
        } else {
//            tableViewCell!.cardView.cardButton.setTitle("수락하기", for: .normal)
            cell.item = 1
        }

        return cell

    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        customMenuBar.indicatorViewLeadingConstraint.constant = scrollView.contentOffset.x / 2
    }

    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {

        let itemAt = Int(targetContentOffset.pointee.x / self.view.frame.width)
        let indexPath = IndexPath(item: itemAt, section: 0)
        customMenuBar.customTabBarCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
    }
}

extension FindFriendsViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: pageCollectionView.frame.width, height: pageCollectionView.frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

}
