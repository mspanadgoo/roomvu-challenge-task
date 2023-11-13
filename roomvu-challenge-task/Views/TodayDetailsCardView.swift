//
//  TodayDetailsCardView.swift
//  roomvu-challenge-task
//
//  Created by Mohammad Sadegh Panadgoo on 8/22/1402 AP.
//

import SwiftUI

struct TodayDetailsCardView: View {
    @Binding var weather: Weather?

    var body: some View {        
        VStack {
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
        }
    }
}
