//
//  InformationLoadingReducer.swift
//  echog
//
//  Created by minsong kim on 2/5/25.
//

import Combine
import UIKit

struct InformationLoadingReducer: ReducerProtocol {
    enum Page {
        case Information
        case LogIn
    }
    
    enum Intent {
        case goToNext(Page)
        case changeWelcomeText
    }
    
    enum Mutation {
        case welcome
    }
    
    struct State {
        var page: Page
        var text: String
    }
    
    weak var delegate: InformationCoordinator?
    
    var initialState: State = State(page: .Information,text: "먼저 당신의 정보를\n알고싶어요")
    
    func mutate(action: Intent) -> AnyPublisher<Mutation, Never>? {
        switch action {
        case .goToNext(let page):
            if page == .Information {
                delegate?.pushInformationViewController()
            } else {
                //로그인 페이지로 이동
                delegate?.goToLogInViewController()
            }
            return nil
        case .changeWelcomeText:
            return Just(Mutation.welcome).eraseToAnyPublisher()
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .welcome:
            newState.page = .LogIn
            newState.text = "가입을\n축하합니다!"
        }
        
        return newState
    }
}
