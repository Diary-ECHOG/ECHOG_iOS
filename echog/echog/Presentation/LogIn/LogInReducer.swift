//
//  LogInReducer.swift
//  echog
//
//  Created by minsong kim on 2/13/25.
//

import Combine
import Foundation

struct LogInReducer: ReducerProtocol {
    enum Intent {
        case goToLogIn(email: String, password: String)
        case goToFindPassword
        case goToSignIn
    }
    
    enum Mutation {
        case logInFailure
    }
    
    struct State {
        var isLogInSuccess: TryState = .notYet
    }
    
    var initialState = State()
    
    weak var delegate: LogInCoordinator?
    private let userNetwork: UserNetwork
    
    init(networkManager: NetworkManager) {
        self.userNetwork = UserNetwork(networkManager: networkManager)
    }
    
    func mutate(action: Intent) -> AnyPublisher<Mutation, Never>? {
        switch action {
        case .goToLogIn(let email, let password):
            return Future<Mutation, Never> { promise in
                Task { @MainActor in
                    do {
                        let user = try await userNetwork.login(email: email, password: password)
                        //성공하면 키체인에 토큰들 저장한 후 완료 페이지로 이동
                        KeyChain.create(key: .accessToken, data: user.data.token)
                        KeyChain.create(key: .refreshToken, data: user.data.refreshToken)
                        delegate?.pushLogInCompleteViewController()
                    } catch {
                        promise(.success(.logInFailure))
                    }
                }
            }
            .eraseToAnyPublisher()
        case .goToFindPassword:
            delegate?.pushPasswordFinderViewController()
            return nil
        case .goToSignIn:
            delegate?.goToSignInViewController()
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
