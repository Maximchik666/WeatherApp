//
//  DailyForecastMainScreenTableCell.swift
//  WeatherApp
//
//  Created by Maksim Kruglov on 27.02.2023.
//

import Foundation
import UIKit
import TinyConstraints

class DailyForecastMainScreenTableViewCell: UITableViewCell {
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray3
        label.text = "17/04"
        label.font = UIFont(name: "Rubik-Medium", size: 10.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var rainPossibilityIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "RainPossibilityIcon")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var rainPossibilitylabel: UILabel = {
        let label = UILabel()
        label.text = "57%"
        label.font = UIFont(name: "Rubik-Regular", size: 15.0)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var currentWeatherConditionLabel: UILabel = {
        let label = UILabel()
        label.text = "Weather Is fine"
        label.font = UIFont(name: "Rubik-Regular", size: 17.0)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.text = "17/21"
        label.font = UIFont(name: "Rubik-Regular", size: 17.0)
        label.textColor = .systemGray3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var seeMoreDetailLabel: UILabel = {
        let label = UILabel()
        label.text = ">"
        label.font = UIFont(name: "Rubik-Regular", size: 27.0)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    
        addingSubviews()
        addingConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    private func addingSubviews(){
        addSubview(dateLabel)
        addSubview(rainPossibilitylabel)
        addSubview(rainPossibilityIcon)
        addSubview(currentWeatherConditionLabel)
        addSubview(temperatureLabel)
        addSubview(seeMoreDetailLabel)
    }
    
    private func addingConstraints() {
        
        contentView.height(80)
         
        dateLabel.leading(to: contentView, offset: 30)
        dateLabel.top(to: contentView, offset: 20)
        
        rainPossibilityIcon.topToBottom(of: dateLabel, offset: 20)
        rainPossibilityIcon.leading(to: contentView, offset: 30)
        rainPossibilityIcon.height(20)
        rainPossibilityIcon.width(30)
        
        rainPossibilitylabel.leadingToTrailing(of: rainPossibilityIcon, offset: 10)
        rainPossibilitylabel.topToBottom(of: dateLabel, offset: 10)

        currentWeatherConditionLabel.centerY(to: contentView)
        currentWeatherConditionLabel.leadingToTrailing(of: rainPossibilitylabel, offset: 20)

        temperatureLabel.centerY(to: contentView)
        temperatureLabel.leadingToTrailing(of:  currentWeatherConditionLabel, offset: 40)
        
        seeMoreDetailLabel.centerY(to: contentView)
        seeMoreDetailLabel.leadingToTrailing(of: temperatureLabel, offset: 30)
    }
}
