//
//  TodayView.swift
//  roomvu-challenge-task
//
//  Created by Mohammad Sadegh Panadgoo on 8/22/1402 AP.
//

import SwiftUI

struct TodayView: View {
    @Binding var weather: Weather?
    @Binding var forecasts: [Forecast]

    var body: some View {
        VStack {
            if let weather = weather {
                WeatherView(weather: weather)
                    .padding()
            }
            
            TodayEveryThreeHoursView(forecasts: $forecasts)
            Spacer()
        }
    }
}

