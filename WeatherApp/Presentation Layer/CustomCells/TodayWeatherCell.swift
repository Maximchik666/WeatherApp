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
    
    lazy var hourlyForecastData = sortHourData()
    
    private var currentHour: Int {
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        return hour
    }
    
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
        
        self.addSubview(collectionView)
        setConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func sortHourData() -> [HourlyForecastDataModel] {
        
        var unsorted1 : [HourlyForecastDataModel] = []
        var unsorted2 : [HourlyForecastDataModel] = []
        
        for i in delegate.weatherData[0].hourlyForecast!.allObjects {
            unsorted1.append(i as! HourlyForecastDataModel)
        }
        
        var sorted1 = unsorted1.sorted{$0.id < $1.id }
        sorted1.removeAll{$0.id < currentHour}
        
        for i in delegate.weatherData[1].hourlyForecast!.allObjects {
            unsorted2.append(i as! HourlyForecastDataModel)
        }
        
        var sorted2 = unsorted2.sorted{$0.id < $1.id }
        sorted2.removeAll{$0.id >= (currentHour-12)}
        
        return sorted1 + sorted2
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
        hourlyForecastData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WheatherCell", for: indexPath) as! WeatherCollectionViewCell
        cell.timeLabel.text = hourlyForecastData[indexPath.row].hour
        cell.temperatureLabel.text = "\(hourlyForecastData[indexPath.row].temp)"
        return cell
    }
}
