//
//  CustomTextLabel.swift
//  WeatherApp
//
//  Created by Maksim Kruglov on 28.11.2022.
//

import Foundation
import UIKit

class CustomTextLabel: UILabel {
    
    init(text: String, textColor: UIColor, font: String, fontSize: CGFloat ) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        self.contentMode = .scaleAspectFill
        self.text = text
        self.textAlignment = .center
        self.textColor = textColor
        self.font = UIFont(name: font, size: fontSize)
        self.numberOfLines = 0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class CustomSwitch: UISwitch {
    
    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


