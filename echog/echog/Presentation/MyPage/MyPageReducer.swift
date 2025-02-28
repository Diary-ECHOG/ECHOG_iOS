//
//  MyPageReducer.swift
//  echog
//
//  Created by minsong kim on 2/20/25.
//

import Combine
import Foundation
import NetworkFeatureKit
import KeyChainModule

struct MyPageReducer: ReducerProtocol {
    
    enum Intent {
        case selectMyPage(IndexPath)
        case goToNextSignOutPage
        case popPage
        case signOut
        case goBackDiaryHome
    }
    
    enum Mutation {
        case signOutFailure
    }
    
    struct State {
        var isSignOutSuccess: TryState = .notYet
    }
    
    var initialState = State()
    
    weak var delegate: MyPageCoordinator?
    
    func mutate(action: Intent) -> AnyPublisher<Mutation, Never>? {
        switch action {
        case .selectMyPage(let indexPath):
            let page = MyPageSignOut(rawValue: indexPath.row)
            
            if page == .logOut {
                KeyChain.delete(key: .accessToken)
                KeyChain.delete(key: .refreshToken)
                delegate?.goToLogInViewController()
            } else if page == .checkTerms {
                delegate?.pushTermsViewController()
            } else if page == .signOut {
                delegate?.pushSignOutReasonViewController()
            }
            
            return nil
        case .goToNextSignOutPage:
            delegate?.pushSignOutConfirmViewController()
            return nil
        case .popPage:
            delegate?.popViewController()
            return nil
        case .signOut:
            return Future<Mutation, Never> { promise in
                Task { @MainActor in
                    do {
                        _ = try await UserNetwork.shared.signOut()
                        KeyChain.delete(key: .accessToken)
                        KeyChain.delete(key: .refreshToken)
                        delegate?.goToLogInViewController()
                    } catch {
                        promise(.success(.signOutFailure))
                    }
                }
            }
            .eraseToAnyPublisher()
        case .goBackDiaryHome:
            delegate?.goToDiaryViewController()
            return nil
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .signOutFailure:
            newState.isSignOutSuccess = .failure
        }
        
        return newState
    }
}
