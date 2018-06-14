//
//  ViewController.swift
//  Xapo
//
//  Created by Cristian Florin Ghinea on 13/06/2018.
//  Copyright © 2018 Cristian Florin Ghinea. All rights reserved.
//

import UIKit

class TrendsViewController: UIViewController {

    // MARK: - Properties
    let searchController = UISearchController(searchResultsController: nil)
    var projects: Array<Project>?
    var filteredProjects: Array<Project>?
    var selectedProject: Project?

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
    }
    
    fileprivate func requestRSS() {

        let rssManager = RSSManager(url: ApiURLs.Trends.rawValue, delegate: self)
        rssManager.start()
    }
}

extension TrendsViewController: UITableViewDataSource {
    
    // MARK: - UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.filteredProjects != nil {
            return (self.filteredProjects?.count)!
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TrendsTableViewCell", for: indexPath) as! TrendsTableViewCell
        
        if let project = self.filteredProjects?[indexPath.row] {
            
            cell.titleTextLabel.text = "\(project.title ?? "")"
            cell.linkTextLabel.text = "\(project.link?.absoluteString ?? "")"
            cell.descriptionTextLabel.text = "Description:\r \(project.projectDescription ?? "")"
        }
        
        return cell
    }
}

extension TrendsViewController: UITableViewDelegate {
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedProject = self.filteredProjects?[indexPath.row]
        performSegue(withIdentifier: "projectDetailsSegue", sender: nil)
    }
}

extension TrendsViewController: RSSManagerDelegate {
    // MARK: - RSSReaderDelegate
    func rssReady(items: Array<Project>?) {
        self.projects = items
        self.filteredProjects = items
        self.tableView.reloadData()
    }
}

extension TrendsViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        self.filteredProjects = self.projects?.filter({( project : Project) -> Bool in
          
            if !searchBarIsEmpty() {
                return project.title!.lowercased().contains(searchText.lowercased());
            } else {
                return true
            }
        })
        
        self.tableView.reloadData()
    }
    
    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
}

extension TrendsViewController {
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "projectDetailsSegue" {
            let projectDetailsVC = segue.destination as! ProjectDetailsViewController
            projectDetailsVC.project = self.selectedProject
        }
    }
}

