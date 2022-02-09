//
//  QueueRepository.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/02/09.
//

import Foundation
import Moya

final class QueueRepository {

    func fetchAroundUserData(parameter: [String: Any], completion: @escaping (OtherUserDataList?, Int) -> Void) {

        let provider = MoyaProvider<SeSACFriendsAPI>()
        provider.request(.findSeSACAroundYou(parameter: parameter)) { result in
            switch result {
            case let .success(Response):
                let data = try? Response.map(OnQueueResponseDTO.self).toDomain()
                let statusCode = Response.statusCode
                print(data)
                print("상태코드 :\(statusCode)")

                completion(data, statusCode)

            case let .failure(MoyaError):
                let errorCode = MoyaError.errorCode
                print("에러코드: \(errorCode)")
                print(MoyaError.localizedDescription)
            }
        }
    }
}
