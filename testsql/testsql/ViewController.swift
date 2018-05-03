//
//  ViewController.swift
//  testsql
//
//  Created by Tyler Arnold on 5/2/18.
//  Copyright © 2018 Tyler Arnold. All rights reserved.
//

import UIKit
import SQLite3

class ViewController: UIViewController {
    var db: OpaquePointer?
    
    @IBOutlet var textFieldName: UITextField!
    @IBOutlet var textFieldLevel: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        db = openDatabase()
        createTable(db: db!)
        
        //Closes keyboard when you click out of the keyboard
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: Selector("endEditing:")))
    }

    @IBAction func btnSave(_ sender: Any) {
        let name = textFieldName.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let level = textFieldLevel.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if(name?.isEmpty)! {
            print("Name is Empty")
            return
        }
        
        if(level?.isEmpty)! {
            print("Level is Empty")
            return
        }
        
        if let lvl = Int(level!) {
            insertCharacter(db: db!, name: name!, lvl: Int(lvl))
        } else {
            let alert = UIAlertController(title: "Only numbers in level", message: "Please enter a number.", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            return
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let characterSelector = segue.destination as? CharacterSelector{
            characterSelector.db = db
        }
    }
    

}

