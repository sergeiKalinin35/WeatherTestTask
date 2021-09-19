//
//  DetailViewController.swift
//  WeatherTestTask
//
//  Created by Sergey on 19.09.2021.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var nameCityLabel: UILabel!
    @IBOutlet var ImageCity: UIImageView!
    @IBOutlet var conditionLabel: UILabel!
    @IBOutlet var tempCityLabel: UILabel!
    
    @IBOutlet var pressureLabel: UILabel!
    @IBOutlet var windSpeedLabel: UILabel!
    @IBOutlet var minTempLabel: UILabel!
    @IBOutlet var maxTempLabel: UILabel!
    
    var weatherModel: Weather?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        refreshLabels()
    }
    
    func refreshLabels() {
        
        nameCityLabel.text = weatherModel?.name
        
        
      //  let url = URL(string: "https://yastatic.net/weather/i/icons/blueye/color/svg/\(weatherModel!.conditionCode).svg")
       //  let weatherImage = UIView(SVGUARL: url!) {(image) in
     //    image.resizeToFit(self.viewCity.bounds)
     //    }
      //   self.viewCity.addSubview(weatherImage)
        
        
        
        conditionLabel.text = weatherModel?.conditionString
        tempCityLabel.text = "\((weatherModel?.temperature)!)"
        pressureLabel.text = "\((weatherModel?.presureMm)!)"
        windSpeedLabel.text = "\((weatherModel?.windSpeed)!)"
        minTempLabel.text = "\((weatherModel?.tempMin)!)"
        maxTempLabel.text = "\((weatherModel?.tempMax)!)"
        
        
    }
    
    
}
