//
//  File.swift
//  HorseRaces
//
//  Created by Naira on 10.04.2025.
//

import Foundation
import Foundation

class RaceHistory {
    static let shared = RaceHistory()
    private init() {}
    
    private(set) var races: [String] = []
    
    func addRace(result: String) {
        races.insert(result, at: 0)
    }
    
    func clearHistory() {
        races.removeAll()
    }
}
