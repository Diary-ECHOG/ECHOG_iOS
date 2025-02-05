//
//  ReducerProtocol.swift
//  echog
//
//  Created by minsong kim on 2/4/25.
//

import Combine

protocol ReducerProtocol {
    associatedtype Intent
    associatedtype Mutation
    associatedtype State
    
    var initialState: State { get }
    
    init (networkManager: NetworkManager)
    
    func mutate(action: Intent) -> AnyPublisher<Mutation, Never>
    func reduce(state: State, mutation: Mutation) -> State
}

extension ReducerProtocol {
    func sideEffect(_ effect: @escaping () -> Void) {
        effect()
    }
}

protocol MutationProtocol {
    
}
