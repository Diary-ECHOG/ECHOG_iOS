//
//  InformationStore.swift
//  echog
//
//  Created by minsong kim on 2/5/25.
//

import Combine
import Foundation

final class InformationStore: StoreProtocol {
    typealias Reducer = InformationReducer
    
    var cancellables = Set<AnyCancellable>()
    @Published var state: InformationReducer.State
    var reducer: InformationReducer
    
    init(reducer: InformationReducer) {
        self.reducer = reducer
        self.state = reducer.initialState
    }
    
    func dispatch(_ intent: InformationReducer.Intent) {
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
