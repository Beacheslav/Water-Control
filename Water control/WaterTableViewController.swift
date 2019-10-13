//
//  WaterTableViewController.swift
//  Water control
//
//  Created by  Baecheslav on 13.10.2019.
//  Copyright © 2019  Baecheslav. All rights reserved.
//

import os.log
import UIKit

class WaterTableViewController: UITableViewController {

    //MARK: Properties
    var waters = [Water]()
    
    //MARK: Actions
    @IBAction func unwindToWaterList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? WaterViewController, let water = sourceViewController.water {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                waters[selectedIndexPath.row] = water
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }
            else {
                let newIndexPath = IndexPath(row: waters.count, section: 0)
                
                waters.append(water)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
            saveWaters()
        }
    }
    
    //MARK:Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
            
        case "AddItem":
            os_log("Adding a new meal.", log: OSLog.default, type: .debug)
            
        case "ShowDetail":
            guard let waterDetailViewController = segue.destination as? WaterViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedWaterCell = sender as? WaterTableViewCell else {
                fatalError("Unexpected sender: \(String(describing: sender))")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedWaterCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedWater = waters[indexPath.row]
            waterDetailViewController.water = selectedWater
            
        default:
            fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
        }
    }
    
    //MARK: Private Methods
    private func loadSampleWaters() {
        let meal1 = Water(name: "Caprese Salad", volume: "20")
        let meal2 = Water(name: "Chicken and Potatoes", volume: "30")
        let meal3 = Water(name: "Pasta with Meatballs", volume: "40")
        waters += [meal1, meal2, meal3]
    }
    
    private func saveWaters() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(waters, toFile: Water.ArchiveURL.path)
        if isSuccessfulSave {
            os_log("Waters successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save waters...", log: OSLog.default, type: .error)
        }
    }
    
    private func loadWaters() -> [Water]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Water.ArchiveURL.path) as? [Water]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem
        if let savedWaters = loadWaters() {
            waters += savedWaters
        }
        else {
            // Load the sample data.
            loadSampleWaters()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return waters.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "WaterTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? WaterTableViewCell  else {
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }
        let water = waters[indexPath.row]
        cell.name.text = water.name
        cell.volume.text = water.volume
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            waters.remove(at: indexPath.row)
            saveWaters()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            
        }
    }
}
