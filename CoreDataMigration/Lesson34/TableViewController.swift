//
//  TableViewController.swift
//  Lesson34
//
//  Created by Anton Havrylenko on 28.04.16.
//  Copyright © 2016 Havrylenko. All rights reserved.
//

import UIKit
import CoreData
import Alamofire
import SwiftyJSON

final class TableViewController: UITableViewController {
    
    // MARK: - Properties
    
    private let download = Download()
    private var filteredCharacters = [Character]()
    private let searchController = UISearchController(searchResultsController: nil)
    private var appDelegate = {
        return UIApplication.sharedApplication().delegate as! AppDelegate
    }()
    var managedContext : NSManagedObjectContext = {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    }()
    lazy var fetchedResultsController: NSFetchedResultsController = {
        let fetchRequest = NSFetchRequest(entityName: "Character")
        fetchRequest.entity = NSEntityDescription.entityForName( "Character", inManagedObjectContext: self.managedContext)
        
        // if version 1
//        let sortDescriptor = NSSortDescriptor(key: "id", ascending: true)
//        fetchRequest.sortDescriptors = [sortDescriptor]
        
        // if version 1.1 and 1.2
        let predicate = NSPredicate(format: "removed == 0")
        fetchRequest.predicate = predicate
        let sortDescriptor = NSSortDescriptor(key: "orderId", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.managedContext, sectionNameKeyPath: nil, cacheName: nil)
        frc.delegate = self
        
        do {
            try frc.performFetch()
            
        } catch {
            print("An error occurred")
        }
        
        return frc
    }()
    
    // if version 1.1 and 1. 2
    private var showButton = false
    
    // IBOutlets 
    
    @IBOutlet private weak var editButton: UIBarButtonItem!
    
    // MARK: - IBActions
    
    @IBAction func showEditButton(sender: UIBarButtonItem) {
        // if version 1.1 and 1.2
        if !showButton {
            showButton = true
            tableView.reloadData()
            
        } else {
            showButton = false
            tableView.reloadData()
        }
    }
    
    // MARK: - Deinitializers
    
    deinit{
        if let superView = searchController.view.superview {
            superView.removeFromSuperview()
        }
    }
    
    // MARK: - Override functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // if version 1
//        editButton.tintColor = UIColor.clearColor()
//        editButton.enabled = false
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.barTintColor = UIColor(red: 0 / 255, green: 188 / 255, blue: 255 / 255, alpha: 1)
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        searchController.resignFirstResponder()
        
        // if version 1.1 and 1.2
        navigationItem.rightBarButtonItem = self.editButtonItem()
        
        if getRealElements() < 20 {
            download.getItemsURLs()
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier, detailViewController = segue.destinationViewController as? DetailViewController {
            
            if let cell = sender as? Cell where cell.cellImageView != nil && identifier == "detail" && searchController.searchBar.text == "" {
                let tempCharacter = fetchedResultsController.fetchedObjects![tableView.indexPathForCell(cell)!.row] as! Character
                detailViewController.hero = tempCharacter
                
            } else if searchController.searchBar.text != "" {
                let tempCharacter = filteredCharacters[tableView.indexPathForCell(sender as! Cell)!.row]
                detailViewController.hero = tempCharacter
            }
            
        } else if let identifier = segue.identifier, detailViewController = segue.destinationViewController as? EditViewController {
            
            if let button = sender as? UIButton where identifier == "EditSegue" && searchController.searchBar.text == "" {
                let tempCharacter = fetchedResultsController.fetchedObjects![button.tag] as! Character
                detailViewController.hero = tempCharacter
                
            } else if let button = sender as? UIButton where searchController.searchBar.text != "" {
                let tempCharacter = filteredCharacters[button.tag]
                detailViewController.hero = tempCharacter
            }
        }
    }
    
    // MARK: - Private functions
    
    private func showEditButtonWithAnimation(cell: Cell) {
        // if version 1.1 and 1.2
        if showButton {
            UIView.animateWithDuration(0.5, animations: {
                cell.editButton.alpha = 1
            })
            
        } else {
            UIView.animateWithDuration(0.5, animations: {
                cell.editButton.alpha = 0
            })
        }
    }
    
