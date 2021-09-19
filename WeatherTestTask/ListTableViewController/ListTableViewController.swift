//
//  ListTableTableViewController.swift
//  WeatherTestTask
//
//  Created by Sergey on 18.09.2021.
//

import UIKit


class ListTableViewController: UITableViewController {
    
    
    let emptyCity = Weather()
    
    var citiesArray = [Weather]()
    let nameCitiesArray = ["Москва", "Петербург", "Пенза", "Уфа", "Новосибирск", "Челябинск", "Омск", "Екатеринбург", "Томск", "Сочи"]
    
    
    
    
  let netManager = NetworkManager()
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if citiesArray.isEmpty {
            
            citiesArray = Array(repeating: emptyCity, count: nameCitiesArray.count)
        }
        
        
        
        
        
        setupNavigationBar()
        addCities()
        
        
        
        
       
        }
        
    func addCities() {
        
        getCityWeather(citiesArray: self.nameCitiesArray) { (index, weather) in
            
            self.citiesArray[index] = weather
            self.citiesArray[index].name = self.nameCitiesArray[index]
           
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    
  private func setupNavigationBar() {
        if #available(iOS 13.0, *) {
            
            let navBarApperance = UINavigationBarAppearance()
            navBarApperance.configureWithOpaqueBackground()
            navBarApperance.titleTextAttributes = [.foregroundColor: UIColor.white]
            navBarApperance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
            navBarApperance.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
            navigationController?.navigationBar.standardAppearance = navBarApperance
            navigationController?.navigationBar.scrollEdgeAppearance = navBarApperance

           }
        }

  
    
    
    

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        citiesArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ListCell
        
      var weather = Weather()
        weather = citiesArray[indexPath.row]
        cell.configure(weather: weather)
        
        
       

        return cell
    }
}
