//
//  AppGroup.swift
//  SOLID
//
//  Created by dzmitry on 25.01.23.
//

import Foundation

struct  AppGroup: Decodable {
    let feed: Feed
}

struct Feed: Decodable {
    let title: String
    let results: [FeedResult]
}

struct FeedResult: Decodable {
    let artistName: String
    let name: String
    let id: String
}
