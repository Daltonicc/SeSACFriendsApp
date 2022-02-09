//
//  UserRepository.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/02/09.
//

import Foundation
import Moya

final class UserRepository {

    func getUserInfo(completion: @escaping (Result<UserData?, UserNetworkError>) -> Void) {

        let provider = MoyaProvider<SeSACFriendsAPI>()
        provider.request(.loginToFriendsApp) { (result) in
            switch result {
            case let .success(Response):
                let data = try? Response.map(GetUserResponseDTO.self).toDomain()
                let statusCode = Response.statusCode
                print("상태코드 :\(statusCode)")

                let statusCodeCheck = self.statusCodeCheck(statusCode: statusCode)

                if statusCodeCheck == nil {
                    completion(.success(data))
                } else {
                    completion(.failure(statusCodeCheck!))
                }

            case let .failure(MoyaError):
                let errorCode = MoyaError.errorCode
                print("에러코드: \(errorCode)")
                print(MoyaError.localizedDescription)
            }
        }
    }

    func requestRegisterUser(completion: @escaping (Result<UserData?, UserNetworkError>) -> Void) {

        let provider = MoyaProvider<SeSACFriendsAPI>()
        provider.request(.registerFriend(parameter: UserDefaultsRepository.requestRegisterUser())) { (result) in
            switch result {
            case let .success(Response):
                let data = try? Response.map(GetUserResponseDTO.self).toDomain()
                let statusCode = Response.statusCode
                print("상태코드 :\(statusCode)")

                let statusCodeCheck = self.statusCodeCheck(statusCode: statusCode)

                if statusCodeCheck == nil {
                    completion(.success(data))
                } else {
                    completion(.failure(statusCodeCheck!))
                }

            case let .failure(MoyaError):
                let errorCode = MoyaError.errorCode
                print("에러코드: \(errorCode)")
                print(MoyaError.localizedDescription)
            }
        }
    }

    func updateUserData(parameter: [String: Any], completion: @escaping (Result<UserData?, UserNetworkError>) -> Void) {

        let provider = MoyaProvider<SeSACFriendsAPI>()
        provider.request(.updateUserData(parameter: parameter)) { result in
            switch result {
            case let .success(Response):
                let data = try? Response.map(GetUserResponseDTO.self).toDomain()
                let statusCode = Response.statusCode
                print("상태코드 :\(statusCode)")

                let statusCodeCheck = self.statusCodeCheck(statusCode: statusCode)

                if statusCodeCheck == nil {
                    completion(.success(data))
                } else {
                    completion(.failure(statusCodeCheck!))
                }

            case let .failure(MoyaError):
                let errorCode = MoyaError.errorCode
                print("에러코드: \(errorCode)")
                print(MoyaError.localizedDescription)
            }
        }
    }

    func statusCodeCheck(statusCode: Int) -> UserNetworkError? {
        switch statusCode {
        case 200: return nil
        case 201: return .alreadyRegisteredUser
        case 202: return .invalidNickname
        case 401: return .firebaseIdTokenExpired
        case 500: return .serverError
        case 501: return .headerOrBodyError
        default: return .serverError
        }
    }
}
