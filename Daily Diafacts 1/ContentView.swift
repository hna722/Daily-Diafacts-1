//
//  ContentView.swift
//  Daily Diafacts 1
//
//  Created by Hannah Na on 12/15/24.
//

import SwiftUI

struct ContentView: View {
    @State private var dailyFact: String = "Loading..."
    
    var lightblue = Color(red: 0.7, green: 0.85, blue: 1.0)
    
    var lighterblue = Color(red: 0.80, green: 0.90, blue: 30.0)
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [.blue, lightblue]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
        VStack {
            
            Text("Diabetes")
                .font(.custom("Megan Beauty", size: 70))
                .foregroundColor(.black)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding()
                .padding()
            
            Text("Fact of the Day!")
                .font(.custom("Megan Beauty", size: 40))
                .multilineTextAlignment(.center)
                .foregroundColor(.black)

            Spacer()
            
            Text(dailyFact)
                .font(.custom("AppleGaramond", size: 25))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10.0)
                        .foregroundColor(lighterblue)
                        .shadow(radius: 20))
            
            Spacer()
            
            Spacer()
            
            Text("Please consult with healthcare professionals before making changes to your diabetes management")
                .font(.footnote)
                .multilineTextAlignment(.center)
        }
        .padding()
        .onAppear {
            dailyFact = FactManager.shared.getDailyFact()
        }
        }
    }
}


#Preview {
    ContentView()
}
