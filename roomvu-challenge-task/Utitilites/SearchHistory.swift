//
//  SearchHistory.swift
//  roomvu-challenge-task
//
//  Created by Mohammad Sadegh Panadgoo on 8/22/1402 AP.
//

import Foundation

class SearchHistory: ObservableObject {
    @Published var items: [String] {
        didSet {
            UserDefaults.standard.set(self.items, forKey: "SearchHistory")
        }
    }

    init() {
        self.items = UserDefaults.standard.array(forKey: "SearchHistory") as? [String] ?? []
    }
}
