//
//  TodayDetailCardView.swift
//  roomvu-challenge-task
//
//  Created by Mohammad Sadegh Panadgoo on 8/22/1402 AP.
//

import SwiftUI

struct TodayDetailCardView: View {
    var title: String
    var imageString: String
    var value: String
    
    var body: some View {
        HStack {
            Image(systemName: imageString)
                .resizable()
                .frame(width: 30, height: 30)
                .foregroundColor(.accentColor)
                .padding()
            
            Spacer()
            
            VStack {
                Text(value)
                    .font(.system(size: 15, weight: .bold))
                    .frame(maxWidth: .infinity, alignment: .leading)

                Text(title)
                    .font(.system(size: 15))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: 80)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 3)
    }
}
