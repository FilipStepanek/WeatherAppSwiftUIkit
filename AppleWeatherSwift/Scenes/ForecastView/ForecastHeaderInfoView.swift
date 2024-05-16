//
//  ForecastDayInfoView.swift
//  AppleWeatherSwift
//
//  Created by Filip Štěpánek on 28.11.2023.
//

//import UIKit
//// Only UIView
//class ForecastHeaderInfoView: UIView {
//    
//    private let dayLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.font = UIFont.dayInfoBase
//        label.textColor = .mainText
//        return label
//    }()
//
//    private let dateLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.font = UIFont.contentInfoSmallBase
//        label.textColor = .contentRegular
//        return label
//    }()
//    
//    let dayIndex: Int
//    
//    init(dayIndex: Int) {
//        self.dayIndex = dayIndex
//        super.init(frame: .zero)
//        setupUI()
//        setupConstraints()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    private func setupUI() {
//        addSubview(dayLabel)
//        addSubview(dateLabel)
//        backgroundColor = .mainBackground
//    }
//    
//    private func setupConstraints() {
//        NSLayoutConstraint.activate([
//            dayLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
//            dayLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
//            dayLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
//            
//            dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
//            dateLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
//            dateLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
//        ])
//    }
//    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        dayLabel.text = dayHeaderText()
//        dateLabel.text = currentDate(for: dayIndex)
//    }
//    
//    private func currentDate(for dayIndex: Int) -> String {
//        let date = Calendar.current.date(byAdding: .day, value: dayIndex, to: Date()) ?? Date()
//        let formatter = DateFormatter()
//        formatter.dateFormat = "EEEE, d MMM "
//        return formatter.string(from: date)
//    }
//    
//    private func dayHeaderText() -> String {
//        switch dayIndex {
//        case 0:
//            return NSLocalizedString("today.day.info", comment: "")
//        case 1:
//            return NSLocalizedString("tomorrow.day.info", comment: "")
//        default:
//            let date = Calendar.current.date(byAdding: .day, value: dayIndex, to: Date()) ?? Date()
//            let dayFormatter = DateFormatter()
//            dayFormatter.dateFormat = "EEEE"
//            return dayFormatter.string(from: date)
//        }
//    }
//}
//
//import SwiftUI
//
//struct ForecastHeaderInfoViewWrapper: UIViewRepresentable {
//    typealias UIViewType = ForecastHeaderInfoView
//    
//    let dayIndex: Int
//    
//    init(dayIndex: Int) {
//        self.dayIndex = dayIndex
//    }
//    
//    func makeUIView(context: Context) -> ForecastHeaderInfoView {
//        return ForecastHeaderInfoView(dayIndex: dayIndex)
//    }
//    
//    func updateUIView(_ uiView: ForecastHeaderInfoView, context: Context) {
//        // Update the view if needed
//    }
//}
//
//#if DEBUG
//struct ForecastHeaderInfoViewWrapper_Previews: PreviewProvider {
//    static var previews: some View {
//        ForecastHeaderInfoViewWrapper(dayIndex: 0)
//    }
//}
//#endif


import UIKit

class ForecastHeaderInfoView: UICollectionReusableView {
    // UI Components
    let dayLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.dayInfoBase
        label.textColor = .mainText
        return label
    }()

    let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.contentInfoSmallBase
        label.textColor = .contentRegular
        return label
    }()
    
    var dayIndex: Int {
        didSet {
            // Update UI when dayIndex changes
            dayLabel.text = dayHeaderText()
            dateLabel.text = currentDate(for: dayIndex)
        }
    }
    
    override init(frame: CGRect) {
        // Provide a stub implementation for the required initializer
        self.dayIndex = 0 // Assign a default value to avoid crash
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(dayLabel)
        addSubview(dateLabel)
//        backgroundColor = .mainBackground
        backgroundColor = .orange
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            dayLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            dayLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            dateLabel.centerYAnchor.constraint(equalTo: dayLabel.centerYAnchor)
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        dayLabel.text = dayHeaderText()
        dateLabel.text = currentDate(for: dayIndex)
    }
    
    func currentDate(for dayIndex: Int) -> String {
        let date = Calendar.current.date(byAdding: .day, value: dayIndex, to: Date()) ?? Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, d MMM "
        return formatter.string(from: date)
    }
    
    func dayHeaderText() -> String {
        switch dayIndex {
        case 0:
            return NSLocalizedString("today.day.info", comment: "")
        case 1:
            return NSLocalizedString("tomorrow.day.info", comment: "")
        default:
            let date = Calendar.current.date(byAdding: .day, value: dayIndex, to: Date()) ?? Date()
            let dayFormatter = DateFormatter()
            dayFormatter.dateFormat = "EEEE"
            return dayFormatter.string(from: date)
        }
    }
}


import SwiftUI

struct ForecastHeaderInfoViewWrapper: UIViewRepresentable {
    typealias UIViewType = ForecastHeaderInfoView
    
    let dayIndex: Int
    
    init(dayIndex: Int) {
        self.dayIndex = dayIndex
    }
    
    func makeUIView(context: Context) -> ForecastHeaderInfoView {
        return ForecastHeaderInfoView()
    }
    
    func updateUIView(_ uiView: ForecastHeaderInfoView, context: Context) {
        // Update the view if needed
    }
}

#if DEBUG
struct ForecastHeaderInfoViewWrapper_Previews: PreviewProvider {
    static var previews: some View {
        ForecastHeaderInfoViewWrapper(dayIndex: 0)
    }
}
#endif


