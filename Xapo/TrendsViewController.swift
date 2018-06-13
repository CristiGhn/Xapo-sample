//
//  ViewController.swift
//  Xapo
//
//  Created by Cristian Florin Ghinea on 13/06/2018.
//  Copyright © 2018 Cristian Florin Ghinea. All rights reserved.
//

import UIKit

class TrendsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchControllerDelegate {

    // MARK: - Properties
    let searchController = UISearchController(searchResultsController: nil)

    // MARK: - IBOutlets
    @IBOutlet var tableView: UITableView!
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initSearchBar()
        
        self.requestRSS()
    }
    
    fileprivate func initSearchBar() {
        
        // Setup the Search Controller
        self.searchController.searchResultsUpdater = self
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.searchBar.placeholder = "Search Projects"
        navigationItem.searchController = self.searchController
        definesPresentationContext = true
        
        // Setup the Scope Bar
        self.searchController.searchBar.scopeButtonTitles = ["All", "Chocolate", "Hard", "Other"]
        self.searchController.searchBar.delegate = self
    }
    
    fileprivate func requestRSS() {

        let rssManager = RSSManager(url: ApiURLs.Trends.rawValue, delegate: self)
        rssManager.start()
    }
    
    // MARK: - Table View
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if isFiltering() {
//            searchFooter.setIsFilteringToShow(filteredItemCount: filteredCandies.count, of: candies.count)
//            return filteredCandies.count
//        }
//
//        searchFooter.setNotFiltering()
//        return candies.count
        
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TrendsTableViewCell", for: indexPath)
//        let candy: Candy
//        if isFiltering() {
//            candy = filteredCandies[indexPath.row]
//        } else {
//            candy = candies[indexPath.row]
//        }
//        cell.textLabel!.text = candy.name
//        cell.detailTextLabel!.text = candy.category
        return cell
    }
}

extension TrendsViewController: RSSManagerDelegate {
    // MARK: - RSSReaderDelegate
    func rssReady(items: Array<Project>?) {
            
    }
}

extension TrendsViewController: UISearchBarDelegate {
    // MARK: - UISearchBar Delegate
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
//        filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
    }
}

extension TrendsViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
//        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
//        filterContentForSearchText(searchController.searchBar.text!, scope: scope)
    }
}

