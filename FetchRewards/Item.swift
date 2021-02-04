//
//  Item.swift
//  FetchRewards
//
//  Created by Scott on 2/3/21.
//

import Foundation

struct Item: Codable {
    var id: Int?
    var listId: Int?
    var name: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case listId
        case name
    }
}

extension Item: Comparable {
    static func < (lhs: Item, rhs: Item) -> Bool {
        return lhs.listId ?? 0 < rhs.listId ?? 0
    }
}
