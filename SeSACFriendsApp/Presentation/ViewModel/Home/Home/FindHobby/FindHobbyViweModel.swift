//
//  FindHobbyViweModel.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/02/12.
//

import UIKit
import RxSwift
import RxCocoa
import RxKeyboard
import SnapKit

final class FindHobbyViewModel: ViewModel {

    weak var coordinator: HomeCoordinator?
    let useCase: FindHobbyUseCase

    var yourRegion: Int
    var yourLatitude: Double
    var yourLongitude: Double

    var hobbyList: [String] = []
    var youWantHobbyList: [String] = []
    var youAddHobbyList: [String] = []

    let disposeBag = DisposeBag()

    init(coordinator: HomeCoordinator, yourRegion: Int, yourLatitude: Double, yourLongitude: Double, useCase: FindHobbyUseCase) {
        self.coordinator = coordinator
        self.yourRegion = yourRegion
        self.yourLatitude = yourLatitude
        self.yourLongitude = yourLongitude
        self.useCase = useCase
    }

    deinit {
        print("FindHobbyViewModel Deinit")
    }

    func fetchHobbyData(completion: @escaping (String?) -> Void) {

        let parameter: [String: Any] = [
            "region": yourRegion,
            "lat": yourLatitude,
            "long": yourLongitude
        ]

        //취미 중복되는거 처리하긴 했으나, 코드가 너무 더러움 개선필요
        useCase.fetchAroundUserData(parameter: parameter) { [weak self] (result) in
            switch result {
            case let .success(data):
                self?.hobbyList = data.recommendHobbyList
                for i in data.otherUsers {
                    for j in i.wantHobby {
                        if !(self?.hobbyList.contains(j) ?? false) {
                            self?.hobbyList.append(j)
                        }
                    }
                }
                completion(nil)

            case let .failure(error):
                completion(error.errorDescription)
            }
        }
    }

    func startToFindFriends(completion: @escaping (String) -> Void) {

        let parameter: [String: Any] = [
            "type": 2,
            "region": yourRegion,
            "long": yourLongitude,
            "lat": yourLatitude,
            "hf": youWantHobbyList
        ]
        print(parameter)

        useCase.requestFindFriends(parameter: parameter) { [weak self] error in
            if let error = error {
                completion(error.errorDescription!)
            } else {
                self?.coordinator?.showFindFriendsView(region: self?.yourRegion ?? 0,
                                                       yourLatitude: self?.yourLatitude ?? 0,
                                                       yourLongitude: self?.yourLongitude ?? 0,
                                                       youWantHobbyList: self?.youWantHobbyList ?? [])
            }
        }
    }

    func showKeyboard(findButton: CustomButton, view: UIView) {

        RxKeyboard.instance.visibleHeight
            .skip(1)
            .drive(onNext: { keyboardVisibleHeight in
                UIView.animate(withDuration: 0) {
                    if keyboardVisibleHeight == 0.0 {
                        findButton.snp.remakeConstraints({ make in
                            make.leading.equalToSuperview().inset(16)
                            make.trailing.equalToSuperview().inset(16)
                            make.bottom.equalToSuperview().inset(20)
                            make.height.equalTo(48)
                        })
                    } else {
                        findButton.snp.remakeConstraints({ make in
                            make.leading.equalToSuperview()
                            make.trailing.equalToSuperview()
                            make.bottom.equalToSuperview().inset(keyboardVisibleHeight)
                            make.height.equalTo(48)
                        })
                    }
                }
                view.layoutIfNeeded()
            })
            .disposed(by: disposeBag)
    }
}
