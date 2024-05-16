//
//  test.swift
//  WeatherAppSwiftUIKit
//
//  Created by Filip Štěpánek on 13.05.2024.
//

// Add UIViewCollectionController as subbview to UIViewcontroller

//import SwiftUI
//import UIKit
//
//struct ForecastViewControllerWrapper: UIViewControllerRepresentable {
//    typealias UIViewControllerType = ForecastViewController
//
//    func makeUIViewController(context: Context) -> ForecastViewController {
//        return ForecastViewController()
//    }
//
//    func updateUIViewController(_ uiViewController: ForecastViewController, context: Context) {
//        // Update any properties if needed
//    }
//}
//
//
//#if DEBUG
//struct ForecastViewControllerWrapper_Previews: PreviewProvider {
//    static var previews: some View {
//        ForecastViewControllerWrapper()
//    }
//}
//#endif
//
//
//class ForecastViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
//
//    fileprivate lazy var customNavigationBar: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = "Forecast"
//        label.textAlignment = .left
//        label.backgroundColor = .purple
//        label.textColor = .mainText
//        label.font = UIFont.headlineTwo
//        return label
//    }()
//
//    fileprivate lazy var collectionView: UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .vertical
//        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        cv.translatesAutoresizingMaskIntoConstraints = false
//        cv.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
//        cv.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
//        cv.backgroundColor = .blue // Set background color of collection view
//        cv.delegate = self
//        cv.dataSource = self
//        return cv
//    }()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        view.addSubview(customNavigationBar) // Adding the custom navigation bar as a subview
//        view.addSubview(collectionView) // Adding the collection view as a subview
//
//        NSLayoutConstraint.activate([
//            customNavigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
//            customNavigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//            customNavigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            customNavigationBar.heightAnchor.constraint(equalToConstant: 44), // Adjust the height as needed
//
//            collectionView.topAnchor.constraint(equalTo: customNavigationBar.bottomAnchor),
//            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
//        ])
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: collectionView.frame.width / 1, height: collectionView.frame.width / 4)
//    }
//
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 5 // Assuming you have only one section
//    }
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 8
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
//        cell.backgroundColor = .red
//        return cell
//    }
//
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        if kind == UICollectionView.elementKindSectionHeader {
//            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as! ForecastHeaderInfoView
//            headerView.dayIndex = indexPath.section // Set dayIndex
//            return headerView as UICollectionReusableView // Cast to UICollectionReusableView
//        }
//        return UICollectionReusableView()
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        return CGSize(width: collectionView.frame.width, height: 70) // Set header height
//    }
//}

// MARK: - test1

import SwiftUI
import UIKit

struct ForecastViewControllerWrapper: UIViewControllerRepresentable {
    typealias UIViewControllerType = ForecastViewController
    
    func makeUIViewController(context: Context) -> ForecastViewController {
        return ForecastViewController()
    }
    
    func updateUIViewController(_ uiViewController: ForecastViewController, context: Context) {
        // Update any properties if needed
    }
}

class ForecastViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    fileprivate lazy var customNavigationBar: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Forecast"
        label.textAlignment = .left
        label.backgroundColor = .purple
        label.textColor = .white
        label.font = UIFont.headlineTwo
        return label
    }()
    
    //    fileprivate lazy var collectionView: UICollectionView = {
    //        let layout = UICollectionViewFlowLayout()
    //        layout.scrollDirection = .vertical
    //        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
    //        cv.translatesAutoresizingMaskIntoConstraints = false
    //        cv.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    //        cv.register(CustomHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
    //        cv.backgroundColor = .blue // Set background color of collection view
    //        cv.delegate = self
    //        cv.dataSource = self
    //        return cv
    //    }()
    
    fileprivate lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        // Register ForecastHeaderInfoView for section header
        cv.register(ForecastHeaderInfoView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
        
        cv.backgroundColor = .blue // Set background color of collection view
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    fileprivate lazy var collectionViewFlowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        // Set other layout properties as needed
        return layout
    }()
    
    
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
            customNavigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            customNavigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            customNavigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            customNavigationBar.heightAnchor.constraint(equalToConstant: 44), // Adjust the height as needed
            
            collectionView.topAnchor.constraint(equalTo: customNavigationBar.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width - 20 // Adjust spacing as needed
        return CGSize(width: width, height: 50) // Adjust height as needed
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 5 // Assuming you have only one section
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .red
        return cell
    }
    
    //    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    //        // Check if the kind is for a header view
    //        if kind == UICollectionView.elementKindSectionHeader {
    //            // Dequeue a reusable header view using the identifier
    //            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as! CustomHeaderView
    //            
    //            // Configure your custom header view
    //            headerView.titleLabel.text = "Section \(indexPath.section)"
    //            // You can customize the header view further here
    //            
    //            return headerView
    //        } else {
    //            fatalError("Unexpected kind for supplementary view")
    //        }
    //    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        // Check if the kind is for a header view
        if kind == UICollectionView.elementKindSectionHeader {
            // Dequeue a reusable header view using the identifier
            let headerView: ForecastHeaderInfoView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as! ForecastHeaderInfoView
            
            // Set the dayIndex based on the section
            headerView.dayIndex = indexPath.section
            
            // No need to configure the headerView.titleLabel here
            // It's already configured inside ForecastHeaderInfoView
            
            return headerView
        } else {
            fatalError("Unexpected kind for supplementary view")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 50) // Set header height
    }
}

