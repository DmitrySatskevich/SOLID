//
//  DataStore.swift
//  SOLID
//
//  Created by dzmitry on 26.01.23.
//

import Foundation

// MARK: - DataStore

class DataStore {

    static let shared = DataStore()
    private init() { }

    public func saveName(name: String) {
        print("Your name: \(name) is saved")
    }

    public func getName() -> String {
        return "some name"
    }
}
