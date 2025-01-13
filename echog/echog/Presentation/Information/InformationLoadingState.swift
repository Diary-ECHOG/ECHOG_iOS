//
//  InformationLoadingState.swift
//  echog
//
//  Created by minsong kim on 1/12/25.
//

import Foundation

enum InformationLoadingState {
    case start
    case finish
    
    var text: String {
        switch self {
        case .start:
            "먼저 당신의 정보를\n알고싶어요"
        case .finish:
            "가입을\n축하합니다!"
        }
    }
}