class CustomHeaderView: UICollectionReusableView {
    // Add any subviews you want in your custom header view
    var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.dayInfoBase
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .green // Customize the background color of the header
        
        addSubview(titleLabel)
        
        // Add constraints for titleLabel
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

#if DEBUG
import SwiftUI

struct ForecastViewControllerWrapper_Previews: PreviewProvider {
    static var previews: some View {
        ForecastViewControllerWrapper()
            .edgesIgnoringSafeArea(.all)
    }
}
#endif

// MARK: - test2

//import UIKit
//
//class ForecastViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
//    
//    fileprivate lazy var customNavigationBar: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = "Forecast"
//        label.textAlignment = .left
//        label.backgroundColor = .purple
//        label.textColor = .white
//        label.font = UIFont.headlineTwo
//        return label
//    }()
//    
//    fileprivate lazy var collectionView: UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .vertical
//        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        cv.translatesAutoresizingMaskIntoConstraints = false
//        cv.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
//        cv.backgroundColor = .blue // Set background color of collection view
//        cv.delegate = self
//        cv.dataSource = self
//        return cv
//    }()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        view.addSubview(customNavigationBar) // Adding the custom navigation bar as a subview
//        view.addSubview(collectionView) // Adding the collection view as a subview
//        
//        NSLayoutConstraint.activate([
//            customNavigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
//            customNavigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//            customNavigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            customNavigationBar.heightAnchor.constraint(equalToConstant: 44), // Adjust the height as needed
//            
//            collectionView.topAnchor.constraint(equalTo: customNavigationBar.bottomAnchor),
//            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
//        ])
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let width = collectionView.frame.width - 20 // Adjust spacing as needed
//        return CGSize(width: width, height: 50) // Adjust height as needed
//    }
//    
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 5 // Assuming you have only one section
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 8
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
//        cell.backgroundColor = .red
//        return cell
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        // Check if the kind is for a header view
//        if kind == UICollectionView.elementKindSectionHeader {
//            // Dequeue a reusable header view using the identifier
//            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as! ForecastHeaderInfoView
//            
//            // Configure your custom header view
//            headerView.dayIndex = indexPath.section
//            // You can customize the header view further here
//            
//            return headerView
//        } else {
//            fatalError("Unexpected kind for supplementary view")
//        }
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        return CGSize(width: collectionView.frame.width, height: 50) // Set header height
//    }
//}
//
//import SwiftUI
//
//struct ForecastViewControllerWrapper: UIViewControllerRepresentable {
//    typealias UIViewControllerType = ForecastViewController
//    
//    func makeUIViewController(context: Context) -> ForecastViewController {
//        return ForecastViewController()
//    }
//    
//    func updateUIViewController(_ uiViewController: ForecastViewController, context: Context) {
//        // Update any properties if needed
//    }
//}
//
//#if DEBUG
//import SwiftUI
//
//struct ForecastViewControllerWrapper_Previews: PreviewProvider {
//    static var previews: some View {
//        ForecastViewControllerWrapper()
//            .edgesIgnoringSafeArea(.all)
//    }
//}
//#endif
//
//
