//
//  WithdrawRepository.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/02/06.
//

import UIKit
import Moya

final class WithdrawRepository {

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
