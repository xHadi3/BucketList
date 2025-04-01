//
//  Result.swift
//  BucketList
//
//  Created by Hadi Al zayer on 03/10/1446 AH.
//

import Foundation

struct Result: Codable {
    let query: Query
}

struct Query: Codable {
    let pages: [Int: Page]
}

struct Page: Codable {
    let pageid: Int
    let title: String
    let terms: [String: [String]]?
}

