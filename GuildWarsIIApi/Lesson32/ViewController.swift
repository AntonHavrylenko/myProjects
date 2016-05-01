//
//  ViewController.swift
//  Lesson32
//
//  Created by Anton Havrylenko on 14.04.16.
//  Copyright © 2016 Havrylenko. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage

final class ViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Properties
    
    private(set) var cashItem = [Int: Item]()
    private(set) var allElements: JSON = nil
    private(set) var filteredItems = [Item]()
    private let searchController = UISearchController(searchResultsController: nil)
    
    // MARK: - Override functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        searchController.resignFirstResponder()
        
        getJSON()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier, detailViewController = segue.destinationViewController as? DetailViewController {
            
            if let cell = sender as? Cell, item = cashItem[tableView.indexPathForCell(cell)!.row] where identifier == "detail" && searchController.searchBar.text == "" {
                detailViewController.item = item
                
            } else if searchController.searchBar.text != "" {
                detailViewController.item = filteredItems[tableView.indexPathForCell(sender as! Cell)!.row]
            }
        }
    }
    
    // MARK: - Private functions
    
    private func getJSON() {
        Alamofire.request(.GET, "https://api.guildwars2.com/v2/items").responseJSON { response in
            guard let object = response.result.value else {
                return
            }
            
            self.allElements = JSON(object)
            
            self.tableView.reloadData()
        }
    }
    
    private func filterContentForSearchText(searchText: String) {
        filteredItems.removeAll(keepCapacity: false)
        
        let result = cashItem.values.filter({(search : Item) -> Bool in
            return search.name.lowercaseString.containsString(searchText.lowercaseString)
        })
        
        for value in result {
            filteredItems.append(value)
        }
        
        tableView.reloadData()
    }
    
}

    // MARK: - Extension with UITableViewDelegate, UITableViewDataSource

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.searchBar.text == "" {
            return allElements.count
        } else {
            return filteredItems.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! Cell
                
        if searchController.searchBar.text == "" {
            
            if let cashItem = cashItem[indexPath.row] {
                
                if let url = NSURL(string: cashItem.icon) {
                    cell.cellImageView.sd_setImageWithURL(url)
                }
                cell.label.text = cashItem.name
                
            } else {
                Alamofire.request(.GET, "https://api.guildwars2.com/v2/items/\(allElements[indexPath.row])").responseJSON { response in
                    guard let object = response.result.value else {
                        return
                    }
                    
                    let item = Item(object as! Dictionary<String, AnyObject>)
                    
                    if let url = NSURL(string: item.icon) {
                        cell.cellImageView.sd_setImageWithURL(url)
                    }
                    
                    cell.label.text = item.name
                    self.cashItem[indexPath.row] = item
                }
            }
            
        } else {
            if let url = NSURL(string: filteredItems[indexPath.row].icon) {
                cell.cellImageView.sd_setImageWithURL(url)
            }
            
            cell.label.text = filteredItems[indexPath.row].name
        }
        
        return cell
    }
    
}

    // MARK: - Extension with UISearchResultsUpdating Delegate

extension ViewController: UISearchResultsUpdating {
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        searchController.resignFirstResponder()
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
}