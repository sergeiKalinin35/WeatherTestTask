//
//  addCity.swift
//  WeatherTestTask
//
//  Created by Sergey on 20.09.2021.
//

import UIKit

extension UIViewController {
    
    func alertPlusCity(name: String, placeholder: String, completionHandler: @escaping (String) -> Void) {
        
        let alertController = UIAlertController(title: name, message: nil, preferredStyle: .alert)
        let alertOk = UIAlertAction(title: "OK", style: .default) { (action) in
            let textFieldtext = alertController.textFields?.first
            guard let text = textFieldtext?.text else { return }
            completionHandler(text)
            
        }
        alertController.addTextField { (textField) in
            textField.placeholder = placeholder
        }
        
        let alertCancel = UIAlertAction(title: "Cancel", style: .default)
        
        alertController.addAction(alertOk)
        alertController.addAction(alertCancel)
        
        present(alertController, animated: true, completion: nil)
    }
}





