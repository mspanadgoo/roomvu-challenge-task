//
//  DayCardView.swift
//  roomvu-challenge-task
//
//  Created by Mohammad Sadegh Panadgoo on 8/22/1402 AP.
//

import SwiftUI

struct DayCardView: View {
    var dt: TimeInterval
    var icon: String
    var description: String
    
    private let baseImageURL: String = "https://openweathermap.org/img/wn/#ICON_CODE#.png"
    
    var body: some View {
        VStack {
            Text(getDayOfWeek(from: dt))
                .font(.system(size: 12, weight: .bold))

            AsyncImage(url: URL(string: baseImageURL.replacingOccurrences(of: "#ICON_CODE#", with: icon))) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .colorMultiply(Color.accentColor)
            } placeholder: {
                ProgressView()
            }
            .frame(width: 60, height: 60)
            
            Text(description)
                .font(.system(size: 12))
        }
    }
    
    func getDayOfWeek(from timestamp: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: timestamp)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE"
        return dateFormatter.string(from: date)
    }
}
