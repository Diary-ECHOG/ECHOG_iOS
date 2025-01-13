//
//  OnBoardingState.swift
//  echog
//
//  Created by minsong kim on 1/12/25.
//

import UIKit

enum OnBoardingState: Int {
    case logo
    case diary
    case vote
    case secret
    case start
    
    var detail: OnBoardingModel? {
        switch self {
        case .logo:
            return OnBoardingModel(
                image: UIImage(resource: .logo),
                title: "",
                isStartButton: false
            )
        case .diary:
            return OnBoardingModel(
                image: UIImage(resource: .diary),
                title: "나의 일기를 작성하고",
                isStartButton: false
            )
        case .vote:
            return OnBoardingModel(
                image: UIImage(resource: .vote),
                title: "궁금한 투표도 할 수 있어요",
                isStartButton: false
            )
        case .secret:
            return OnBoardingModel(
                image: UIImage(resource: .secret),
                title: "아무도 못보게 지켜줄게요",
                isStartButton: true
            )
        case .start:
            return nil
        }
    }
}
