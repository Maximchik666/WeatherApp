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
        view.layer.borderWidth = 0.5
        return view
    }()

    private lazy var wheatherIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "RainPossibilityIcon")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    lazy var timeLabel: UILabel = {
        let label = UILabel()
       // label.text = "12:00"
        label.font = UIFont(name: "Rubik-Medium", size: 10.0)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var temperatureLabel: UILabel = {
        let label = UILabel()
       // label.text = "23°"
        label.font = UIFont(name: "Rubik-Medium", size: 10.0)
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

        whiteRoundedRectangle.top(to: contentView)
        whiteRoundedRectangle.width(40)
        whiteRoundedRectangle.height(80)

        timeLabel.top(to: whiteRoundedRectangle, offset: 20)
        timeLabel.centerX(to: whiteRoundedRectangle)

        wheatherIcon.centerY(to: whiteRoundedRectangle)
        wheatherIcon.height(16)
        wheatherIcon.width(20)
        wheatherIcon.centerX(to: whiteRoundedRectangle)

        temperatureLabel.topToBottom(of: wheatherIcon, offset: 5)
        temperatureLabel.centerX(to: whiteRoundedRectangle)
    }
}
