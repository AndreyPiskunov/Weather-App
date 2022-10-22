//
//  CityDetailViewController.swift
//  Weather
//
//  Created by Andrey Piskunov on 15.10.2022.
//

import UIKit

class CityDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func exitButtonPressed(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
}
