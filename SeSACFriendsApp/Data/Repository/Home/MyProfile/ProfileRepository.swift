//
//  ProfileRepository.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/02/05.
//

import UIKit
import Moya

final class ProfileRepository {

    func updateUserData(parameter: [String: Any], completion: @escaping (Int) -> Void) {

        let provider = MoyaProvider<SeSACFriendsAPI>()
        provider.request(.updateUserData(parameter: parameter)) { result in
            switch result {
            case let .success(Response):
                let statusCode = Response.statusCode
                print("상태코드 :\(statusCode)")

                completion(statusCode)

            case let .failure(MoyaError):
                let errorCode = MoyaError.errorCode
                print("에러코드: \(errorCode)")
                print(MoyaError.localizedDescription)
            }
        }

    }

    func withdrawUserData(completion: @escaping (Int) -> Void) {

        let provider = MoyaProvider<SeSACFriendsAPI>()
        provider.request(.withdrawUser) { result in
            switch result {
            case let .success(Response):
                let statusCode = Response.statusCode

                completion(statusCode)

            case let .failure(MoyaError):
                let errorCode = MoyaError.errorCode
                print("에러코드: \(errorCode)")
                print(MoyaError.localizedDescription)
            }
        }
    }
}
