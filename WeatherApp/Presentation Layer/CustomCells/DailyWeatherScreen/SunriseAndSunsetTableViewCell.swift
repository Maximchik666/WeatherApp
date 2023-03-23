//
//  DawnAndSunsetTableViewCell.swift
//  WeatherApp
//
//  Created by Maksim Kruglov on 23.03.2023.
//

import Foundation
import UIKit
import TinyConstraints

final class SunriseAndSunsetTableViewCell: UITableViewCell {
    
    private lazy var sunriseIcon = CustomImageView(imageName: BundleImages.sun.rawValue, width: 25, height: 25)
    private lazy var sunsetIcon = CustomImageView(imageName: BundleImages.sunset.rawValue, width: 25, height: 25)
    
    private lazy var sunriseLabel = CustomTextLabel(text: "Рассвет", textColor:.black, font: RubikFonts.regular.rawValue, fontSize: 15)
    private lazy var sunsetLabel = CustomTextLabel(text: "Закат", textColor: .black, font: RubikFonts.regular.rawValue, fontSize: 15)
    
    lazy var sunriseTimeLabel = CustomTextLabel(text: "15.00", textColor:.black, font: RubikFonts.regular.rawValue, fontSize: 15)
    lazy var sunsetTimeLabel = CustomTextLabel(text: "15.00", textColor: .black, font: RubikFonts.regular.rawValue, fontSize: 15)
    
    private lazy var firstBlueLine = BlueLine()
    private lazy var secondBlueLine = BlueLine()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        contentView.addSubview(sunriseIcon)
        contentView.addSubview(sunsetIcon)
        contentView.addSubview(sunriseLabel)
        contentView.addSubview(sunsetLabel)
        contentView.addSubview(sunsetTimeLabel)
        contentView.addSubview(sunriseTimeLabel)
        contentView.addSubview(firstBlueLine)
        contentView.addSubview(secondBlueLine)
    }
    
    private func setUpConstraints(){
        
    }
}
