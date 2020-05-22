//
//  NewExerciseViewController.swift
//  MVPSportNote
//
//  Created by Andrew Peneznyk on 21.05.2020.
//  Copyright © 2020 Andrew Penzenyk. All rights reserved.
//

import UIKit

protocol  NewExerciseDisplayLogic: NSObjectProtocol {
    
}


class NewExerciseViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var data = NewExerciseModel()
    var searchText = [String]()
    var searching = false
    var selectedField: String = ""
    var delegate: NewUnitDisplayLogic?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView?.dataSource = self
        tableView?.delegate = self
        tableView.register( UITableViewCell.self, forCellReuseIdentifier: "Cell")
        definesPresentationContext = true
        searchBar.delegate = self
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination =  segue.destination as? NewUnitViewController{
            destination.selectedField = selectedField
            destination.delegate = delegate
            delegate = nil
        }
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        backItem.tintColor = UIColor.white
        navigationItem.backBarButtonItem = backItem
    }
    
}
extension NewExerciseViewController: UITableViewDataSource,UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching
        {
            return searchText.count
        }
        return data.choise.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! UITableViewCell
        
        if searching
        {
            cell.textLabel?.text = searchText[indexPath.row]
        }
        else
        {
            cell.textLabel?.text = data.choise[indexPath.row]
        }
        return cell
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedField = data.choise[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "NewUnitSegue", sender: self)
    }
    
}
extension NewExerciseViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchText = data.choise.filter({$0.lowercased().prefix(searchText.count) == searchText.lowercased()})
        searching =  searchText.count > 0
        tableView.reloadData()
    }
}
