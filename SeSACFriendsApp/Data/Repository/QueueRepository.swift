//
//  QueueRepository.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/02/09.
//

import Foundation
import Moya

final class QueueRepository {

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

    func statusCodeCheck(statusCode: Int) -> QueueNetworkError? {
        switch statusCode {
        case 200: return nil
        case 401: return .firebaseIdTokenExpired
        case 406: return .notRegisteredUser
        case 500: return .serverError
        case 501: return .headerOrBodyError
        default: return .serverError
        }
    }
}
