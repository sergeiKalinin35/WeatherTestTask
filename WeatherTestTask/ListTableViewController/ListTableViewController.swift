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
    var nameCitiesArray = ["Москва", "Петербург", "Пенза", "Уфа", "Новосибирск", "Челябинск", "Омск", "Екатеринбург", "Томск", "Сочи", "Калининград"]
    
    var filterCityArray = [Weather]()
    
    
    
   let searchController = UISearchController(searchResultsController: nil)
    
    
    
    var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    
    var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
        
        
        
    }
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Поиск"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        navigationItem.hidesSearchBarWhenScrolling = false
        
        
        
        if citiesArray.isEmpty {
            
            citiesArray = Array(repeating: emptyCity, count: nameCitiesArray.count)
        }
        
      setupNavigationBar()
        addCities()
    }
        
    
    
    @IBAction func pressPlusButton(_ sender: Any) {
       
        alertPlusCity(name: "City", placeholder: "Введите название города") { (city) in
            self.nameCitiesArray.append(city)
            self.citiesArray.append( self.emptyCity)
            self.addCities()
        }
        
        
        
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
        
        if isFiltering {
            return filterCityArray.count
        }
        
       
        return citiesArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ListCell
        
      var weather = Weather()
        
        if isFiltering {
            weather = filterCityArray[indexPath.row]
        } else {
            
            weather = citiesArray[indexPath.row]
        }
        cell.configure(weather: weather)
        
        
       

        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (_, _, complectionHandler)  in
            
            let editingRow = self.nameCitiesArray[indexPath.row]
            if let index = self.nameCitiesArray.firstIndex(of: editingRow) {
                
                
                if self.isFiltering {
                    
                    self.filterCityArray.remove(at: index)
                    
                } else {
                    
                    self.citiesArray.remove(at: index)
                }
                
            }
        tableView.reloadData()
        
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
        
    }
    
    
    // переход по сигваю
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail"  {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            
            if isFiltering {
                
                let filter = filterCityArray[indexPath.row]
                let dstVC = segue.destination as! DetailViewController
                dstVC.weatherModel = filter
                
            } else {
                
                let cityweather = citiesArray[indexPath.row]
                let dstVC = segue.destination as! DetailViewController
                dstVC.weatherModel = cityweather
                
                
            }
        }
    }
}


extension ListTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
        filterContentForSearchText(searchController.searchBar.text!)
        
        
        
    }
    
    private func  filterContentForSearchText(_ searchText: String) {
        
        filterCityArray = citiesArray.filter {
            $0.name.contains(searchText)
        }
        
        tableView.reloadData()
    }
}

