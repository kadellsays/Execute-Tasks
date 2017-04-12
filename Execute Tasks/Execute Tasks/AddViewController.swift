//
//  AddViewController.swift
//  Execute Tasks
//
//  Created by Kadell on 4/7/17.
//  Copyright © 2017 Kadell. All rights reserved.
//

import UIKit
import CoreData

class AddViewController: UIViewController, UITextFieldDelegate {

    //MARK: -Outlets
    @IBOutlet weak var titleLabel: UITextField!
    @IBOutlet weak var textLabel: UITextView!
    
    
    var resultText = ""
    
    var controller: NSFetchedResultsController<Notes>!
    
    var context: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isToolbarHidden = false
        self.edgesForExtendedLayout = []
        titleLabel.delegate = self
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.titleLabel.text = resultText
    }
    

    
    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        let note = Notes(context: context)
        note.title = titleLabel?.text
        note.body = textLabel?.text
        context.insert(note)
        try? context.save()
        
        self.navigationController?.popViewController(animated: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
    }
    

}
