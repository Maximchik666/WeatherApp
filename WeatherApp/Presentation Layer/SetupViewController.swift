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
    
    weak var delegate: MainScreenViewController!
    
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
    private lazy var notificationLabel = CustomTextLabel(text: "Уведомления", textColor: .systemGray, font: "Rubik-Regular", fontSize: 18)
    
    lazy var temperatureSwitch = CustomSwitcherButton(imageOn: Switchers.temperatureCelcius.image, imageOff: Switchers.temperatureFarenheit.image)
    lazy var notificationSwitch = CustomSwitcherButton(imageOn: Switchers.notificationOn.image, imageOff: Switchers.notificationOff.image)
    
    private lazy var saveSettingsButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = BundleColours.orange.color
        button.tintColor = .white
        button.layer.cornerRadius = 10
        button.setTitle("СОХРАНИТЬ", for: .normal)
        button.titleLabel?.font = UIFont(name: RubikFonts.regular.rawValue, size: 13)
        button.addTarget(self, action: #selector(didTapSaveButton), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
        addingConatraints()
        
    }
    
    func setUpView(){
        view.backgroundColor = BundleColours.deepBlue.color
        view.addSubview(upperCloud)
        view.addSubview(middleCloud)
        view.addSubview(bottomCloud)
        view.addSubview(whiteSquare)
        view.addSubview(settingsLabel)
        view.addSubview(temperatureLabel)
        view.addSubview(notificationLabel)
        view.addSubview(temperatureSwitch)
        view.addSubview(notificationSwitch)
        view.addSubview(saveSettingsButton)
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
        
        notificationLabel.topToBottom(of: temperatureLabel, offset: 20)
        notificationLabel.leading(to:whiteSquare, offset: 20)
        notificationLabel.height(30)
        
        notificationSwitch.centerY(to: notificationLabel)
        notificationSwitch.right(to:whiteSquare, offset: -20)
        notificationSwitch.height(30)
        
        saveSettingsButton.centerX(to: whiteSquare)
        saveSettingsButton.topToBottom(of: notificationLabel, offset: 40)
        saveSettingsButton.height(40)
        saveSettingsButton.width(240)
    }
    
    @objc func didTapSaveButton() {
        
        delegate.notificatonState = notificationSwitch.isSelected
        delegate.temperatureState = temperatureSwitch.isSelected
        delegate.tableView.reloadData()
        dismiss(animated: true)
    }
}
