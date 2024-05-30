//
//  MyLocationView.swift
//  AppleWeatherSwift
//
//  Created by Filip Štěpánek on 01.11.2023.
//

import SwiftUI

struct TodayView: View {
    // TODO: Make it private again, add init
    @ObservedObject var viewModelToday: TodayViewModel
    
    var body: some View {
        ZStack {
            switch viewModelToday.state {
            case .loading:
                LoadingView()
            case .missingLocation:
                EnableLocationView()
            case .success(let currentResponse):
                TodayViewContent(viewModel: viewModelToday, weather: currentResponse)
            case .error:
                ErrorFetchingDataView {
                    viewModelToday.onRefresh()
                }
            case .errorNetwork:
                ErrorInternetConnectionView {
                    viewModelToday.onRefresh()
                }
            }
        }
    }
}

#if DEBUG
#Preview {
    TodayView(viewModelToday: .init())
}
#endif
