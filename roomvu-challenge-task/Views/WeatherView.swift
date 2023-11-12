//
//  WeatherView.swift
//  roomvu-challenge-task
//
//  Created by Mohammad Sadegh Panadgoo on 8/20/1402 AP.
//

import SwiftUI

struct WeatherView: View {
    let weather: Weather
    
    private let baseImageURL: String = "https://openweathermap.org/img/wn/#ICON_CODE#.png"
    
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE, MMM d, yyyy h:mm a"
        return formatter
    }()
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "mappin")
                    .foregroundStyle(.gray)
                Text("\(weather.location!)")
                    .font(.system(size: 20, weight: .semibold))
            }
            
            Text(Date(), formatter: Self.dateFormatter)
                .font(.system(size: 15))
                .foregroundStyle(Color.gray)
            
            HStack {
                AsyncImage(url: URL(string: baseImageURL.replacingOccurrences(of: "#ICON_CODE#", with: weather.icon!))) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .colorMultiply(Color.accentColor)
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 80, height: 80)

                Text("\(String(format: "%.2f", weather.temperature!)) °C")
                    .font(.system(size: 35, weight: .bold))
            }
            
            Text("\(String(format: "%.2f", weather.minTemp!))°/\(String(format: "%.2f", weather.maxTemp!))° Feels Like \(String(format: "%.2f", weather.feelsLike!))°")
            Text("\(weather.description ?? "Not Available")")
            
            Text("Description: \(weather.description!)")
            Text("Humidity: \(String(format: "%.2f", weather.humidity!)) %")
            Text("Wind Speed: \(String(format: "%.2f", weather.windSpeed!)) km/h")
        }
    }
}
