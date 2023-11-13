//
//  NextFiveDayView.swift
//  roomvu-challenge-task
//
//  Created by Mohammad Sadegh Panadgoo on 8/22/1402 AP.
//

import SwiftUI

import SwiftUI

struct NextFiveDayView: View {
    @Binding var weather: Weather?
    @Binding var forecasts: [Forecast]
    
    private let baseImageURL: String = "https://openweathermap.org/img/wn/#ICON_CODE#.png"
    
    // Function to filter forecasts
    func filterForecasts() -> [Forecast] {
        var uniqueDays: [Forecast] = []
        var lastDate: String?
        
        let today = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let todayString = dateFormatter.string(from: today)
        
        for forecast in forecasts {
            let date = Date(timeIntervalSince1970: TimeInterval(forecast.dt))
            let dateString = dateFormatter.string(from: date)
            
            if dateString != lastDate && dateString != todayString {
                uniqueDays.append(forecast)
                lastDate = dateString
            }
        }
        
        return uniqueDays
    }
    
    var body: some View {
        VStack {
            Text("Next 5 Days")
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            
            VStack {
                VStack {
                    HStack {
                        VStack {
                            Text("Today")
                                .font(.system(size: 15))
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Text(String(format: "%.1f", weather!.temperature ?? 0) + "°C")
                                .font(.system(size: 25, weight: .bold))
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Text(weather!.description)
                                .font(.system(size: 15))
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        
                        Spacer()
                        
                        AsyncImage(url: URL(string: baseImageURL.replacingOccurrences(of: "#ICON_CODE#", with: weather!.icon))) { image in
                            image
                                .resizable()
                                .scaledToFit()
                                .colorMultiply(Color.accentColor)
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 80, height: 80)
                    }
                    
                    Spacer()
                    
                    HStack(spacing: 5) {
                        ForEach(filterForecasts().prefix(5), id: \.dt) { (forecast: Forecast) in
                            DayCardView(dt: forecast.dt, icon: forecast.weather.first!.icon, description: forecast.weather.first!.main)
                        }
                    }.frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: 250)
                .background(Color.white)
                .cornerRadius(12)
                .shadow(radius: 3)
                
                Spacer()
                
                Text("Today Details")
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                VStack {
                    HStack {
                        TodayDetailCardView(title: "Humidity", imageString: "humidity", value: "\(weather!.humidity!)%")
                        TodayDetailCardView(title: "Wind", imageString: "wind", value: "\(weather!.windSpeed!) km/h")
                    }
                    
                    HStack {
                        TodayDetailCardView(title: "Feels Like", imageString: "drop.degreesign", value: "\(weather!.feelsLike!) °C")
                        TodayDetailCardView(title: "Pressure", imageString: "arrow.down.circle.fill", value: "\(weather!.pressure!) hPa")
                    }
                }
            
                Spacer()
                
            }
            .padding()
        }
    }
}
