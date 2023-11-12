//
//  Rain.swift
//  roomvu-challenge-task
//
//  Created by Mohammad Sadegh Panadgoo on 8/20/1402 AP.
//

import Foundation

struct Rain: Codable {
    let oneHour, treeHours: Double?

    enum CodingKeys: String, CodingKey {
        case oneHour = "1h"
        case treeHours = "3h"
    }
}
