//
//  OnBoardingStore.swift
//  echog
//
//  Created by minsong kim on 2/5/25.
//

import Combine
import Foundation

final class OnBoardingStore: StoreProtocol {
    typealias Reducer = OnBoardingReducer
    
    var cancellables = Set<AnyCancellable>()
    @Published var state: OnBoardingReducer.State
    var reducer: OnBoardingReducer
    
    init(reducer: OnBoardingReducer) {
        self.reducer = reducer
        self.state = reducer.initialState
    }
    
    func dispatch(_ intent: OnBoardingReducer.Intent) {
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
