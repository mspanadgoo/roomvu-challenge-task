//
//  TodayEveryThreeHoursView.swift
//  roomvu-challenge-task
//
//  Created by Mohammad Sadegh Panadgoo on 8/22/1402 AP.
//

import SwiftUI

struct TodayEveryThreeHoursView: View {
    @Binding var forecasts: [Forecast]

    let layout = [
        GridItem(.flexible(minimum: 180), spacing: 20)
    ]
    var body: some View {
        VStack {
            Text("Today Every 3 Hours")
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            
            if !forecasts.isEmpty {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHGrid(rows: layout, spacing: 20) {
                        ForEach(0..<5) { index in
                            ForecastRow(forecast: forecasts[index])
                        }
                    }.padding(.horizontal, 20)
                }
            }
        }
    }
}
