//
//  GeolocationNameTableViewCell.swift
//  WeatherApp
//
//  Created by Maksim Kruglov on 17.03.2023.
//

import Foundation
import UIKit
import TinyConstraints

class GeolocationNameTableViewCell: UITableViewCell {
    
    lazy var geolocationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Medium", size: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(geolocationLabel)
        geolocationLabel.centerY(to: contentView)
        geolocationLabel.leading(to: contentView, offset: 10)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
