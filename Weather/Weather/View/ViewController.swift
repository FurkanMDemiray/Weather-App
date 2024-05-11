//
//  ViewController.swift
//  Weather
//
//  Created by Melik Demiray on 11.05.2024.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {

    @IBOutlet weak var outerView: UIView!
    @IBOutlet weak var humiditylabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var weatherStatusLabel: UILabel!
    @IBOutlet weak var tempatureLabel: UILabel!
    @IBOutlet weak var tarihLabel: UILabel!
    @IBOutlet weak var weatherImageVİew: UIImageView!

    var weatherViewModel = WeatherViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureOuterView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showLoading()
        fetchWeather()
    }

    private func showLoading() {
        let alert = UIAlertController(title: nil, message: "Loading...", preferredStyle: .alert)
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.startAnimating()
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
    }

    private func hideLoading() {
        dismiss(animated: true, completion: nil)
    }

    private func fetchWeather() {
        weatherViewModel.fetchWeather(latitude: 37.7749, longitude: 122.4194) { result in
            switch result {
            case .success(let weather):
                self.humiditylabel.text = "\(weather.main?.humidity ?? 0) %"
                self.windSpeedLabel.text = "\(weather.wind?.speed ?? 0) km/h"
                self.weatherStatusLabel.text = "\(weather.weather?[0].description?.capitalized ?? "")"
                self.tempatureLabel.text = "\(weather.main?.temp ?? 0)°C"

                let formatter = DateFormatter()
                formatter.dateFormat = "dd.MM.yyyy"
                self.tarihLabel.text = formatter.string(from: Date.now)

                if weather.weather?[0].description == "clear sky" {
                    self.weatherImageVİew.image = UIImage(named: "sun")
                } else if weather.weather?[0].description == "few clouds" {
                    self.weatherImageVİew.image = UIImage(named: "fewClouds")
                } else if weather.weather?[0].description == "scattered clouds" {
                    self.weatherImageVİew.image = UIImage(named: "clouds")
                } else if weather.weather?[0].description == "broken clouds" {
                    self.weatherImageVİew.image = UIImage(named: "clouds")
                } else if weather.weather?[0].description == "shower rain" {
                    self.weatherImageVİew.image = UIImage(named: "rain")
                } else if weather.weather?[0].description == "rain" {
                    self.weatherImageVİew.image = UIImage(named: "rain")
                } else if weather.weather?[0].description == "thunderstorm" {
                    self.weatherImageVİew.image = UIImage(named: "thunderStorm")
                } else if weather.weather?[0].description == "snow" {
                    self.weatherImageVİew.image = UIImage(named: "snow")
                } else if weather.weather?[0].description == "mist" {
                    self.weatherImageVİew.image = UIImage(named: "mist")
                }
            case .failure(let error):
                print(error)
            }
            self.hideLoading()
        }
    }

    private func configureOuterView() {
        outerView.layer.cornerRadius = 20
        outerView.layer.shadowColor = UIColor.black.cgColor
        outerView.layer.shadowOpacity = 0.5
        outerView.layer.shadowOffset = .zero
        outerView.layer.shadowRadius = 10
    }

    @IBAction func cityButtonClicked(_ sender: Any) {
        performSegue(withIdentifier: "toCityPickerVC", sender: nil)
    }
}

