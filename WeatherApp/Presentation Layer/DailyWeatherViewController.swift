//
//  DailyWeatherViewController.swift
//  WeatherApp
//
//  Created by Maksim Kruglov on 17.03.2023.
//

import Foundation
import UIKit
import TinyConstraints

class DailyWeatherViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
       let view = UITableView()
        view.delegate = self
        view.dataSource = self
        view.separatorStyle = .none
        view.register(UITableViewCell.self, forCellReuseIdentifier: "Default Cell")
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        tableView.edgesToSuperview()
        
    }
}

extension DailyWeatherViewController: UITableViewDelegate, UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = GeolocationNameTableViewCell()
            cell.geolocationLabel.text = "Mozambique"
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Default Cell", for: indexPath)
            cell.textLabel?.text = "Zaglushechka"
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        20
    }
    
}
