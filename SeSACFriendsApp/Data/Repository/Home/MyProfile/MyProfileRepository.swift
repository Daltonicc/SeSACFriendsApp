//
//  MyProfileRepository.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/02/05.
//

import UIKit
import Moya

final class MyProfileRepository {

    func getUserInfo(completion: @escaping (Int, UserData?) -> Void) {

        let provider = MoyaProvider<SeSACFriendsAPI>()
        provider.request(.loginToFriendsApp) { (result) in
            switch result {
            case let .success(Response):
                let data = try? Response.map(GetUserResponseDTO.self).toDomain()
                let statusCode = Response.statusCode
                print("상태코드 :\(statusCode)")

                completion(statusCode, data)

            case let .failure(MoyaError):
                let errorCode = MoyaError.errorCode
                print("에러코드: \(errorCode)")
                print(MoyaError.localizedDescription)
            }
        }
    }
}
