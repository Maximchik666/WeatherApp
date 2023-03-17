//
//  WeatherCell.swift
//  WeatherApp
//
//  Created by Maksim Kruglov on 22.02.2023.
//

import Foundation
import UIKit
import TinyConstraints

class WeatherCollectionViewCell: UICollectionViewCell {
    
    private lazy var whiteRoundedRectangle: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 20
        view.layer.borderColor = UIColor.systemGray3.cgColor
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(named: "Orange")?.cgColor
        return view
    }()

    lazy var wheatherIcon: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Medium", size: 10.0)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var temperatureLabel: UILabel = {
        let label = UILabel()
    
        label.font = UIFont(name: "Rubik-Medium", size: 12.0)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(whiteRoundedRectangle)
        addSubview(wheatherIcon)
        addSubview(timeLabel)
        addSubview(temperatureLabel)
        
        setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setConstraints() {

   
        whiteRoundedRectangle.width(40)
        whiteRoundedRectangle.height(80)

        timeLabel.top(to: whiteRoundedRectangle, offset: 15)
        timeLabel.centerX(to: whiteRoundedRectangle)

        wheatherIcon.centerY(to: whiteRoundedRectangle, offset: 3)
        wheatherIcon.height(25)
        wheatherIcon.width(25)
        wheatherIcon.centerX(to: whiteRoundedRectangle)

        temperatureLabel.bottom(to: whiteRoundedRectangle, offset: -8)
        temperatureLabel.centerX(to: whiteRoundedRectangle, offset: 2)
    }
}
