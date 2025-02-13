//
//  StoreProtocol.swift
//  echog
//
//  Created by minsong kim on 2/5/25.
//

import Combine
import Foundation

protocol StoreProtocol: ObservableObject {
    associatedtype Reducer: ReducerProtocol
    
    var state: Reducer.State { get set }
    var reducer: Reducer { get }
    var cancellables: Set<AnyCancellable> { get set }
    
    init(reducer: Reducer)
    
    func dispatch(_ intent: Reducer.Intent)
}
