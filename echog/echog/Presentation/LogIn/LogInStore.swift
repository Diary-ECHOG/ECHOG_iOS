//
//  LogInStore.swift
//  echog
//
//  Created by minsong kim on 2/13/25.
//

import Combine
import Foundation

final class LogInStore: StoreProtocol {
    typealias Reducer = LogInReducer
    
    var cancellables = Set<AnyCancellable>()
    @Published var state: LogInReducer.State
    var reducer: LogInReducer
    
    init(reducer: LogInReducer) {
        self.reducer = reducer
        self.state = reducer.initialState
    }
    
    func dispatch(_ intent: LogInReducer.Intent) {
        let mutationPublisher = reducer.mutate(action: intent)
        
        mutationPublisher?
            .sink { [weak self] mutation in
                guard let self else { return }
               
                let newState = self.reducer.reduce(state: self.state, mutation: mutation)
                self.state = newState
            }
            .store(in: &cancellables)
    }
}
