//
//  LogInReducer.swift
//  echog
//
//  Created by minsong kim on 2/13/25.
//

import Combine
import Foundation
import NetworkFeatureKit
import KeyChainModule

struct LogInReducer: ReducerProtocol {
    enum Intent {
        case goToLogIn(email: String, password: String)
        case goToFindPassword
        case goToSignIn
        case goToDiaryHome
        case goToLogInPage
    }
    
    enum Mutation {
        case logInFailure
    }
    
    struct State {
        var isLogInSuccess: TryState = .notYet
    }
    
    var initialState = State()
    
    weak var delegate: Coordinator?
    
    func mutate(action: Intent) -> AnyPublisher<Mutation, Never>? {
        switch action {
        case .goToLogIn(let email, let password):
            return Future<Mutation, Never> { promise in
                Task { @MainActor in
                    do {
                        let user = try await UserNetwork.shared.login(email: email, password: password)
                        //성공하면 키체인에 토큰들 저장한 후 완료 페이지로 이동
                        try KeyChainModule.create(key: .accessToken, data: user.data.token)
                        try KeyChainModule.create(key: .refreshToken, data: user.data.refreshToken)
                        try KeyChainModule.create(key: .isLogin, data: "true")
                        (delegate as? LogInCoordinator)?.pushLogInCompleteViewController()
                    } catch is KeyChainError {
                        (delegate as? LogInCoordinator)?.pushLogInCompleteViewController()
                    } catch {
                        promise(.success(.logInFailure))
                    }
                }
            }
            .eraseToAnyPublisher()
        case .goToFindPassword:
            (delegate as? LogInCoordinator)?.goToPasswordViewController()
            return nil
        case .goToSignIn:
            (delegate as? LogInCoordinator)?.goToSignInViewController()
            return nil
        case .goToDiaryHome:
            (delegate as? LogInCoordinator)?.goToDiaryHomeViewController()
            return nil
        case .goToLogInPage:
            (delegate as? PasswordCoordinator)?.goToLogInViewController()
            return nil
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .logInFailure:
            newState.isLogInSuccess = .failure
        }
        
        return newState
    }
}
