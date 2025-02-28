//
//  MyPageStore.swift
//  echog
//
//  Created by minsong kim on 2/20/25.
//

import Combine
import Foundation

final class MyPageStore: StoreProtocol {
    typealias Reducer = MyPageReducer
    
    var cancellables = Set<AnyCancellable>()
    @Published var state: MyPageReducer.State
    var reducer: MyPageReducer
    
    init(reducer: MyPageReducer) {
        self.reducer = reducer
        self.state = reducer.initialState
    }
    
    func dispatch(_ intent: MyPageReducer.Intent) {
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
