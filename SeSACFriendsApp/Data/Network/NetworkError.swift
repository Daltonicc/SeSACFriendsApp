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
    case tooMuchReportUser = 201
    case youAlreadyMatched = 2010 // 201 - 1
    case friendAlreadyRequest = 2011 // 201 - 2
    case friendAlreadyMatchedWithSomeone = 2012 // 201 - 3
    case yourFindinghaveSuspended = 2013 // 201 - 4
    case friendSuspendFinding = 202
    case selfishPenaltyFirst = 203
    case yourRequestIsAccepted = 2030 // 203 - 1
    case selfishPenaltySecond = 204
    case selfishPenaltyThird = 205
    case unknownGender = 206
    case firebaseIdTokenExpired = 401
    case notRegisteredUser = 406
    case serverError = 500
    case headerOrBodyError = 501
}

extension QueueNetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .tooMuchReportUser:
            return "신고가 누적되어 이용하실 수 없습니다."
        case .youAlreadyMatched:
            return "누군가와 취미를 함께하기로 약속하셨어요!"
        case .friendAlreadyRequest:
            return "이미 상대방이 취미 함께하기 요청을 보냈어요!"
        case .friendAlreadyMatchedWithSomeone:
            return "상대방이 이미 다른 사람과 취미를 함께 하는 중입니다."
        case .yourFindinghaveSuspended:
            return "오랜 시간 동안 매칭 되지 않아 새싹 친구 찾기를 그만둡니다"
        case .friendSuspendFinding:
            return "상대방이 취미 함께 하기를 그만두었습니다"
        case .yourRequestIsAccepted:
            return "앗! 누군가가 나의 취미 함께 하기를 수락하였어요!"
        case .selfishPenaltyFirst:
            return "약속 취소 패널티로, 1분동안 이용하실 수 없습니다."
        case .selfishPenaltySecond:
            return "약속 취소 패널티로, 2분동안 이용하실 수 없습니다."
        case .selfishPenaltyThird:
            return "연속으로 약속을 취소하셔서, 3분동안 이용하실 수 없습니다."
        case .unknownGender:
            return "새싹 찾기 기능을 이용하기 위해서는 성별이 필요해요!"
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

enum ChatError: Int, Error {
    case cannotSendMessage = 201
    case firebaseIdTokenExpired = 401
    case notRegisteredUser = 406
    case serverError = 500
    case headerOrBodyError = 501
}

extension ChatError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .cannotSendMessage:
            return "매칭 해제 상태입니다. 메세지를 보낼 수 없습니다"
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
