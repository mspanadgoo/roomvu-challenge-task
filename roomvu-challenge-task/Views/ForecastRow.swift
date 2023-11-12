//
//  ForecastView.swift
//  roomvu-challenge-task
//
//  Created by Mohammad Sadegh Panadgoo on 8/20/1402 AP.
//

import SwiftUI

struct ForecastRow: View {
    let forecast: Forecast
    
    var body: some View {
        HStack {
            Text(formatDate(forecast.dt))
            Spacer()
            Image(systemName: forecast.weather.first?.icon ?? "")
            Text("\(forecast.main.temp)°C")
            Text("\(forecast.clouds.all)%")
            Text("\(forecast.wind.speed)m/s")
            Text("\(forecast.visibility)m")
            Text("\(forecast.pop)%")
        }
    }
    
    private func formatDate(_ timeInterval: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: timeInterval)
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        return dateFormatter.string(from: date)
    }
}
