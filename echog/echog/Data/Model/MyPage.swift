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

enum MyPageSignOut: CaseIterable {
    case logOut
    case signOut
    
    var title: String {
        switch self {
        case .logOut:
            "로그아웃"
        case .signOut:
            "회원탈퇴"
        }
    }
    
    var color: UIColor {
        switch self {
        case .logOut:
                .black
        case .signOut:
                .red
        }
    }
}

