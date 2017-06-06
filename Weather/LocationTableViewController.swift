//
//  LocationTableViewController.swift
//  Weather
//
//  Created by SANDEEP on 6/5/17.
//  Copyright © 2017 myProject. All rights reserved.
//

import UIKit
import CoreData

protocol LocationDelegate: class {
    
    func locationSearched(name: String)
}

class LocationTableViewController: UITableViewController {

    let searchBar = UISearchBar()
    
    weak var locationDelegate: LocationDelegate?
    
    
    fileprivate var managedObjectContext: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    fileprivate lazy var fetchedResultsController: NSFetchedResultsController<Location> = {
        // Create Fetch Request
        let fetchRequest: NSFetchRequest<Location> = Location.fetchRequest()
        
        // Configure Fetch Request
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "addedOn", ascending: true)]
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        // Create Fetched Results Controller
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: appDelegate.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        
        // Configure Fetched Results Controller
        fetchedResultsController.delegate = self as NSFetchedResultsControllerDelegate
        
        return fetchedResultsController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSearchBar()
        do {
            try self.fetchedResultsController.performFetch()
        } catch {
            let fetchError = error as NSError
            print("\(fetchError), \(fetchError.userInfo)")
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        if let sections = fetchedResultsController.sections {
            return sections.count
        }
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = fetchedResultsController.sections {
            let sectionInfo = sections[section]
            return sectionInfo.numberOfObjects
        }
        return 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure Table View Cell
        configureCell(cell: cell, atIndexPath: indexPath as NSIndexPath)

        return cell
    }
 
    func configureCell(cell: UITableViewCell, atIndexPath indexPath: NSIndexPath) {
        // Fetch Record
        let location = fetchedResultsController.object(at: indexPath as IndexPath)
        
        // Update Cell
        cell.textLabel?.text = location.name
        if location.selected {
            cell.accessoryType = .checkmark
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let location = fetchedResultsController.object(at: indexPath as IndexPath)
        if let name = location.name {
            locationDelegate?.locationSearched(name: name)
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Saved Locations"
    }
    

    // MARK: - IBActions methods
    
    @IBAction func closeButtonAction(sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Helper methods

    private func addSearchBar() {
        navigationItem.titleView = searchBar
        searchBar.delegate = self
        searchBar.placeholder = "Search city with name"
    }


}

extension LocationTableViewController: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch (type) {
        case .insert:
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .fade)
            }
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        default: break
        }
        
    }
}

extension LocationTableViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
            self.setEditing(false, animated: true)
            locationDelegate?.locationSearched(name: text)
            self.dismiss(animated: true, completion: nil)
        }
    }
}
