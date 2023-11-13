//
//  ForecastView.swift
//  roomvu-challenge-task
//
//  Created by Mohammad Sadegh Panadgoo on 8/20/1402 AP.
//

import SwiftUI

struct ForecastRow: View {
    let forecast: Forecast
    
    // Base URL for weather icons
    private let baseImageURL: String = "https://openweathermap.org/img/wn/#ICON_CODE#.png"
    
    var body: some View {
        VStack {
            // Display the time
            let date = Date(timeIntervalSince1970: forecast.dt)
            Text(formatDate(date))
                .font(.system(size: 15, weight: .bold))
            
            // Display the weather icon
            AsyncImage(url: URL(string: baseImageURL.replacingOccurrences(of: "#ICON_CODE#", with: forecast.weather.first?.icon ?? ""))) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .colorMultiply(Color.accentColor)
            } placeholder: {
                ProgressView()
            }
            .frame(width: 80, height: 80)
            
            // Display the temperature
            Text(String(format: "%.1f", forecast.main.temp) + " °C")
                .font(.system(size: 15, weight: .bold))
        }
        .padding()
        .frame(maxWidth: 95, maxHeight: 170)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 3)
    }
    
    func formatDate(_ date: Date) -> String {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute], from: date)
        let hour = components.hour ?? 0
        let minute = components.minute ?? 0
        return String(format: "%02d:%02d", hour, minute)
    }
}
