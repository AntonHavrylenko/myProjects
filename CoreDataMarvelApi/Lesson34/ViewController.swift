//
//  ViewController.swift
//  Lesson34
//
//  Created by Anton Havrylenko on 21.04.16.
//  Copyright © 2016 Havrylenko. All rights reserved.
//

import UIKit
import CoreData
import Alamofire
import SwiftyJSON

final class ViewController: UIViewController {
    
    // MARK: - Properties
    
    private var listCharacters = [Character]()
    private var filteredCharacters = [Character]()
    private let url = "http://gateway.marvel.com:80/v1/public/characters"
    private var timeStampString = ""
    private let publicKey = "47654b6646da81eed4633f939180d136"
    private let privateKey = "ec1276030b6609939ec844b40277481e60700313"
    private var hashKeyValue = ""
    private var allID = [JSON]()
    private let searchController = UISearchController(searchResultsController: nil)
    var managedContext : NSManagedObjectContext = {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    }()
    
    lazy var fetchedResultsController: NSFetchedResultsController = {
        let fetchRequest = NSFetchRequest(entityName: "Character")
        let primarySortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        let secondarySortDescriptor = NSSortDescriptor(key: "id", ascending: true)
        fetchRequest.sortDescriptors = [primarySortDescriptor, secondarySortDescriptor]
        
        let frc = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: self.managedContext,
            sectionNameKeyPath: nil,
            cacheName: nil)
        
        frc.delegate = self
        
        return frc
    }()
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Deinitializers
    
    deinit{
        if let superView = searchController.view.superview
        {
            superView.removeFromSuperview()
        }
    }
    
    // MARK: - Override functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        searchController.resignFirstResponder()
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyyMMddHHmmss"
        timeStampString = formatter.stringFromDate(NSDate())
        let tempHash = "\(timeStampString)\(privateKey)\(publicKey)".md5()
        hashKeyValue = tempHash
        
        getItemsURLs()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        
        do {
            try fetchedResultsController.performFetch()
            listCharacters = fetchedResultsController.fetchedObjects as! [Character]
            
        } catch {
            print("An error occurred")
        }
       
//        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
//        let managedContext = appDelegate.managedObjectContext
//        let fetchRequest = NSFetchRequest(entityName: "Character")
//        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
//        fetchRequest.sortDescriptors = [sortDescriptor]
//        
//        do {
//            let results = try managedContext.executeFetchRequest(fetchRequest)
//            listCharacters = results as! [NSManagedObject]
//            
//        } catch {
//            print("Error")
//        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier, detailViewController = segue.destinationViewController as? DetailViewController {
            
            if let cell = sender as? Cell where cell.cellImageView != nil && identifier == "detail" && searchController.searchBar.text == "" && listCharacters.count >= tableView.indexPathForCell(cell)!.row {
                let tempValue = listCharacters[tableView.indexPathForCell(cell)!.row]
                detailViewController.name = tempValue.name!
                detailViewController.infoDescription = tempValue.infoDescription!
                detailViewController.imageData = tempValue.imageData!
                detailViewController.id = tempValue.id!
                
            } else if searchController.searchBar.text != "" {
                let tempValue = filteredCharacters[tableView.indexPathForCell(sender as! Cell)!.row]
                detailViewController.name = tempValue.name!
                detailViewController.infoDescription = tempValue.infoDescription!
                detailViewController.imageData = tempValue.imageData!
                detailViewController.id = tempValue.id!
            }
        }
    }
    
    // MARK: - Private functions
    
    private func getItemsURLs() {
        Alamofire.request(.GET, url, parameters: ["apikey": publicKey, "ts": timeStampString, "hash": hashKeyValue]).responseJSON { response in
            
            guard let object = response.result.value else {
                return
            }
            
            let json = JSON(object)
            
            for (_, value) in json["data"]["results"] {
                let id = value["id"]
                
                self.allID.append(id)
            }
            
            self.tableView.reloadData()
        }
    }
    
    private func saveCharacter(hero: Hero) {
        let entity = NSEntityDescription.entityForName("Character", inManagedObjectContext: managedContext)
        let tempCharacter = Character(entity: entity!, insertIntoManagedObjectContext: managedContext)
        
        tempCharacter.name = hero.name
        tempCharacter.id = hero.id
        tempCharacter.imageData = hero.imageData
        tempCharacter.infoDescription = hero.description
        
        (UIApplication.sharedApplication().delegate as! AppDelegate).saveContext()
        listCharacters.append(tempCharacter)
    }
    
    private func filterContentForSearchText(searchText: String) {
        filteredCharacters.removeAll(keepCapacity: false)
        
        let result = listCharacters.filter({(search: Character) -> Bool in
            return search.name!.lowercaseString.containsString(searchText.lowercaseString)
        })
        
        for value in result {
            filteredCharacters.append(value)
        }
        
        tableView.reloadData()
    }
    
}

    // MARK: - Extension with UITableViewDataSource

extension ViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if searchController.searchBar.text == "" {
//            return listCharacters.count
//            
//        } else {
//            return filteredCharacters.count
//        }
        
        if searchController.searchBar.text == "" {
            if allID.count != 0 {
                return allID.count
            }
            
            if let sections = fetchedResultsController.sections {
                let currentSection = sections[section]
                return currentSection.numberOfObjects
            }
        }
            return filteredCharacters.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! Cell

        if searchController.searchBar.text == "" {
            
            if listCharacters.count > indexPath.row {
                cell.label.text = listCharacters[indexPath.row].name
                cell.cellImageView.image = UIImage(data: listCharacters[indexPath.row].imageData!)
                
            } else {
                let url = "http://gateway.marvel.com:80/v1/public/characters/\(allID[indexPath.row])"
                
                Alamofire.request(.GET, url, parameters: ["apikey": self.publicKey, "ts": self.timeStampString, "hash": self.hashKeyValue]).responseJSON { response in
                    
                    guard let object = response.result.value else {
                        return
                    }
                    
                    let json = JSON(object)
                    
                    dispatch_async(dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0)) {
                        let character = Hero(json: json)
                       
                        dispatch_async(dispatch_get_main_queue(), {
                            self.saveCharacter(character)
                            cell.label.text = character.name
                            cell.cellImageView.image = UIImage(data: character.imageData)
                        })
                    }
                }
            }
            
        } else {
            let value = filteredCharacters[indexPath.row]
            cell.label.text = value.name
            cell.cellImageView.image = UIImage(data: value.imageData!)
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

extension ViewController: NSFetchedResultsControllerDelegate {
    
}



