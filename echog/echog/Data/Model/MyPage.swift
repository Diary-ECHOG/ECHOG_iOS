//
//  MyPage.swift
//  echog
//
//  Created by minsong kim on 12/26/24.
//

import UIKit

enum MyPageList: CaseIterable {
    case myVoteList
    case reportList
    
    var title: String {
        switch self {
        case .myVoteList:
            "내 투표 리스트"
        case .reportList:
            "신고 리스트"
        }
    }
}

enum MyPageSignOut: Int,  CaseIterable {
    case logOut = 0
    case checkTerms
    case signOut
    
    var title: String {
        switch self {
        case .logOut:
            "로그아웃"
        case .checkTerms:
            "개인정보 처리방침"
        case .signOut:
            "회원탈퇴"
        }
    }
    
    var color: UIColor {
        switch self {
        case .logOut:
                .slate800
        case .checkTerms:
                .slate800
        case .signOut:
                .red500
        }
    }
}

