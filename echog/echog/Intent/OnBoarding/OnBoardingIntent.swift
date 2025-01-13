//
//  OnBoardingIntent.swift
//  echog
//
//  Created by minsong kim on 1/11/25.
//

import Foundation

enum OnBoardingIntent {
    case goToNext(page: Int)
    case goToStart
    
    func reducer() -> OnBoardingState {
        switch self {
        case .goToNext(let number):
            if number <= 3 {
                return OnBoardingState(rawValue: number) ?? .secret
            } else {
                return .secret
            }
        case .goToStart:
            return .start
        }
    }
}
