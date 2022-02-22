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
    let changeHobbyButton: CustomButton = {
        let button = CustomButton()
        button.setTitle("취미 변경하기", for: .normal)
        button.buttonState = .fill
        return button
    }()
    let reloadButton: CustomButton = {
        let button = CustomButton()
        button.buttonState = .outline
        button.setImage(Asset.Home.reloadImage.image.resized(to: CGSize(width: 25, height: 25)), for: .normal)
        button.layer.borderColor = UIColor.baseGreen.cgColor
        button.layer.borderWidth = 1
        return button
    }()

    var viewModel: FindFriendsViewModel?

    deinit {
        print("FindFriendsViewController Deinit")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        viewModel?.fetchAroundUserData(completion: { [weak self] errorMessage in
            self?.view.makeToast(errorMessage)
            self?.pageCollectionView.reloadData()
        })

        viewModel?.checkMyQueueState(completion: { [weak self] errorMessage in
            self?.view.makeToast(errorMessage)
        })
    }

    override func setViewConfig() {
        super.setViewConfig()

        view.addSubview(customMenuBar)
        view.addSubview(pageCollectionView)
        view.addSubview(changeHobbyButton)
        view.addSubview(reloadButton)
        
        setUpConstraints()

        customMenuBar.delegate = self
        customMenuBar.indicatorViewWidthConstraint.constant = self.view.frame.width / 2

        pageCollectionView.delegate = self
        pageCollectionView.dataSource = self
        pageCollectionView.register(PageCollectionViewCell.self, forCellWithReuseIdentifier: PageCollectionViewCell.identifier)

    }

    override func buttonConfig() {
        super.buttonConfig()
        
        changeHobbyButton.rx.tap
            .bind { [weak self] in
                self?.addPressAnimationToButton(self?.changeHobbyButton ?? CustomButton()) { [weak self] _ in
                    self?.viewModel?.suspendFindFriendsCase = .tapChangeHobbyButton
                    self?.viewModel?.suspendFindFriends(completion: { [weak self] errorMessage in
                        self?.view.makeToast(errorMessage)
                    })
                }
            }
            .disposed(by: disposeBag)

        suspendBarButton.rx.tap
            .bind { [weak self] in
                self?.viewModel?.suspendFindFriendsCase = .tapFindingSuspendButton
                self?.viewModel?.suspendFindFriends(completion: { errorMessage in
                    self?.view.makeToast(errorMessage)
                })
            }
            .disposed(by: disposeBag)

        reloadButton.rx.tap
            .bind { [weak self] in
                self?.addPressAnimationToButton(self?.reloadButton ?? CustomButton()) { [weak self] _ in
                    self?.viewModel?.fetchAroundUserData(completion: { [weak self] errorMessage in
                        self?.view.makeToast(errorMessage)
                        self?.pageCollectionView.reloadData()
                    })
                }
            }
            .disposed(by: disposeBag)

    }

    override func navigationItemConfig() {
        super.navigationItemConfig()

        title = "새싹 찾기"
        navigationItem.leftBarButtonItem = backBarButton
        navigationItem.rightBarButtonItem = suspendBarButton

        backBarButton.target = self
        backBarButton.rx.tap
            .bind { [weak self] in
                self?.navigationController?.popToRootViewController(animated: true)
            }
            .disposed(by: disposeBag)
    }

    func setUpConstraints() {

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
        changeHobbyButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide)
            make.height.equalTo(48)
        }
        reloadButton.snp.makeConstraints { make in
            make.leading.equalTo(changeHobbyButton.snp.trailing).offset(8)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide)
            make.trailing.equalToSuperview().inset(16)
            make.width.height.equalTo(48)
        }
    }

    func customMenuBar(scrollTo index: Int) {
        let indexPath = IndexPath(row: index, section: 0)
        pageCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }

    func checkButtonIsHidden(array: [String]) {
        if array.isEmpty {
            changeHobbyButton.isHidden = false
            reloadButton.isHidden = false
        } else {
            changeHobbyButton.isHidden = true
            reloadButton.isHidden = true
        }
    }
}

extension FindFriendsViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PageCollectionViewCell.identifier, for: indexPath) as? PageCollectionViewCell else { return UICollectionViewCell() }

        cell.viewModel = viewModel
        if indexPath.item == 0 {
            checkButtonIsHidden(array: viewModel?.friendsNameArray ?? [])
            cell.item = 0

            cell.friendsNameArray = viewModel?.friendsNameArray ?? []
            cell.friendsSeSACImageArray = viewModel?.friendsSeSACImageArray ?? []
            cell.friendsBackgroundImage = viewModel?.friendsBackgroundImage ?? []
            cell.friendsIDArray = viewModel?.friendsIDArray ?? []

            cell.requestCellConfig()
        } else {
            checkButtonIsHidden(array: viewModel?.acceptFriendsNameArray ?? [])
            cell.item = 1

            cell.acceptFriendsNameArray = viewModel?.acceptFriendsNameArray ?? []
            cell.acceptFriendsSeSACImageArray = viewModel?.acceptFriendsSeSACImageArray ?? []
            cell.acceptFriendsBackgroundImage = viewModel?.acceptFriendsBackgroundImage ?? []
            cell.acceptFriendsIDArray = viewModel?.acceptFriendsIDArray ?? []

            cell.acceptCellConfig()

            cell.cardTableView.reloadData()
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        viewModel?.fetchAroundUserData(completion: { [weak self] errorMessage in
            self?.view.makeToast(errorMessage)
            if indexPath.item == 0 {
                self?.checkButtonIsHidden(array: self?.viewModel?.friendsNameArray ?? [])
            } else {
                self?.checkButtonIsHidden(array: self?.viewModel?.acceptFriendsNameArray ?? [])
            }
        })
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
