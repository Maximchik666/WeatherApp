//
//  TodayWeatherHeader.swift
//  WeatherApp
//
//  Created by Maksim Kruglov on 22.02.2023.
//

import Foundation
import UIKit
import TinyConstraints

final class TodayWeatherCell: UITableViewCell {
    
    weak var delegate: MainScreenViewController!
    lazy var hourlyForecastData = getTimeSortedHourForecasts(from: delegate.weatherData, forHowMuchHours: 12)
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal // Добавляем горизонтальное направление прокрутки
        layout.itemSize = CGSize(width: 40, height: 80) // Размер ячейки UICollectionView
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
        collectionView.showsHorizontalScrollIndicator = false // Скрыть индикатор прокрутки
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(collectionView)
        setConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setConstraints() {
        
        collectionView.edgesToSuperview()
    }
}

extension TodayWeatherCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        hourlyForecastData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WheatherCell", for: indexPath) as! WeatherCollectionViewCell
        cell.timeLabel.text = "\(hourlyForecastData[indexPath.row].hour ?? "error"):00"
        cell.temperatureLabel.text = "\(hourlyForecastData[indexPath.row].temp)°"
        cell.wheatherIcon.image = UIImage(named: hourlyForecastData[indexPath.row].image ?? "WindSpeedIcon")

        return cell
    }
}
