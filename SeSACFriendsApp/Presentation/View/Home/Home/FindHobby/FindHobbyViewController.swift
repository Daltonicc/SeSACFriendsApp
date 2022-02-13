//
//  FindHobbyViewController.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/02/10.
//

import UIKit
import RxSwift
import RxCocoa
import RxKeyboard
import SnapKit

final class FindHobbyViewController: BaseViewController {

    let mainView = FindHobbyView()
    var viewModel: FindHobbyViewModel?

    let disposeBag = DisposeBag()

    override func loadView() {
        super.loadView()
        self.view = mainView
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        viewModel?.showKeyboard(findButton: mainView.findSeSACButton, view: mainView)
    }

    override func navigationItemConfig() {

        navigationItem.leftBarButtonItem = backBarButton
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: mainView.searchBar)

        backBarButton.target = self
        backBarButton.rx.tap
            .bind { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            }
            .disposed(by: disposeBag)
    }

    override func setViewConfig() {

        mainView.aroundHobbyCollectionView.delegate = self
        mainView.aroundHobbyCollectionView.dataSource = self
        mainView.aroundHobbyCollectionView.register(AroundHobbyCollectionViewCell.self, forCellWithReuseIdentifier: AroundHobbyCollectionViewCell.identifier)

        mainView.youWantHobbyCollectionView.delegate = self
        mainView.youWantHobbyCollectionView.dataSource = self
        mainView.youWantHobbyCollectionView.register(YouWantHobbyCollectionViewCell.self, forCellWithReuseIdentifier: YouWantHobbyCollectionViewCell.identifier)

        mainView.findSeSACButton.rx.tap
            .bind { [weak self] in
                self?.addPressAnimationToButton(self?.mainView.findSeSACButton ?? CustomButton()) { _ in
                    self?.viewModel?.startToFindFriends(completion: { [weak self] errorMessage in
                        self?.mainView.makeToast(errorMessage)
                    })
                }
            }
            .disposed(by: disposeBag)

        viewModel?.fetchHobbyData(completion: { [weak self] errorMessage in
            self?.mainView.makeToast(errorMessage)
            self?.mainView.aroundHobbyCollectionView.reloadData()
            self?.mainView.youWantHobbyCollectionView.reloadData()
        })
    }

    override func textfieldConfig() {

        mainView.searchBar.searchTextField.delegate = self
        mainView.searchBar.searchTextField.addTarget(self, action: #selector(searchTextFieldDidChange(textfield:)), for: .editingChanged)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        mainView.searchBar.searchTextField.endEditing(true)
    }

    @objc func searchTextFieldDidChange(textfield: UITextField) {

        checkMaxLength(textField: textfield, maxLength: 8)
    }
}

extension FindHobbyViewController: UITextFieldDelegate {

    func checkMaxLength(textField: UITextField, maxLength: Int) {
        if (textField.text?.count ?? 0 > maxLength) {
            textField.deleteBackward()
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        guard let text = textField.text else { return false }

        if viewModel?.youWantHobbyList.count == 8 {
            mainView.makeToast("취미를 더 이상 추가할 수 없습니다.")
        } else {
            viewModel?.youWantHobbyList.append(text)
            viewModel?.youAddHobbyList.append(text)
            mainView.youWantHobbyCollectionView.reloadData()
            textField.text = ""
            textField.resignFirstResponder()
        }
        return true
    }
}
