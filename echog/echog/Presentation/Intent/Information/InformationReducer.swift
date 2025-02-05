//
//  InformationReducer.swift
//  echog
//
//  Created by minsong kim on 1/12/25.
//

import Combine
import Foundation

struct InformationReducer: ReducerProtocol {
    enum Intent {
        case sendEmail(String)
    }
    
    enum Mutation {
        case sendEmailSuccess(String)
        case sendEmailFailure
    }
    
    struct State {
        var email: String = ""
        var code: String = ""
        var password: String = ""
        var isCodeSendSuccess: Bool = false
    }
    
    let initialState = State()
    
    private let userNetwork: UserNetwork
    
    init(networkManager: NetworkManager) {
        self.userNetwork = UserNetwork(networkManager: networkManager)
    }
    
    func mutate(action: Intent) -> AnyPublisher<Mutation, Never> {
        switch action {
        case .sendEmail(let newEmail):
            return Future<Mutation, Never> { promise in
                Task {
                    do {
                        _ = try await userNetwork.emailCodeRequest(email: newEmail)
                        promise(.success(.sendEmailSuccess(newEmail)))
                    } catch {
                        promise(.success(.sendEmailFailure))
                    }
                }
            }
            .eraseToAnyPublisher()
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .sendEmailSuccess(let newEmail):
            newState.email = newEmail
            newState.isCodeSendSuccess = true
        case .sendEmailFailure:
            newState.isCodeSendSuccess = false
        }
        
        return newState
    }
}
