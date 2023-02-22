//
//  WelcomeViewController.swift
//  WeatherApp
//
//  Created by Maksim Kruglov on 28.11.2022.
//

import Foundation
import UIKit
import TinyConstraints

class WelcomeViewController: UIViewController {
    
    private lazy var welcomeImage: UIImageView = {
        
        let image = UIImageView()
        image.image = UIImage(named: "WelcomeScreenImage")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var upperTextField = CustomTextLabel(
        text: "Разрешить приложению Weather использовать данные о местоположении вашего устройства.",
        textColor: .white, fontWeight: .semibold, fontSize: 20)

    private lazy var middleTextField = CustomTextLabel(
        text: "Чтобы получить более точные прогнозы погоды во время движения или путешествия.",
        textColor: .white, fontWeight: .regular, fontSize: 18)
    
    private lazy var bottomTextField: UILabel = CustomTextLabel(
        text: "Вы можете изменить свой выбор в любое время из меню приложения.",
        textColor: .white, fontWeight: .regular, fontSize: 18)
       
    
    private lazy var useGeolocationButton: UIButton = {
        
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(named: "Orange")!
        button.tintColor = .white
        button.layer.cornerRadius = 10
        button.setTitle("ИСПОЛЬЗОВАТЬ МЕСТОПОЛОЖЕНИЕ  УСТРОЙСТВА", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 13, weight: .bold)
        return button
    }()
    
    private lazy var notUseGeolocationButton: UIButton = {
        
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(named: "DeepBlue")!
        button.tintColor = .white
        button.layer.cornerRadius = 10
        button.setTitle("НЕТ, Я БУДУ ДОБАВЛЯТЬ ЛОКАЦИИ", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 13, weight: .bold)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "DeepBlue")
        view.addSubview(welcomeImage)
        view.addSubview(upperTextField)
        view.addSubview(middleTextField)
        view.addSubview(bottomTextField)
        view.addSubview(useGeolocationButton)
        view.addSubview(notUseGeolocationButton)
        addingConstraints()
    }
    
    func addingConstraints () {
        
        welcomeImage.top(to: view, offset: 100)
        welcomeImage.centerX(to: view)
        welcomeImage.height(240)
        welcomeImage.width(310)
        
        upperTextField.topToBottom(of: welcomeImage, offset: 50)
        upperTextField.leading(to: view, offset: 30)
        upperTextField.trailing(to: view, offset: -30)
        
        middleTextField.topToBottom(of: upperTextField, offset: 50)
        middleTextField.leading(to: view, offset: 30)
        middleTextField.trailing(to: view, offset: -30)
        
        bottomTextField.topToBottom(of: middleTextField, offset: 50)
        bottomTextField.leading(to: view, offset: 30)
        bottomTextField.trailing(to: view, offset: -30)
        
        useGeolocationButton.topToBottom(of: bottomTextField, offset: 50)
        useGeolocationButton.leading(to: view, offset: 30)
        useGeolocationButton.trailing(to: view, offset: -30)
        useGeolocationButton.height(40)
        
        notUseGeolocationButton.topToBottom(of: useGeolocationButton, offset: 10)
        notUseGeolocationButton.leading(to: view, offset: 30)
        notUseGeolocationButton.trailing(to: view, offset: -30)
        notUseGeolocationButton.height(40)
    }
    
}
