//
//  AddCityViewController.swift
//  Weather
//
//  Created by Andrey Piskunov on 22.10.2022.
//

import UIKit

class AddCityViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var resultsSearchTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.searchTextField.backgroundColor = .white
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
}

