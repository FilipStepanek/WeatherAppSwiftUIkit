//
//  ForecastViewRepresentable.swift
//  AppleWeatherSwift
//
//  Created by Filip Štěpánek on 08.01.2024.
//

//import SwiftUI
//
//struct ForecastViewRepresentable: UIViewControllerRepresentable {
//    typealias UIViewControllerType = ForecastContentView
//    func makeUIViewController(context: Context) -> ForecastContentView {
//        ForecastContentView()
//    }
//    
//    func updateUIViewController(_ uiViewController: ForecastContentView, context: Context) {
//        // Update the view controller if needed
//    }
//}
//
//#if DEBUG
//#Preview {
//    ForecastViewRepresentable()
//}
//#endif

//import SwiftUI
//
//struct ForecastViewRepresentableWrapper: UIViewRepresentable {
//    typealias UIViewType = ForecastContentView
//    
//    let weatherNow: CurrentResponse
//    let weather: ForecastResponse
//    
//    func makeUIView(context: Context) -> ForecastContentView {
//        return ForecastContentView(weatherNow: weatherNow, weather: weather)
//    }
//    
//    func updateUIView(_ uiView: ForecastContentView, context: Context) {
//        // Update the view if needed
//    }
//}
//
//#if DEBUG
//struct ForecastViewRepresentableWrapper_Previews: PreviewProvider {
//    static var previews: some View {
//        ForecastViewRepresentableWrapper(weatherNow: .previewMock, weather: .previewMock)
//    }
//}
//#endif

import SwiftUI

struct ForecastViewRepresentableWrapper: UIViewRepresentable {
    func makeUIView(context: Context) -> ForecastContentView {
        return ForecastContentView()
    }
    
    func updateUIView(_ uiView: ForecastContentView, context: Context) {
        // Update the view if needed
    }
}

#if DEBUG
struct ForecastViewRepresentableWrapper_Previews: PreviewProvider {
    static var previews: some View {
        ForecastViewRepresentableWrapper()
    }
}
#endif


