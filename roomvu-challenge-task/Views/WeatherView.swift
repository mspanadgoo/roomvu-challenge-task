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
            locationRow
            dateRow
            weatherRow
            temperatureRow
            descriptionRow
            detailsRow
            Spacer()
        }
        .padding()
    }
    
    private var locationRow: some View {
        HStack {
            Image(systemName: "mappin")
                .foregroundStyle(.gray)
            Text(weather.location ?? "")
                .font(.system(size: 20, weight: .semibold))
        }
    }
    
    private var dateRow: some View {
        guard let dateTime = weather.dateTime else { return AnyView(EmptyView()) }
        let date = Date(timeIntervalSince1970: dateTime)
        
        return AnyView(
            Text(date, formatter: Self.dateFormatter)
                .font(.system(size: 15))
                .foregroundStyle(Color.gray)
        )
    }
    
    private var weatherRow: some View {
        HStack {
            weatherIcon
            Text(String(format: "%.1f", weather.temperature ?? 0) + "°C")
                .font(.system(size: 35, weight: .bold))
        }
    }
    
    private var weatherIcon: some View {
        AsyncImage(url: URL(string: baseImageURL.replacingOccurrences(of: "#ICON_CODE#", with: weather.icon))) { image in
            image
                .resizable()
                .scaledToFit()
                .colorMultiply(Color.accentColor)
        } placeholder: {
            ProgressView()
        }
        .frame(width: 80, height: 80)
    }
    
    private var temperatureRow: some View {
        Text(String(format: "%.1f", weather.minTemp ?? 0) + "° / " + String(format: "%.1f", weather.maxTemp ?? 0) + "° Feels Like " + String(format: "%.1f", weather.feelsLike ?? 0) + "°")
            .bold()
    }
    
    private var descriptionRow: some View {
        Text(weather.description)
            .bold()
    }
    
    private var detailsRow: some View {
        HStack {
            Spacer()
            humidityRow
            Spacer()
            Divider()
                .background(Color.gray)
            Spacer()
            windSpeedRow
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: 70)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 3)
    }
    
    private var humidityRow: some View {
        HStack {
            Image(systemName: "humidity")
                .resizable()
                .frame(width: 30, height: 30)
                .foregroundColor(.accentColor)
                .padding()
            
            VStack(alignment: .leading) {
                Text("Humidity")
                    .font(.system(size: 15))
                Text(String(format: "%.1f", weather.humidity ?? 0) + "%")
                    .font(.system(size: 15))
                    .bold()
            }
        }
    }
    
    private var windSpeedRow: some View {
        HStack {
            Image(systemName: "wind")
                .resizable()
                .frame(width: 30, height: 30)
                .foregroundColor(.accentColor)
                .padding()
            
            VStack(alignment: .leading) {
                Text("Wind Speed")
                    .font(.system(size: 15))
                Text(String(format: "%.1f", weather.windSpeed ?? 0) + " km/h")
                    .font(.system(size: 15))
                    .bold()
            }
        }
    }
}

#Preview {
    ContentView()
}
