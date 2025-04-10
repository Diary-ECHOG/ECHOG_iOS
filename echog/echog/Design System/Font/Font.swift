//
//  Font.swift
//  echog
//
//  Created by minsong kim on 9/18/24.
//

import Foundation

enum Font {
    enum Name {
        case pretendardSemiBold
        case pretendardRegular
        case pretendardMedium
        
        var file: String {
            switch self {
            case .pretendardSemiBold:
                "Pretendard-SemiBold"
            case .pretendardRegular:
                "Pretendard-Regular"
            case .pretendardMedium:
                "Pretendard-Medium"
            }
        }
    }
    
    enum Size: CGFloat {
        case _13 = 13
        case _14 = 14
        case _15 = 15
        case _17 = 17
        case _22 = 22
        case _24 = 24
    }
}
