//
//  AddCityViewController.swift
//  Weather
//
//  Created by Andrey Piskunov on 22.10.2022.
//

import UIKit
import CoreData

class AddCityViewController: UIViewController {
    
    // holding string values displayed by the table view
    var cities: [NSManagedObject] = []
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var resultsSearchTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        searchBar.searchTextField.backgroundColor = .white
        
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
//                     return
//                 }
//        // Get Managed Context Object with help of AppDelegate.
//                 let managedContext = appDelegate.persistentContainer.viewContext
//
//                 let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "City")
//
//                 do {
//                     cities = try managedContext.fetch(fetchRequest)
//                 } catch {
//                     print(error)
//                 }
//
//                 print(cities)
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
}

