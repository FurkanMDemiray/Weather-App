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
        fetchWeather()
    }

    private func fetchWeather() {
        weatherViewModel.fetchWeather(latitude: 37.7749, longitude: 122.4194) { result in
            switch result {
            case .success(let weather):
                self.humiditylabel.text = "\(weather.main?.humidity ?? 0)"
                self.windSpeedLabel.text = "\(weather.wind?.speed ?? 0)"
                self.weatherStatusLabel.text = "\(weather.weather?[0].description ?? "")"
                self.tempatureLabel.text = "\(weather.main?.temp ?? 0)°C"
                self.tarihLabel.text = "\(weather.dt ?? 0)"
                let url = URL(string: "https://openweathermap.org/img/w/\(weather.weather?[0].icon ?? "").png")
                self.weatherImageVİew.kf.setImage(with: url)
                print(weather)
            case .failure(let error):
                print(error)
            }
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

