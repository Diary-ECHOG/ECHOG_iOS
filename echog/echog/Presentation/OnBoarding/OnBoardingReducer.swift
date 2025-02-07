//
//  OnBoardingReducer.swift
//  echog
//
//  Created by minsong kim on 2/5/25.
//

import Combine
import UIKit

struct OnBoardingReducer: ReducerProtocol {
    enum Intent {
        case goToNext(Int)
        case goToStart
    }
    
    enum Mutation: Int {
        case diary = 1
        case vote
        case secret
    }
    
    struct State {
        var page: Int
        var image: UIImage
        var title: String
        var isStartButton: Bool
    }
    
    weak var delegate: OnBoardingCoordinator?
    
    let initialState: State = State(page: 0, image: UIImage(resource: .logo), title: "", isStartButton: false)
    
    func mutate(action: Intent) -> AnyPublisher<Mutation, Never>? {
        switch action {
        case .goToNext(let page):
            return Just(Mutation(rawValue: page + 1) ?? .secret)
                .eraseToAnyPublisher()
        case .goToStart:
            delegate?.goToInformationViewController()
            return nil
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .diary:
            newState.page = 1
            newState.image = UIImage(resource: .diary)
            newState.title = "나의 일기를 작성하고"
        case .vote:
            newState.page = 2
            newState.image = UIImage(resource: .vote)
            newState.title = "궁금한 투표도 할 수 있어요"
        case .secret:
            newState.page = 3
            newState.image = UIImage(resource: .secret)
            newState.title = "아무도 못보게 지켜줄게요"
            newState.isStartButton = true
        }
        
        return newState
    }
}
