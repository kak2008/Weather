//
//  SearchLocationTableViewController.swift
//  Weather
//
//  Created by Vasanth Kodeboyina on 3/7/17.
//  Copyright © 2017 Anish Kodeboyina. All rights reserved.
//

import UIKit

class SearchLocationTableViewController: UITableViewController,UISearchResultsUpdating, UISearchBarDelegate {

    // MARK: - Properties
    var currentLocations = [Locations]()
    var filteredLocations = [Locations]()
    let searchController = UISearchController(searchResultsController: nil)
    var selectedCity: String!
    
    // MARK: - IBOutlets
    @IBOutlet var searchTableView: UITableView!
    @IBOutlet weak var locationSearchBar: UISearchBar!
    
    // MARK: - View Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Add City"
        currentLocations =
            [Locations(location: "Hyderabad"),
             Locations(location: "Mumbai"),
             Locations(location: "Delhi"),
             Locations(location: "Chennai"),
             Locations(location: "Banglore"),
             Locations(location: "Ahmedhabad"),
             Locations(location: "Kanpur"),
             Locations(location: "Vijayawada"),
             Locations(location: "Karimnagar"),
             Locations(location: "Simla"),
             Locations(location: "Kolkata")]
        
        searchController.searchBar.placeholder = "Enter City, Zip code, or airport location"
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return filteredLocations.count    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "addCityTableViewCell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = filteredLocations[indexPath.row].location
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCity = filteredLocations[indexPath.row].location
        print(selectedCity)
        _ = navigationController?.popViewController(animated: true)
    }
 
    // MARK: - Search Methods

    func updateSearchResults(for searchController: UISearchController) {
        searchForLocationWithSearchText(searchText: searchController.searchBar.text!, scope: "All")
    }
    
    func searchForLocationWithSearchText(searchText: String, scope: String) {
        if searchText.isEmpty {
            filteredLocations = currentLocations
        }
        else {
            filteredLocations = currentLocations.filter({ (Locations) -> Bool in
                return Locations.location.lowercased().contains(searchText.lowercased())
            })
        }
        tableView.reloadData()
    }

}
