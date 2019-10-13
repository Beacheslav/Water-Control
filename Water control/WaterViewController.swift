//
//  ViewController.swift
//  Water control
//
//  Created by  Baecheslav on 12.10.2019.
//  Copyright © 2019  Baecheslav. All rights reserved.
//

import os.log
import UIKit

class WaterViewController: UIViewController, UITextFieldDelegate {

    //MARK: Properties
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var volumeTextField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var water: Water?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.delegate = self
        volumeTextField.delegate = self
        if let water = water {
        nameTextField.text = water.name
        volumeTextField.text = water.volume
        }
        updateSaveButtonState()
    }
    
    //MARK: Navigation
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        let isPresentingInAddMealMode = presentingViewController is UINavigationController
          
          if isPresentingInAddMealMode {
              dismiss(animated: true, completion: nil)
          }
          else if let owningNavigationController = navigationController{
              owningNavigationController.popViewController(animated: true)
          }
          else {
              fatalError("The MealViewController is not inside a navigation controller.")
          }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
        os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
        return
        }
        let name = nameTextField.text ?? ""
        let volume = volumeTextField.text ?? ""
        
        water = Water(name: name, volume: volume)
    }
    
    //Private Methods
    private func updateSaveButtonState() {
        let text = nameTextField.text ?? ""
        let text2 = nameTextField.text ?? ""
        saveButton.isEnabled = (!text.isEmpty && !text2.isEmpty)
    }
    
    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTextField.resignFirstResponder()
        volumeTextField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        saveButton.isEnabled = false
    }
}
