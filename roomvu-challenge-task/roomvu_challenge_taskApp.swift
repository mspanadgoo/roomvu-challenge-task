//
//  roomvu_challenge_taskApp.swift
//  roomvu-challenge-task
//
//  Created by Mohammad Sadegh Panadgoo on 8/20/1402 AP.
//

import SwiftUI

@main
struct roomvu_challenge_taskApp: App {
    var searchHistory = SearchHistory()

    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(searchHistory)
        }
    }
}
