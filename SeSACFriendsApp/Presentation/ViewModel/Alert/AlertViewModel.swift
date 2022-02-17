//
//  AlertViewModel.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/02/06.
//

import UIKit

final class AlertViewModel: ViewModel {

    weak var coordinator: Coordinator?
    let useCase: AlertUseCase

    var friendsID: String?

    init(coordinator: Coordinator, useCase: AlertUseCase) {
        self.coordinator = coordinator
        self.useCase = useCase
    }

    func withdrawUserData(completion: @escaping (String?) -> Void) {

        useCase.withdrawUserData { [weak self] error in
            if let error = error {
                // 에러가 존재하면 관련 에러 토스트 메세지
                completion(error.errorDescription)
            } else {
                // 에러 없으면 업뎃 성공!
                self?.coordinator?.finish()  
            }
        }
    }

    func hobbyRequest(completion: @escaping (String) -> Void) {

        let parameter: [String: Any] = [
            "otheruid": friendsID ?? ""
        ]
        useCase.hobbyRequest(parameter: parameter) { error in
            if let error = error {
                completion(error.errorDescription!)
            } else {
                completion("취미 함께 하기 요청을 보냈습니다")
            }
        }
    }

    func hobbyAccept(completion: @escaping (String?) -> Void) {

        let parameter: [String: Any] = [
            "otheruid": friendsID ?? ""
        ]
        useCase.hobbyAccept(parameter: parameter) { error in
            if let error = error {
                completion(error.errorDescription!)
            } else {
                // 채팅뷰로 보내기
            }
        }
    }
}
