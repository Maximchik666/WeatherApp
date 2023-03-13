//
//  7DaysForecast.swift
//  WeatherApp
//
//  Created by Maksim Kruglov on 13.03.2023.
//

import Foundation
import UIKit
import TinyConstraints

class SevenDaysForecast: UITableViewCell {
    
    weak var delegate: MainScreenViewController!
    
    private lazy var title: UILabel = {
        let label = UILabel()
        label.text = "Ежедневный прогноз"
        label.font = UIFont(name: "Rubik-Medium", size: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
        let underlineAttributedString = NSAttributedString(string: "Подробнее на 7 дней", attributes: underlineAttribute)
        button.setAttributedTitle(underlineAttributedString, for: .normal)
        button.addTarget(self, action: #selector(self.didTapButton), for: .touchUpInside)
        button.titleLabel?.font = UIFont(name: "Rubik-Regular", size: 17.0)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(title)
        contentView.addSubview(button)
        addConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    private func addConstraints() {
        
        title.leading(to: contentView, offset: 10)
        title.centerY(to: contentView)
        
        button.trailing(to: contentView, offset: -10)
        button.centerY(to: contentView)
    }
    
    @objc private func didTapButton () {
        delegate.didTap24HourForecastButton()
    }
    
}
