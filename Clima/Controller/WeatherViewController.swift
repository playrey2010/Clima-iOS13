//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        searchTextField.delegate = self // the current view controller becomes the delegate for the search field, constantly updating what is happening in the searh field to the view controller
        
    }


    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
//        print(searchTextField.text!)
    }
    
    // the below function comes from/depends on the UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
//        print(searchTextField.text!)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        // Use searchTextField.text to get the weather for that city
        
        
        searchTextField.text = ""
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Please type a location"
            return false
        }
    }
}

