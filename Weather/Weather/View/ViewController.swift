//
//  ViewController.swift
//  Weather
//
//  Created by Melik Demiray on 11.05.2024.
//

import UIKit

class ViewController: UIViewController {

    var weatherViewModel = WeatherViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    private func fetchWeather() {
        weatherViewModel.fetchWeather(latitude: 37.7749, longitude: 122.4194) { result in
            switch result {
            case .success(let weather):
                print(weather)
            case .failure(let error):
                print(error)
            }
        }
    }


}

