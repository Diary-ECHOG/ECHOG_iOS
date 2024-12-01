//
//  BaseURLResolvable.swift
//  echog
//
//  Created by minsong kim on 11/19/24.
//

import Foundation

protocol BaseURLResolvable {
    func resolve(for type: BaseURLType) -> URL?
}
