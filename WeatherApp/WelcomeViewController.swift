//
//  WelcomeViewController.swift
//  WeatherApp
//
//  Created by Maksim Kruglov on 28.11.2022.
//

import Foundation
import UIKit

class WelcomeViewController: UIViewController {
    
    private lazy var welcomeImage: UIImageView = {
        
        let image = UIImageView()
        image.image = UIImage(named: "WelcomeScreenImage")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var upperTextField: UILabel = {
        
        let textField = UILabel()
        textField.contentMode = .scaleAspectFill
        textField.font = .systemFont(ofSize: 20, weight: .semibold)
        textField.text = "Разрешить приложению Weather использовать данные о местоположении вашего устройства."
        textField.numberOfLines = 0
        textField.textAlignment = .center
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = .white
        return textField
    }()
    
    private lazy var middleTextField: UILabel = {
        
        let textField = UILabel()
        textField.contentMode = .scaleAspectFill
        textField.numberOfLines = 0
        textField.text = "Чтобы получить более точные прогнозы погоды во время движения или путешествия."
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textAlignment = .center
        textField.textColor = .white
        textField.font = .systemFont(ofSize: 18, weight: .regular)
        return textField
    }()
    
    private lazy var bottomTextField: UILabel = {
        
        let textField = UILabel()
        textField.contentMode = .scaleAspectFill
        textField.numberOfLines = 0
        textField.text = "Вы можете изменить свой выбор в любое время из меню приложения."
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textAlignment = .center
        textField.textColor = .white
        textField.font = .systemFont(ofSize: 18, weight: .regular)
        return textField
    }()
    
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
        
        NSLayoutConstraint.activate([
        
            welcomeImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            welcomeImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            welcomeImage.heightAnchor.constraint(equalToConstant: 240),
            welcomeImage.widthAnchor.constraint(equalToConstant: 310),
            
            upperTextField.topAnchor.constraint(equalTo: welcomeImage.bottomAnchor, constant: 50),
            upperTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            upperTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            middleTextField.topAnchor.constraint(equalTo: upperTextField.bottomAnchor, constant: 50),
            middleTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            middleTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            bottomTextField.topAnchor.constraint(equalTo: middleTextField.bottomAnchor, constant: 50),
            bottomTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            bottomTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            useGeolocationButton.topAnchor.constraint(equalTo: bottomTextField.bottomAnchor, constant: 50),
            useGeolocationButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            useGeolocationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            useGeolocationButton.heightAnchor.constraint(equalToConstant: 40),
            
            notUseGeolocationButton.topAnchor.constraint(equalTo: useGeolocationButton.bottomAnchor, constant: 10),
            notUseGeolocationButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            notUseGeolocationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            notUseGeolocationButton.heightAnchor.constraint(equalToConstant: 40)

        ])
    }
    
}
