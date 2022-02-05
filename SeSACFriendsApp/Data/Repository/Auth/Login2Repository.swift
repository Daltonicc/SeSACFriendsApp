//
//  Login2Repository.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/01/29.
//

import Foundation
import Moya

final class Login2Repository {

    func getUserInfo(completion: @escaping (Int) -> Void) {

        let provider = MoyaProvider<SeSACFriendsAPI>()
        provider.request(.loginToFriendsApp) { (result) in
            switch result {
            case let .success(Response):
                let data = try? Response.map(GetUserResponseDTO.self).toDomain()
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

}
