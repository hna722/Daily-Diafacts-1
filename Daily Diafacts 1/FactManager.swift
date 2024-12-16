//
//  FactManager.swift
//  Daily Diafacts 1
//
//  Created by Hannah Na on 12/15/24.
//

import Foundation

class FactManager {
    static let shared = FactManager()
    private let factsFileName = "facts.txt"
    private let userDefaultsKey = "lastFactDate"
    private let appGroup = "group.com.hannah.DailyDiafacts.shared"
    
    func getDailyFact() -> String {
        guard let sharedDefaults = UserDefaults(suiteName: appGroup) else { return "Error loading fact." }
        
        let currentDate = Calendar.current.startOfDay(for: Date())
        if let lastFactDate = sharedDefaults.object(forKey: userDefaultsKey) as? Date,
           Calendar.current.isDate(lastFactDate, inSameDayAs: currentDate),
           let savedFact = sharedDefaults.string(forKey: "dailyFact") {
            return savedFact
        }
        
        let facts = loadFacts()
        guard !facts.isEmpty else { return "No facts available." }
        
        let fact = facts.randomElement() ?? "No facts found."
        sharedDefaults.set(currentDate, forKey: userDefaultsKey)
        sharedDefaults.set(fact, forKey: "dailyFact")
        return fact
    }
    
    private func loadFacts() -> [String] {
        guard let filePath = Bundle.main.path(forResource: "facts", ofType: "txt"),
              let content = try? String(contentsOfFile: filePath) else { return [] }
        return content.components(separatedBy: "\n").filter { !$0.isEmpty }
    }
}

