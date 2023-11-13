//
//  IdentifiableError.swift
//  roomvu-challenge-task
//
//  Created by Mohammad Sadegh Panadgoo on 8/22/1402 AP.
//

import Foundation

struct IdentifiableError: Error, Identifiable {
    let underlyingError: Error
    var id: String { localizedDescription }
    var localizedDescription: String {
        underlyingError.localizedDescription
    }
    
    init(_ error: Error) {
        self.underlyingError = error
    }
}
