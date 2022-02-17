//
//  QueueRepository.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/02/09.
//

import Foundation
import Moya

final class QueueRepository: QueueRepositoryInterface {

    func fetchAroundUserData(parameter: [String: Any], completion: @escaping (Result<OtherUserDataList, QueueNetworkError>) -> Void) {

        let provider = MoyaProvider<SeSACFriendsAPI>()
        provider.request(.findSeSACAroundYou(parameter: parameter)) { result in
            switch result {
            case let .success(response):
                let statusCode = response.statusCode
                print("상태코드 :\(statusCode)")

                let statusCodeCheck = self.statusCodeCheck(statusCode: statusCode)
                if let data = try? response.map(OnQueueResponseDTO.self).toDomain() {
                    print(data)
                    if statusCodeCheck == nil {
                        completion(.success(data))
                    } else {
                        completion(.failure(statusCodeCheck!))
                    }
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

    // nil값은 성공으로 간주
    func requestFindFriends(parameter: [String: Any], completion: @escaping (QueueNetworkError?) -> Void) {

        let provider = MoyaProvider<SeSACFriendsAPI>()
        provider.request(.requestFindFriends(parameter: parameter)) { (result) in
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

    func suspendFindFriends(completion: @escaping (QueueNetworkError?) -> Void) {

        let provider = MoyaProvider<SeSACFriendsAPI>()
        provider.request(.suspendFindFriends) { (result) in
            switch result {
            case let .success(response):
                let statusCode = response.statusCode
                print("상태코드 :\(statusCode)")

                let statusCodeCheck = self.statusCodeCheckForSuspendFindFriends(statusCode: statusCode)

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

    func hobbyRequest(parameter: [String: Any], completion: @escaping (QueueNetworkError?) -> Void) {

        let provider = MoyaProvider<SeSACFriendsAPI>()
        provider.request(.hobbyRequest(parameter: parameter)) { (result) in
            switch result {
            case let .success(response):
                let statusCode = response.statusCode
                print("상태코드 :\(statusCode)")

                let statusCodeCheck = self.statusCodeCheckForHobbyRequest(statusCode: statusCode)

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

    func hobbyAccept(parameter: [String: Any], completion: @escaping (QueueNetworkError?) -> Void) {

        let provider = MoyaProvider<SeSACFriendsAPI>()
        provider.request(.hobbyAccept(parameter: parameter)) { (result) in
            switch result {
            case let .success(response):
                let statusCode = response.statusCode
                print("상태코드 :\(statusCode)")

                let statusCodeCheck = self.statusCodeCheckForHobbyAccept(statusCode: statusCode)

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

    func statusCodeCheck(statusCode: Int) -> QueueNetworkError? {
        switch statusCode {
        case 200: return nil
        case 201: return .tooMuchReportUser
        case 203: return .selfishPenaltyFirst
        case 204: return .selfishPenaltySecond
        case 205: return .selfishPenaltyThird
        case 206: return .unknownGender
        case 401: return .firebaseIdTokenExpired
        case 406: return .notRegisteredUser
        case 500: return .serverError
        case 501: return .headerOrBodyError
        default: return .serverError
        }
    }

    func statusCodeCheckForSuspendFindFriends(statusCode: Int) -> QueueNetworkError? {
        switch statusCode {
        case 200: return nil
        case 201: return .youAlreadyMatched
        case 401: return .firebaseIdTokenExpired
        case 406: return .notRegisteredUser
        case 500: return .serverError
        default: return .serverError
        }
    }

    func statusCodeCheckForHobbyRequest(statusCode: Int) -> QueueNetworkError? {
        switch statusCode {
        case 200: return nil
        case 201: return .friendAlreadyRequest
        case 202: return .friendSuspendFinding
        case 401: return .firebaseIdTokenExpired
        case 406: return .notRegisteredUser
        case 500: return .serverError
        case 501: return .headerOrBodyError
        default: return .serverError
        }
    }

    func statusCodeCheckForHobbyAccept(statusCode: Int) -> QueueNetworkError? {
        switch statusCode {
        case 200: return nil
        case 201: return .friendAlreadyMatchedWithSomeone
        case 202: return .friendSuspendFinding
        case 203: return .yourRequestIsAccepted
        case 401: return .firebaseIdTokenExpired
        case 406: return .notRegisteredUser
        case 500: return .serverError
        case 501: return .headerOrBodyError
        default: return .serverError
        }
    }
}
