//
//  View.swift
//  echog
//
//  Created by minsong kim on 2/4/25.
//

protocol View: AnyObject {
    associatedtype Store: StoreProtocol
    
    var store: Store { get set }
    init(store: Store)
}
