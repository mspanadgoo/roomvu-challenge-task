//
//  SecondPageView.swift
//  roomvu-challenge-task
//
//  Created by Mohammad Sadegh Panadgoo on 8/22/1402 AP.
//

import SwiftUI

struct SecondPageView: View {
    @Binding var weather: Weather?
    @Binding var forecasts: [Forecast]
    
    

    
    var body: some View {
        VStack {
            Next5DaysView(weather: $weather, forecasts: $forecasts)
                .padding()
            TodayDetailsCardView(weather: $weather)
                .padding()
            Spacer()
        }
        .padding(.horizontal)
    }
}
