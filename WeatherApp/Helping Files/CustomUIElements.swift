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

class CustomImageView: UIImageView {
    
    init(imageName: String, width: CGFloat, height: CGFloat) {
        super .init(image: UIImage(named: imageName))
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.width(width)
        self.height(height)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class CustomSwitch: UISwitch {
    
    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        isOn = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class BlueLine: UIView {
    
    init(){
        super .init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        self.layer.backgroundColor = UIColor(named: "DeepBlue")?.cgColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class CustomSwitcherButton : UIButton {
    @objc func didTap(){
        self.isSelected.toggle()
    }
    
    init(imageOn: UIImage, imageOff: UIImage){
        super.init(frame: CGRect(x: 0, y: 0, width: 80, height: 30))
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setImage(imageOff, for: .selected)
        self.setImage(imageOn, for: .normal)
        addTarget(self, action: #selector(didTap), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

