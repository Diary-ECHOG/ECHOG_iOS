//
//  InformationLoadingStore.swift
//  echog
//
//  Created by minsong kim on 2/5/25.
//

import Combine
import Foundation

final class InformationLoadingStore: StoreProtocol {
    typealias Reducer = InformationLoadingReducer
    
    var cancellables = Set<AnyCancellable>()
    @Published var state: InformationLoadingReducer.State
    var reducer: InformationLoadingReducer
    
    init(reducer: InformationLoadingReducer) {
        self.reducer = reducer
        self.state = reducer.initialState
    }
    
    func dispatch(_ intent: InformationLoadingReducer.Intent) {
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
