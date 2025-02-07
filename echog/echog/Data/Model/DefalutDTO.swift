//
//  DefalutDTO.swift
//  echog
//
//  Created by minsong kim on 2/4/25.
//

import Foundation

struct DefalutDTO: Decodable {
    let statusCode: String
    let message: String
    let data: String?
}
