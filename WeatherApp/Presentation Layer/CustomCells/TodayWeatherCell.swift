//
//  TodayWeatherHeader.swift
//  WeatherApp
//
//  Created by Maksim Kruglov on 22.02.2023.
//

import Foundation
import UIKit
import TinyConstraints

class TodayWeatherCell: UITableViewCell {
    
    weak var delegate: MainScreenViewController!
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.layout)
        collectionView.register(WeatherCollectionViewCell.self, forCellWithReuseIdentifier: "WheatherCell")
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "DefaultCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(collectionView)
        setConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    private func setConstraints() {
                
        collectionView.edgesToSuperview()
        collectionView.height(100)
    }
    
    @objc private func didTapButton () {
        delegate.didTap24HourForecastButton()
    }
}

extension TodayWeatherCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        12
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WheatherCell", for: indexPath)
        
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//        let insets = (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.sectionInset ?? .zero
//        let interItemSpacing = (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.minimumInteritemSpacing ?? 0
//
//        let width = collectionView.frame.width - (4 - 1) * interItemSpacing - insets.left - insets.right
//        let itemWidth = floor(width / 4)
//
//        print("🍏 \(itemWidth)")
//
//        return CGSize(width: itemWidth, height: itemWidth)
//        
//        
//    }
//    
}
