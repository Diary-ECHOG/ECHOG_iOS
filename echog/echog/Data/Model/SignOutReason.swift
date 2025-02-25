//
//  SignOutReason.swift
//  echog
//
//  Created by minsong kim on 2/25/25.
//

enum SignOutReason: CaseIterable {
    case uncomfortableService
    case uncomfortableDiary
    case contentsNotSatisfying
    case moveToAnotherService
    case personalReason
    case burdenPrice
    case etc
    
    var title: String {
        switch self {
        case .uncomfortableService:
            "서비스 이용이 불편함"
        case .uncomfortableDiary:
            "일기 작성 기능이 부족하거나 불편함"
        case .contentsNotSatisfying:
            "콘텐츠(투표, 커뮤니티)에 대한 불만"
        case .moveToAnotherService:
            "다른 일기/투표 서비스로 이동 예정"
        case .personalReason:
            "개인적인 이유로 더 이상 이용하지 않음"
        case .burdenPrice:
            "광고 또는 유료 결제 정책이 부담됨"
        case .etc:
            "기타 (직접 입력 가능)"
        }
    }
}
