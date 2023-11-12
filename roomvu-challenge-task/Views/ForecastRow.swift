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
            Text(formatDate(forecast.dt ?? 0))
            Spacer()
            Image(systemName: forecast.weather?.first?.icon ?? "")
            Text("\(forecast.main?.temp ?? 0)°C")
            Text("\(forecast.clouds?.all ?? 0)%")
            Text("\(forecast.wind?.speed ?? 0)m/s")
            Text("\(forecast.visibility ?? 0)m")
            Text("\(forecast.pop ?? 0)%")
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
