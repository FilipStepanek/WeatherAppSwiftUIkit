//
//  ForecastDayInfoView.swift
//  AppleWeatherSwift
//
//  Created by Filip Štěpánek on 28.11.2023.
//

import UIKit

class ForecastHeaderInfoView: UIView {
    
    let dayIndex: Int
    
    init(dayIndex: Int) {
        self.dayIndex = dayIndex
        super.init(frame: .zero)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(dayLabel)
        addSubview(dateLabel)
        backgroundColor = .mainBackground
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            dayLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            dayLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            dayLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            
            dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            dateLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            dateLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        dayLabel.text = dayHeaderText()
        dateLabel.text = currentDate(for: dayIndex)
    }
    
    private func currentDate(for dayIndex: Int) -> String {
        let date = Calendar.current.date(byAdding: .day, value: dayIndex, to: Date()) ?? Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, d MMM "
        return formatter.string(from: date)
    }
    
    private func dayHeaderText() -> String {
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
        return ForecastHeaderInfoView(dayIndex: dayIndex)
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
