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

    
    // MARK: - IBOutlets
    @IBOutlet var searchTableView: UITableView!
    
    // MARK: - View Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        currentLocations = [Locations(location: "Hyderabad"),
                            Locations(location: "Mumbai"),
                            Locations(location: "Delhi"),
                            Locations(location: "Chennai"),
                            Locations(location: "Banglore"),
                            Locations(location: "Ahmedhabad")]
        
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
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
