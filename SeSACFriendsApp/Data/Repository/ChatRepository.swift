//
//  ChatRepository.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/02/22.
//

import Foundation
import Moya
import UIKit

final class ChatRepository: ChatRepositoryInterface {

    func postChat(parameter: [String: Any], otherUID: String, completion: @escaping (Result<ChatData, ChatError>) -> Void) {
        let provider = MoyaProvider<SeSACFriendsAPI>()
        provider.request(.postChat(parameter: parameter, otherUID: otherUID)) { result in
            switch result {
            case let .success(response):
                let statusCode = response.statusCode
                print("상태코드 :\(statusCode)")

                let statusCodeCheck = self.statusCodeCheck(statusCode: statusCode)
                if let data = try? response.map(ChatResponseDTO.self).toDomain() {
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

    func statusCodeCheck(statusCode: Int) -> ChatError? {
        switch statusCode {
        case 200: return nil
        case 201: return .cannotSendMessage
        case 401: return .firebaseIdTokenExpired
        case 406: return .notRegisteredUser
        case 500: return .serverError
        case 501: return .headerOrBodyError
        default: return .serverError
        }
    }
}
