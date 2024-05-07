//
//  ForecastViewRepresentable.swift
//  AppleWeatherSwift
//
//  Created by Filip Štěpánek on 08.01.2024.
//

import SwiftUI

struct ForecastViewRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = ForecastContentView
    func makeUIViewController(context: Context) -> ForecastContentView {
        ForecastContentView()
    }
    
    func updateUIViewController(_ uiViewController: ForecastContentView, context: Context) {
        // Update the view controller if needed
    }
}

#if DEBUG
#Preview {
    ForecastViewRepresentable()
}
#endif

