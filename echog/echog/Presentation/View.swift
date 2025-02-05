//
//  View.swift
//  echog
//
//  Created by minsong kim on 2/4/25.
//

protocol View: AnyObject {
    associatedtype Store: StoreProtocol
    associatedtype Reducer: ReducerProtocol
    
    var store: Store { get set }
    init(reducer: Reducer)
}
