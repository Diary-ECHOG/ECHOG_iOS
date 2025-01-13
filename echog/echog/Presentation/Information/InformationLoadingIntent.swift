//
//  InformationLoadingIntent.swift
//  echog
//
//  Created by minsong kim on 1/12/25.
//

import Foundation

enum InformationLoadingIntent {
    case goToStart
    case goToFinish
        
    func reducer() -> InformationLoadingState {
        switch self {
        case .goToStart:
            return .start
        case .goToFinish:
            return .finish
        }
    }
}
