//
//  InitialSetupViewController.swift
//  WeatherApp
//
//  Created by Maksim Kruglov on 28.11.2022.
//

import Foundation
import UIKit
import TinyConstraints

final class SetupViewController: UIViewController {
    
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
    private lazy var timeFormatLabel = CustomTextLabel(text: "Cкорость ветра", textColor: .systemGray, font: "Rubik-Regular", fontSize: 18)
    private lazy var notificationLabel = CustomTextLabel(text: "Уведомления", textColor: .systemGray, font: "Rubik-Regular", fontSize: 18)
    
    private lazy var temperatureSwitch = CVSwithcer()
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
        view.addSubview(timeFormatLabel)
        view.addSubview(notificationLabel)
        view.addSubview(setUpButton)
        view.addSubview(temperatureSwitch)
        view.addSubview(timeFormatSwitch)
        view.addSubview(notificationSwitch)
        addingConatraints()
        
    }
    
    func addingConatraints () {
        
        //Clouds
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
        
        // Settings
        whiteSquare.centerX(to: view)
        whiteSquare.centerY(to: view)
        whiteSquare.height(350)
        whiteSquare.left(to: view, offset: 20)
        whiteSquare.right(to: view, offset: -20)
   
        settingsLabel.top(to: whiteSquare, offset: 27)
        settingsLabel.leading(to: whiteSquare, offset: 20)
        settingsLabel.height(30)
        
        temperatureLabel.topToBottom(of: settingsLabel, offset: 40)
        temperatureLabel.leading(to:whiteSquare, offset: 20)
        temperatureLabel.height(30)
        
        temperatureSwitch.centerY(to: temperatureLabel)
        temperatureSwitch.right(to:whiteSquare, offset: -20)
        temperatureSwitch.height(30)
        temperatureSwitch.width(60)

        timeFormatLabel.topToBottom(of: temperatureLabel, offset: 20)
        timeFormatLabel.leading(to:whiteSquare, offset: 20)
        timeFormatLabel.height(30)
        
        timeFormatSwitch.centerY(to: timeFormatLabel)
        timeFormatSwitch.right(to:whiteSquare, offset: -20)
        timeFormatSwitch.height(30)

        notificationLabel.topToBottom(of: timeFormatLabel, offset: 20)
        notificationLabel.leading(to:whiteSquare, offset: 20)
        notificationLabel.height(30)
        
        notificationSwitch.centerY(to: notificationLabel)
        notificationSwitch.right(to:whiteSquare, offset: -20)
        notificationSwitch.height(30)
        
        setUpButton.topToBottom(of: notificationSwitch, offset: 40)
        setUpButton.leading(to: whiteSquare, offset: 30)
        setUpButton.trailing(to: whiteSquare, offset: -30)
        setUpButton.height(40)
    }
}
