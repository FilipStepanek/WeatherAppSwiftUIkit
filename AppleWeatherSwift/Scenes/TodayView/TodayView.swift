//
//  MyLocationView.swift
//  AppleWeatherSwift
//
//  Created by Filip Štěpánek on 01.11.2023.
//

import SwiftUI

struct TodayView: View {
    // TODO: Make it private again, add init
    @StateObject private var todayViewModel = TodayViewModel()
    
    var body: some View {
        ZStack {
            switch todayViewModel.state {
            case .loading:
                LoadingView()
            case .missingLocation:
                EnableLocationView()
            case .success(let currentResponse):
                TodayViewContent(weather: currentResponse)
            case .error:
                ErrorFetchingDataView {
                    todayViewModel.onRefresh()
                }
            case .errorNetwork:
                ErrorInternetConnectionView {
                    todayViewModel.onRefresh()
                }
            }
        }
        .environmentObject(todayViewModel)
    }
}

#if DEBUG
#Preview {
    TodayView()
}
#endif
