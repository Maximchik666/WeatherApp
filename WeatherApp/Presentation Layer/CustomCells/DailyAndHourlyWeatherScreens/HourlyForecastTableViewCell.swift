//
//  HourlyForecastTableViewCell.swift
//  WeatherApp
//
//  Created by Maksim Kruglov on 27.03.2023.
//

import Foundation
import UIKit
import TinyConstraints

final class HourlyForecastTableViewCell: UITableViewCell {
    
    lazy var dateLabel = CustomTextLabel(text: "", textColor: .black, font: RubikFonts.medium.rawValue, fontSize: 18)
    lazy var hourLabel = CustomTextLabel(text: "", textColor: .gray, font: RubikFonts.regular.rawValue, fontSize: 16)
    lazy var tempLabel = CustomTextLabel(text: "", textColor: .black, font: RubikFonts.medium.rawValue, fontSize: 18)
    lazy var conditionImage = CustomImageView(imageName: BundleImages.sun.rawValue, width: 20, height: 20)
    lazy var conditionLabel = CustomTextLabel(text: "", textColor: .black, font: RubikFonts.regular.rawValue, fontSize: 16)
    lazy var windDataLabel = CustomTextLabel(text: "", textColor: .gray, font: RubikFonts.regular.rawValue, fontSize: 16)
    lazy var humidityDataLabel = CustomTextLabel(text: "", textColor: .gray, font: RubikFonts.regular.rawValue, fontSize: 16)
    lazy var cloudnessDataLabel = CustomTextLabel(text: "", textColor: .gray, font: RubikFonts.regular.rawValue, fontSize: 16)
    
    private lazy var windSpeedImage = CustomImageView(imageName: BundleImages.windSpeedBlue.rawValue, width: 20, height: 13)
    private lazy var humidityImage = CustomImageView(imageName: BundleImages.humidityBlue.rawValue, width: 20 , height: 20)
    private lazy var cloudnessImage  = CustomImageView(imageName: BundleImages.clouds.rawValue, width: 20, height: 20)
    private lazy var windLabel = CustomTextLabel(text: "Ветер", textColor: .black, font: RubikFonts.regular.rawValue, fontSize: 16)
    private lazy var humidityLabel = CustomTextLabel(text: "Влажность", textColor: .black, font: RubikFonts.regular.rawValue, fontSize: 16)
    private lazy var cloudnessLabel = CustomTextLabel(text: "Облачность", textColor: .black, font: RubikFonts.regular.rawValue, fontSize: 16)
    private lazy var blueLine = BlueLine()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        
        addViews()
        setUpConstraints()
        contentView.backgroundColor = BundleColours.backGround.color
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addViews() {
        contentView.addSubview(dateLabel)
        contentView.addSubview(hourLabel)
        contentView.addSubview(tempLabel)
        contentView.addSubview(conditionImage)
        contentView.addSubview(conditionLabel)
        contentView.addSubview(windDataLabel)
        contentView.addSubview(humidityDataLabel)
        contentView.addSubview(cloudnessDataLabel)
        contentView.addSubview(windSpeedImage)
        contentView.addSubview(humidityImage)
        contentView.addSubview(cloudnessImage)
        contentView.addSubview(windLabel)
        contentView.addSubview(humidityLabel)
        contentView.addSubview(cloudnessLabel)
        contentView.addSubview(blueLine)
    }
    
    private func setUpConstraints() {
        
        dateLabel.top(to: contentView, offset: 10)
        dateLabel.leading(to: contentView, offset: 10)
        
        hourLabel.topToBottom(of: dateLabel, offset: 20)
        hourLabel.centerX(to: dateLabel)
        
        tempLabel.topToBottom(of: hourLabel, offset: 10)
        tempLabel.centerX(to: hourLabel)
        
        conditionImage.centerY(to: hourLabel)
        conditionImage.leftToRight(of: hourLabel, offset: 20)
        
        conditionLabel.leftToRight(of: conditionImage, offset: 10)
        conditionLabel.centerY(to: conditionImage)
        
        windSpeedImage.topToBottom(of: conditionImage,offset: 10)
        windSpeedImage.centerX(to: conditionImage)
        
        windLabel.leftToRight(of: windSpeedImage, offset: 10)
        windLabel.centerY(to: windSpeedImage)
        
        windDataLabel.centerY(to: windLabel)
        windDataLabel.trailing(to: contentView, offset: -10)
        
        humidityImage.topToBottom(of: windSpeedImage,offset: 10)
        humidityImage.centerX(to: windSpeedImage)
        
        humidityLabel.leftToRight(of: humidityImage, offset: 10)
        humidityLabel.centerY(to: humidityImage)
        
        humidityDataLabel.centerY(to: humidityLabel)
        humidityDataLabel.trailing(to: contentView, offset: -10)
        
        cloudnessImage.topToBottom(of: humidityImage,offset: 10)
        cloudnessImage.centerX(to: humidityImage)
        
        cloudnessLabel.leftToRight(of: cloudnessImage, offset: 10)
        cloudnessLabel.centerY(to: cloudnessImage)
        
        cloudnessDataLabel.centerY(to: cloudnessLabel)
        cloudnessDataLabel.trailing(to: contentView, offset: -10)
        
        blueLine.left(to: contentView, offset: 10)
        blueLine.right(to: contentView, offset: 10)
        blueLine.height(1)
        blueLine.topToBottom(of: cloudnessImage, offset: 10)
    }
    
    
    
    
}
