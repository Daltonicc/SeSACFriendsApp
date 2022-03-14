//
//  ChatResponseDTO.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/02/21.
//

import Foundation

struct ChatResponseDTO: Codable {
    let id: String
    let v: Int
    let to, from, chat, createdAt: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case v = "__v"
        case to, from, chat, createdAt
    }
}

extension ChatResponseDTO {
    func toDomain() -> ChatData {
        return .init(toID: to,
                     fromID: from,
                     chatMessage: chat,
                     createdAt: createdAt)
    }
}
