//
//  DailyWeatherTableViewCell.swift
//  WeatherApp
//
//  Created by Maksim Kruglov on 20.03.2023.
//

import Foundation
import UIKit
import TinyConstraints

final class DailyWeatherTableViewCell: UITableViewCell {
    
    var image = "CurrentWeather.Sun"
    
    private lazy var blueRectangle: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "BackGround")
        view.layer.cornerRadius = 10
        return view
    }()
    

    private lazy var tempLabel = CustomTextLabel(text: "15", textColor: .black, font: RubikFonts.regular.rawValue, fontSize: 30)
    private lazy var weatherConditionLabel = CustomTextLabel(text: "Weather is Outstanding", textColor: .black, font: RubikFonts.medium.rawValue, fontSize: 15)
    private lazy var feelsLikeLabel = CustomTextLabel(text: "По Ощущениям", textColor: .black, font: RubikFonts.light.rawValue, fontSize: 15)
    private lazy var windSpeedLabel = CustomTextLabel(text: "Скорость Ветра", textColor: .black, font: RubikFonts.light.rawValue, fontSize: 15)
    private lazy var humidityLabel = CustomTextLabel(text: "Влажость", textColor: .black, font: RubikFonts.light.rawValue, fontSize: 15)
    private lazy var cloudness = CustomTextLabel(text: "Облачность", textColor: .black, font: RubikFonts.light.rawValue, fontSize: 15)
    
    private lazy var conditionImage = CustomImageView(imageName:self.image, width: 60, height: 60)
    private lazy var feelsLikeTempImage = CustomImageView(imageName: BundleImages.termometer.rawValue, width: 30, height: 30)
    private lazy var windImage = CustomImageView(imageName: BundleImages.windSpeed.rawValue, width: 30, height: 20)
    private lazy var humidityImage = CustomImageView(imageName:BundleImages.humidity.rawValue, width: 30, height: 30)
    private lazy var cloudnessImage = CustomImageView(imageName: BundleImages.clouds.rawValue, width: 30, height: 30)
    
    private lazy var firstBlueLine = BlueLine()
    private lazy var secondBlueLine = BlueLine()
    private lazy var thirdBlueLine = BlueLine()
    private lazy var fourthBlueLine = BlueLine()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        
        addViews()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addViews() {
        
        contentView.addSubview(blueRectangle)
        contentView.addSubview(tempLabel)
        contentView.addSubview(conditionImage)
        contentView.addSubview(weatherConditionLabel)
        contentView.addSubview(feelsLikeTempImage)
        contentView.addSubview(feelsLikeLabel)
        contentView.addSubview(firstBlueLine)
        contentView.addSubview(windImage)
        contentView.addSubview(windSpeedLabel)
        contentView.addSubview(secondBlueLine)
        contentView.addSubview(humidityImage)
        contentView.addSubview(humidityLabel)
        contentView.addSubview(thirdBlueLine)
        
    }
    
    private func setUpConstraints() {
        
        blueRectangle.edgesToSuperview(insets: TinyEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
        blueRectangle.height(300)
        
        conditionImage.top(to: blueRectangle)
        conditionImage.centerX(to: blueRectangle, offset: -20)
        
        tempLabel.top(to: blueRectangle, offset: 10)
        tempLabel.leftToRight(of: conditionImage, offset: -5)
        tempLabel.centerY(to: conditionImage)
        
        weatherConditionLabel.topToBottom(of: conditionImage, offset: 10)
        weatherConditionLabel.centerX(to: blueRectangle)
        
        feelsLikeTempImage.topToBottom(of: weatherConditionLabel, offset: 30)
        feelsLikeTempImage.left(to: blueRectangle, offset: 10)
        
        feelsLikeLabel.leftToRight(of: feelsLikeTempImage, offset: 10)
        feelsLikeLabel.centerY(to: feelsLikeTempImage)
        
        firstBlueLine.left(to: blueRectangle)
        firstBlueLine.right(to: blueRectangle)
        firstBlueLine.height(1)
        firstBlueLine.topToBottom(of: feelsLikeTempImage, offset: 10)
        
        windImage.topToBottom(of: firstBlueLine, offset: 10)
        windImage.left(to: blueRectangle, offset: 10)
        
        windSpeedLabel.leftToRight(of: windImage, offset: 10)
        windSpeedLabel.centerY(to: windImage)
        
        secondBlueLine.left(to: blueRectangle)
        secondBlueLine.right(to: blueRectangle)
        secondBlueLine.height(1)
        secondBlueLine.topToBottom(of: windImage, offset: 10)
      
    }
    
    
}
