//
//  ContentView.swift
//  AppleWeatherSwift
//
//  Created by Filip Štěpánek on 01.11.2023.
//

import SwiftUI
import CoreLocationUI

struct ContentView: View {
    
    @ObservedObject var todayViewModel: TodayViewModel
    @ObservedObject var forecastViewModel: ForecastViewModel
    
    init(todayViewModel: TodayViewModel, forecastViewModel: ForecastViewModel) {
        self.todayViewModel = todayViewModel
        self.forecastViewModel = forecastViewModel
    }
    
    var body: some View {
        TabView {
            TodayView(viewModelToday: todayViewModel)
                .tabItem {
                    Image(.tabBarToday)
                    Text("today.Tabbar.Title")
                        .font(.tabBarFont)
                        .background()
                }
                .tag(0)
                .toolbarBackground(.mainBackground, for: .tabBar)
            
            ForecastView(viewModelForecast: forecastViewModel)
                .tabItem {
                    Image(.tabBarForecast)
                    Text("forecast.TabBar.Title")
                        .font(.tabBarFont)
                        .background(.tabBar)
                }
                .tag(1)
                .toolbarBackground(.mainBackground, for: .tabBar)
        }
        .accentColor(.tabBar)
    }
    
    
}

#if DEBUG
#Preview {
    ContentView(todayViewModel: TodayViewModel(), forecastViewModel: ForecastViewModel())
}
#endif
