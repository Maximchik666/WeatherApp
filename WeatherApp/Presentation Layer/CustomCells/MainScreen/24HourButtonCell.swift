//
//  24HourButtonCell.swift
//  WeatherApp
//
//  Created by Maksim Kruglov on 13.03.2023.
//

import Foundation
import UIKit
import TinyConstraints

final class TwentyFourHourButtonCell: UITableViewCell {
    
    weak var delegate: MainScreenViewController!
    
    private lazy var button: UIButton = {
        let button = UIButton()
        let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
        let underlineAttributedString = NSAttributedString(string: "Подробнее на 24 часа", attributes: underlineAttribute)
        button.setAttributedTitle(underlineAttributedString, for: .normal)
        button.addTarget(self, action: #selector(self.didTapButton), for: .touchUpInside)
        button.titleLabel?.font = UIFont(name: "Rubik-Regular", size: 17.0)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(button)
        addConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    private func addConstraints() {
        button.trailing(to: contentView, offset: -10)
        button.centerY(to: contentView)
    }
    
    @objc private func didTapButton () {
        delegate.didTap24HoursButton()
    }
    
    
    
}
