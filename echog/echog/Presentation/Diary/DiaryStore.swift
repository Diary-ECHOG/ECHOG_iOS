//
//  DiaryStore.swift
//  echog
//
//  Created by minsong kim on 2/17/25.
//

import Combine
import Foundation

final class DiaryStore: StoreProtocol {
    typealias Reducer = DiaryReducer
    
    var cancellables = Set<AnyCancellable>()
    @Published var state: DiaryReducer.State
    var reducer: DiaryReducer
    
    init(reducer: DiaryReducer) {
        self.reducer = reducer
        self.state = reducer.initialState
    }
    
    func dispatch(_ intent: DiaryReducer.Intent) {
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
