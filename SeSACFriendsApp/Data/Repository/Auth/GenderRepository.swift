//
//  GenderRepository.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/01/29.
//

import Foundation
import Moya

final class GenderRepository {

    func requestRegisterUser(completion: @escaping (Int) -> Void) {

        let provider = MoyaProvider<SeSACFriendsAPI>()
        provider.request(.registerFriend(parameter: UserDefaultsRepository.requestRegisterUser())) { (result) in
            switch result {
            case let .success(Response):
                let data = try? Response.map(GetUserResponseDTO.self).toDomain()
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
