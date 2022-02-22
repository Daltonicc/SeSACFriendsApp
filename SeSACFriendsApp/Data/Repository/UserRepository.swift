//
//  UserRepository.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/02/09.
//

import Foundation
import Moya

/*
 data 옵셔널 바인딩해서 넘겨주기
 200번 아니면 다 fail로 넘겨주게끔 처리 <- 나중에 validation Type 적용해서 해결해보기.

 */

final class UserRepository: UserRepositoryInterface {

    func getUserInfo(completion: @escaping (Result<UserData, UserNetworkError>) -> Void) {

        let provider = MoyaProvider<SeSACFriendsAPI>()
        provider.request(.loginToFriendsApp) { (result) in
            switch result {
            case let .success(response):
                let statusCode = response.statusCode
                print("상태코드 :\(statusCode)")

                let statusCodeCheck = self.statusCodeCheck(statusCode: statusCode)
                if let data = try? response.map(GetUserResponseDTO.self).toDomain() {
                    // 카테고리에서 보여줄 닉네임, 채팅에 활용할 내 UID 유저디폴트에 저장해놓기
                    UserDefaultsRepository.saveNickname(nickname: data.yourName)
                    UserDefaultsRepository.saveYourUIDForChat(yourUID: data.yourUID)

                    if statusCodeCheck == nil {
                        completion(.success(data))
                    } else {
                        completion(.failure(statusCodeCheck!))
                    }
                } else {
                    completion(.failure(statusCodeCheck!))
                }

            case let .failure(moyaError):
                let errorCode = moyaError.errorCode
                print("에러코드: \(errorCode)")
                print(moyaError.localizedDescription)
            }
        }
    }

    // Request, Update, Withdraw의 경우 받아올 데이터가 없으므로 200번 나오면 nil값 컴플레션으로 넘겨주기
    // 에러 옵셔널로 넘겨주는 이유는 에러가 닐값일 때 성공으로 간주하려고.

    func requestRegisterUser(completion: @escaping (UserNetworkError?) -> Void) {

        let provider = MoyaProvider<SeSACFriendsAPI>()
        provider.request(.registerFriend(parameter: UserDefaultsRepository.requestRegisterUser())) { (result) in
            switch result {
            case let .success(response):
                let statusCode = response.statusCode
                print("상태코드 :\(statusCode)")

                let statusCodeCheck = self.statusCodeCheck(statusCode: statusCode)

                if statusCodeCheck == nil {
                    completion(nil)
                } else {
                    completion(statusCodeCheck)
                }

            case let .failure(moyaError):
                let errorCode = moyaError.errorCode
                print("에러코드: \(errorCode)")
                print(moyaError.localizedDescription)
            }
        }
    }

    func updateUserData(parameter: [String: Any], completion: @escaping (UserNetworkError?) -> Void) {

        let provider = MoyaProvider<SeSACFriendsAPI>()
        provider.request(.updateUserData(parameter: parameter)) { result in
            switch result {
            case let .success(response):
                let statusCode = response.statusCode
                print("상태코드 :\(statusCode)")

                let statusCodeCheck = self.statusCodeCheck(statusCode: statusCode)

                if statusCodeCheck == nil {
                    completion(nil)
                } else {
                    completion(statusCodeCheck)
                }

            case let .failure(moyaError):
                let errorCode = moyaError.errorCode
                print("에러코드: \(errorCode)")
                print(moyaError.localizedDescription)
            }
        }
    }

    func withdrawUserData(completion: @escaping (UserNetworkError?) -> Void) {

        let provider = MoyaProvider<SeSACFriendsAPI>()
        provider.request(.withdrawUser) { result in
            switch result {
            case let .success(response):
                let statusCode = response.statusCode
                print("상태코드 :\(statusCode)")

                let statusCodeCheck = self.statusCodeCheck(statusCode: statusCode)

                if statusCodeCheck == nil {
                    completion(nil)
                } else {
                    completion(statusCodeCheck)
                }

            case let .failure(moyaError):
                let errorCode = moyaError.errorCode
                print("에러코드: \(errorCode)")
                print(moyaError.localizedDescription)
            }
        }
    }

    func statusCodeCheck(statusCode: Int) -> UserNetworkError? {
        switch statusCode {
        case 200: return nil
        case 201: return .alreadyRegisteredUser
        case 202: return .invalidNickname
        case 401: return .firebaseIdTokenExpired
        case 406: return .notRegisteredUser
        case 500: return .serverError
        case 501: return .headerOrBodyError
        default: return .serverError
        }
    }
}
