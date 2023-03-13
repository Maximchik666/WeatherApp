//
//  InitialSetupViewController.swift
//  WeatherApp
//
//  Created by Maksim Kruglov on 28.11.2022.
//

import Foundation
import UIKit
import TinyConstraints

class InitialSetupViewController: UIViewController {
    
    private lazy var upperCloud: UIImageView = {
        
        let image = UIImageView()
        image.image = UIImage(named: "UpperCloud")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var middleCloud: UIImageView = {
        
        let image = UIImageView()
        image.image = UIImage(named: "MiddleCloud")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var bottomCloud: UIImageView = {
        
        let image = UIImageView()
        image.image = UIImage(named: "BottomCloud")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var whiteSquare: UIView = {
       
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "BackGround")
        view.layer.cornerRadius = 10
        return view
    }()
    
    private lazy var settingsLabel = CustomTextLabel(text: "Настройки", textColor: .black, font: "Rubik-Regular", fontSize: 20)
    private lazy var temperatureLabel = CustomTextLabel(text: "Температура", textColor: .systemGray, font: "Rubik-Regular", fontSize: 18)
    private lazy var windSpeedLabel = CustomTextLabel(text: "Скорость Ветра", textColor: .systemGray, font: "Rubik-Regular", fontSize: 18)
    private lazy var timeFormatLabel = CustomTextLabel(text: "Cкорость ветра", textColor: .systemGray, font: "Rubik-Regular", fontSize: 18)
    private lazy var notificationLabel = CustomTextLabel(text: "Уведомления", textColor: .systemGray, font: "Rubik-Regular", fontSize: 18)
    
    private lazy var temperatureSwitch = CustomSwitch()
    private lazy var windSpeedSwitch = CustomSwitch()
    private lazy var timeFormatSwitch = CustomSwitch()
    private lazy var notificationSwitch = CustomSwitch()
    
    private lazy var setUpButton: UIButton = {
        
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(named: "Orange")!
        button.tintColor = .white
        button.layer.cornerRadius = 10
        button.setTitle("Установить", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .regular)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "DeepBlue")
        view.addSubview(upperCloud)
        view.addSubview(middleCloud)
        view.addSubview(bottomCloud)
        view.addSubview(whiteSquare)
        view.addSubview(settingsLabel)
        view.addSubview(temperatureLabel)
        view.addSubview(windSpeedLabel)
        view.addSubview(timeFormatLabel)
        view.addSubview(notificationLabel)
        view.addSubview(setUpButton)
        view.addSubview(temperatureSwitch)
        view.addSubview(windSpeedSwitch)
        view.addSubview(timeFormatSwitch)
        view.addSubview(notificationSwitch)
        addingConatraints()
    }
    
    func addingConatraints () {
        
        upperCloud.top(to: view, offset: 50)
        upperCloud.leading(to: view)
        upperCloud.width(300)
        upperCloud.height(75)
        
        middleCloud.topToBottom(of: upperCloud, offset: 10)
        middleCloud.trailing(to: view)
        middleCloud.width(200)
        middleCloud.height(100)
        
        bottomCloud.bottom(to: view, offset: -80)
        bottomCloud.centerX(to: view)
        bottomCloud.height(100)
        bottomCloud.width(300)
        
        whiteSquare.topToBottom(of: middleCloud, offset: 10)
        whiteSquare.leading(to: view, offset: 30)
        whiteSquare.trailing(to: view, offset: -30)
        whiteSquare.bottomToTop(of: bottomCloud, offset: -80)
        
        settingsLabel.top(to: whiteSquare, offset: 27)
        settingsLabel.leading(to: whiteSquare, offset: 20)
        settingsLabel.height(30)
        
        temperatureLabel.top(to: settingsLabel, offset: 60)
        temperatureLabel.leading(to:whiteSquare, offset: 20)
        temperatureLabel.height(30)

        windSpeedLabel.top(to: temperatureLabel, offset: 60)
        windSpeedLabel.leading(to:whiteSquare, offset: 20)
        windSpeedLabel.height(30)

        timeFormatLabel.top(to: windSpeedLabel, offset: 60)
        timeFormatLabel.leading(to:whiteSquare, offset: 20)
        timeFormatLabel.height(30)

        notificationLabel.top(to: timeFormatLabel, offset: 60)
        notificationLabel.leading(to:whiteSquare, offset: 20)
        notificationLabel.height(30)
        
        setUpButton.bottom(to: whiteSquare, offset: -27)
        setUpButton.leading(to: whiteSquare, offset: 30)
        setUpButton.trailing(to: whiteSquare, offset: -30)
        setUpButton.height(40)
        
        temperatureSwitch.top(to: settingsLabel, offset: 60)
        temperatureSwitch.trailing(to:whiteSquare, offset: -20)
        temperatureSwitch.height(30)

        windSpeedSwitch.top(to: temperatureLabel, offset: 60)
        windSpeedSwitch.trailing(to:whiteSquare, offset: -20)
        windSpeedSwitch.height(30)

        timeFormatSwitch.top(to: windSpeedLabel, offset: 60)
        timeFormatSwitch.trailing(to:whiteSquare, offset: -20)
        timeFormatSwitch.height(30)

        notificationSwitch.top(to: timeFormatLabel, offset: 60)
        notificationSwitch.trailing(to:whiteSquare, offset: -20)
        notificationSwitch.height(30)
    }
    
}