    private func getRealElements() -> Int {
        let fetchRequest = NSFetchRequest(entityName: "Character")
        fetchRequest.entity = NSEntityDescription.entityForName("Character", inManagedObjectContext: self.managedContext)
        
        // if version 1
//        let sortDescriptor = NSSortDescriptor(key: "id", ascending: true)
//        fetchRequest.sortDescriptors = [sortDescriptor]
        
        // if version 1.1 and 1.2
        let sortDescriptor = NSSortDescriptor(key: "orderId", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.managedContext, sectionNameKeyPath: nil, cacheName: nil)
        frc.delegate = self
        
        do {
            try frc.performFetch()
            
        } catch {
            print("An error occurred")
        }
        
        return (frc.fetchedObjects?.count)!
    }
    
    private func filterContentForSearchText(searchText: String) {
        filteredCharacters.removeAll(keepCapacity: false)
        let listCharacters = fetchedResultsController.fetchedObjects as! [Character]
        
        let result = listCharacters.filter({(search: Character) -> Bool in
            // if version 1 and 1.1
            return search.name!.lowercaseString.containsString(searchText.lowercaseString)
            
            // if version 1.2
//            return search.characterName!.lowercaseString.containsString(searchText.lowercaseString)
        })
        
        for value in result {
            filteredCharacters.append(value)
        }
        
        tableView.reloadData()
    }
    
    private func configureCell(cell: Cell, indexPath: NSIndexPath) {
        let object = fetchedResultsController.objectAtIndexPath(indexPath) as! Character
        
        if searchController.searchBar.text == "" {
            cell.editButton.tag = indexPath.row
            
            // if version 1 and 1.1
            cell.label.text = object.name
            
            if let data = object.imageData {
                cell.cellImageView.image = UIImage(data: data)
            }
            
            // if version 1.2
//            cell.label.text = object.characterName
//            
//            if let data = object.data {
//                cell.cellImageView.image = UIImage(data: data)
//            }
            
        } else {
            cell.editButton.tag = indexPath.row
            
            // if version 1 and 1.1
            cell.label.text = filteredCharacters[indexPath.row].name
            
            if let data = filteredCharacters[indexPath.row].imageData {
                cell.cellImageView.image = UIImage(data: data)
            }
            
            // if version 1.2
//            cell.label.text = filteredCharacters[indexPath.row].characterName
//           
//            if let data = filteredCharacters[indexPath.row].data {
//                cell.cellImageView.image = UIImage(data: data)
//            }
        }
    }

    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.searchBar.text == "" {
            if let count = fetchedResultsController.fetchedObjects?.count {
                return count
            }
            
            return 0
        }
        
        return filteredCharacters.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! Cell
        showEditButtonWithAnimation(cell)
        configureCell(cell, indexPath: indexPath)
        
        return cell
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        // if version 1.1 and 1.2
        let object = fetchedResultsController.objectAtIndexPath(indexPath) as! Character
        
        if editingStyle == .Delete {
            if searchController.searchBar.text != "" {
                filteredCharacters.removeAtIndex(indexPath.row)
            }
            
            // if version 1.1 and 1.2
            object.removed = true
            //
            appDelegate.saveContext()
        }
    }
    
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
       // if version 1.1 and 1.2
        if var characters = fetchedResultsController.fetchedObjects {
            let character = characters[fromIndexPath.row] as! Character
            characters.removeAtIndex(fromIndexPath.row)
            characters.insert(character, atIndex: toIndexPath.row)
            
            var orderId = Int64(characters.count)
            
            for character in characters as! [Character] {
                orderId += 1
                character.orderId = orderId
            }
            
            appDelegate.saveContext()
        }
        
        dispatch_async(dispatch_get_main_queue(), {
            tableView.reloadRowsAtIndexPaths(tableView.indexPathsForVisibleRows!, withRowAnimation: .Fade)
        })
    }
    
    // if version 1.1 and 1.2
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    // if version 1
//    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
//        return false
//    }
//    
//    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
//        return false
//    }
    
}

// MARK: - Extension with UISearchResultsUpdating Delegate

extension TableViewController: UISearchResultsUpdating {
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        searchController.resignFirstResponder()
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
}

extension TableViewController: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        tableView.beginUpdates()
    }
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        switch type {
        case .Insert:
            if let newIndexPath = newIndexPath {
                tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Fade)
            }
        case .Delete:
            tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
        case .Update:
            break
        case .Move:
            tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
            tableView.insertRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
        }
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.endUpdates()
    }
    
}
