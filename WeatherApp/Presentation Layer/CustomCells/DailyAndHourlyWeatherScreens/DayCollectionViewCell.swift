//
//  DayCollectionViewCell.swift
//  WeatherApp
//
//  Created by Maksim Kruglov on 20.03.2023.
//

import Foundation
import UIKit
import TinyConstraints


final class DayCollectionViewCell: UICollectionViewCell {
    
    
    override var isSelected: Bool {
        didSet {
            pickRectangle.backgroundColor = isSelected ? BundleColours.deepBlue.color : BundleColours.backGround.color
            dayLabel.textColor = isSelected ? .white : .black
        }
    }
    
    lazy var dayLabel = CustomTextLabel(text: "", textColor: .black, font: RubikFonts.regular.rawValue, fontSize: 14)
    
    lazy var pickRectangle : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "BackGround")
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        setupView()
        
    }
    
    private func setupView() {
        
        contentView.addSubview(pickRectangle)
        contentView.addSubview(dayLabel)
        
        pickRectangle.leftToSuperview()
        pickRectangle.topToSuperview()
        pickRectangle.height(40)
        pickRectangle.width(80)
        
        dayLabel.centerX(to: pickRectangle)
        dayLabel.centerY(to: pickRectangle)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
