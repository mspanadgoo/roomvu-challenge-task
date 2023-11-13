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
    
    // Define a grid layout
    let layout = [
        GridItem(.flexible(minimum: 170), spacing: 20)
    ]
    
    var body: some View {
        VStack {
            // Display the weather view if the weather data is available
            if let weather = weather {
                WeatherView(weather: weather)
            }
            
            HStack {
                // Title for the forecast section
                Text("Today Every 3 Hours")
                    .bold()
                Spacer()
            }
            .padding()
            
            // Display the forecast rows if the forecast data is available
            if !forecasts.isEmpty {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHGrid(rows: layout, spacing: 20) {
                        ForEach(0..<5) { index in
                            ForecastRow(forecast: forecasts[index])
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
    }
}

