//
//  HomeUseCase.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/02/08.
//

import UIKit

final class HomeUseCase {

    let repository: HomeRepository

    init(repository: HomeRepository) {
        self.repository = repository
    }

    func fetchAroundUserData(parameter: [String: Any], completion: @escaping (OtherUserDataList?) -> Void) {

        repository.fetchAroundUserData(parameter: parameter) { [weak self] data, statusCode in
            switch statusCode {
            case 200: completion(data)
            case 401:
                FirebaseIDToken.refreshIDToken { [weak self] in
                    self?.repository.fetchAroundUserData(parameter: parameter, completion: { data, statusCode in
                        guard statusCode == 200 else { return }
                        completion(data)
                    })
                }
            default: print("findAroundUser Default")
            }
        }
    }
}
