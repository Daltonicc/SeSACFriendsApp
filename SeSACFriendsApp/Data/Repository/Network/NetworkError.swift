//
//  NetworkError.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/02/09.
//

import Foundation
import Moya

// MARK: - User

enum UserNetworkError: Int, Error {
    case alreadyRegisteredUser = 201
    case invalidNickname = 202
    case firebaseIdTokenExpired = 401
    case notRegisteredUser = 406
    case serverError = 500
    case headerOrBodyError = 501

}

extension UserNetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .alreadyRegisteredUser:
            return "이미 등록된 유저입니다."
        case .invalidNickname:
            return "유효하지 않은 닉네임입니다."
        case .firebaseIdTokenExpired:
            return "토큰 만료"
        case .notRegisteredUser:
            return "등록되지 않은 유저입니다."
        case .serverError:
            return "잠시 후 시도해주세요"
        case .headerOrBodyError:
            return "유효하지 않은 요청입니다."
        }
    }
}

// MARK: - Queue

enum QueueNetworkError: Int, Error {
    case firebaseIdTokenExpired = 401
    case notRegisteredUser = 406
    case serverError = 500
    case headerOrBodyError = 501
}

extension QueueNetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .firebaseIdTokenExpired:
            return "토큰 만료"
        case .notRegisteredUser:
            return "등록되지 않은 유저입니다."
        case .serverError:
            return "잠시 후 시도해주세요"
        case .headerOrBodyError:
            return "유효하지 않은 요청입니다."
        }
    }
}
