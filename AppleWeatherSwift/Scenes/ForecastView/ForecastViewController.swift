//
//  ForecastViewController.swift
//  WeatherAppSwiftUIKit
//
//  Created by Filip Štěpánek on 13.05.2024.
//

import SwiftUI
import UIKit

struct ForecastViewControllerWrapper: UIViewControllerRepresentable {
    typealias UIViewControllerType = ForecastViewController
    
    let weather: ForecastResponse
    let weatherNow: CurrentResponse
    
    func makeUIViewController(context: Context) -> ForecastViewController {
        return ForecastViewController(weather: weather, weatherNow: weatherNow)
    }
    
    func updateUIViewController(_ uiViewController: ForecastViewController, context: Context) {
        // Update the view controller with new data if it has changed
        if uiViewController.weather != weather || uiViewController.weatherNow != weatherNow {
            uiViewController.weather = weather
            uiViewController.weatherNow = weatherNow
            
            // Update grouped data and reload collection view
            uiViewController.groupedData = uiViewController.groupForecastDataByDate()
            uiViewController.collectionView.reloadData()
        }
    }
}

class ForecastViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    var weather: ForecastResponse {
            didSet {
                // Any additional setup when weather is set, if needed
            }
        }
        
        var weatherNow: CurrentResponse {
            didSet {
                // Any additional setup when weatherNow is set, if needed
            }
        }
    
    fileprivate lazy var customNavigationBar: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Forecast"
        label.textAlignment = .left
        label.backgroundColor = .mainBackground
        label.textColor = .mainText
        label.font = UIFont.headlineTwo
        return label
    }()
    
    fileprivate lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        //        cv.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        // Register ForecastHeaderInfoView for section header
        cv.register(ForecastHeaderInfoView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
        cv.register(ForecastDetailView.self, forCellWithReuseIdentifier: "cell")
        cv.register(ForecastDetailNowView.self, forCellWithReuseIdentifier: "nowCell")
        
        cv.backgroundColor = .mainBackground // Set background color of collection view
        cv.delegate = self
        cv.dataSource = self
        
        cv.refreshControl = refreshControl
        
        return cv
    }()
    
    fileprivate lazy var collectionViewFlowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        // Set other layout properties as needed
        return layout
    }()
    
    private let refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        return refreshControl
    }()
    
    init(weather: ForecastResponse, weatherNow: CurrentResponse) {
        self.weather = weather
        self.weatherNow = weatherNow
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var groupedData: [String: [ForecastResponse.ListResponse]] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up collection view
        collectionView.collectionViewLayout = collectionViewFlowLayout
        
        // Enable sticky headers
        collectionViewFlowLayout.sectionHeadersPinToVisibleBounds = true
        
        // Add subviews and constraints...
        view.addSubview(customNavigationBar) // Adding the custom navigation bar as a subview
        view.addSubview(collectionView) // Adding the collection view as a subview
        
        NSLayoutConstraint.activate([
            customNavigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            customNavigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            customNavigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            customNavigationBar.heightAnchor.constraint(equalToConstant: 44), // Adjust the height as needed
            
            collectionView.topAnchor.constraint(equalTo: customNavigationBar.bottomAnchor, constant: 26),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        groupedData = groupForecastDataByDate()
    }
    
    @objc private func handleRefresh() {
        // Refresh logic here
        print("Refreshing data...")
        
        // Simulate network call or data update
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            // Stop the refresh control
            self.refreshControl.endRefreshing()
            
            // Update data and reload collection view
            self.groupedData = self.groupForecastDataByDate()
            self.collectionView.reloadData()
        }
    }
    
    func groupForecastDataByDate() -> [String: [ForecastResponse.ListResponse]] {
        var groupedData: [String: [ForecastResponse.ListResponse]] = [:]
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        // Assuming `weather` contains the list of forecast responses
        for forecast in weather.list { // Accessing the `list` property of `weather`
            let dateString = dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(forecast.date)))
            
            if var existingData = groupedData[dateString] {
                existingData.append(forecast)
                groupedData[dateString] = existingData
            } else {
                groupedData[dateString] = [forecast]
            }
        }
        
        return groupedData
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        let numberOfSections = groupedData.keys.count
        print("Number of sections: \(numberOfSections)")
        return numberOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width - 24 // Adjust spacing as needed
        return CGSize(width: width, height: 72) // Adjust height as needed
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let dates = Array(groupedData.keys.sorted())
        let dateString = dates[section]
        
        // Print the sorted dates
        print("Sorted dates: \(dates)")
        
        // Print the date string for the current section
        print("Date string for section \(section): \(dateString)")
        
        // Print the count of items for the current date string
        let itemCount = groupedData[dateString]?.count ?? 0
        print("Number of items in section \(section): \(itemCount)")
        
        return section == 0 ? itemCount + 1 : itemCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 && indexPath.item == 0 {
            // Return the ForecastDetailNowView for the first item in the first section
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "nowCell", for: indexPath) as! ForecastDetailNowView
            cell.configure(with: weatherNow)
            return cell
        } else {
            // Adjust index for the first section to account for the ForecastDetailNowView
            let adjustedItemIndex = indexPath.section == 0 ? indexPath.item - 1 : indexPath.item
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ForecastDetailView
            
            let dates = Array(groupedData.keys.sorted())
            let dateString = dates[indexPath.section]
            
            if let forecasts = groupedData[dateString] {
                let forecast = forecasts[adjustedItemIndex]
                cell.configure(with: forecast)
            }
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        // Check if the kind is for a header view
        if kind == UICollectionView.elementKindSectionHeader {
            // Dequeue a reusable header view using the identifier
            let headerView: ForecastHeaderInfoView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as! ForecastHeaderInfoView
            
            // Set the dayIndex based on the section
            headerView.dayIndex = indexPath.section
            
            return headerView
        } else {
            fatalError("Unexpected kind for supplementary view")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 56) // Set header height
    }
}

#if DEBUG
#Preview {
    ForecastViewControllerWrapper(
        weather: .previewMock,
        weatherNow: .previewMock
    )
}
#endif

