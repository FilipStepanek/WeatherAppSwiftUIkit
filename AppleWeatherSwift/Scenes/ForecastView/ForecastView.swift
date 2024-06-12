//
//  ForecastView.swift
//  AppleWeatherSwift
//
//  Created by Filip Štěpánek on 01.11.2023.
//

import SwiftUI

struct ForecastView: View {

    @StateObject private var forecastViewModel = ForecastViewModel()

    var body: some View {
        ZStack {
            switch forecastViewModel.state {
            case .loading:
                LoadingView()
            case .missingLocation:
                EnableLocationView()
            case .success(
                let forecastResponse,
                let currentResponse
            ):
                ForecastViewControllerWrapper(
                    weather: forecastResponse,
                    weatherNow: currentResponse, 
                    forecastViewModel: forecastViewModel
                )
            case .error:
                ErrorFetchingDataView {
                    forecastViewModel.onRefresh()
                }
            case .errorNetwork:
                ErrorInternetConnectionView {
                    forecastViewModel.onRefresh()
                }
            }
        }
    }
}
