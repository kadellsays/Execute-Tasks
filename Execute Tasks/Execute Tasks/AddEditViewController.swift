//
//  AddViewController.swift
//  Execute Tasks
//
//  Created by Kadell on 4/7/17.
//  Copyright © 2017 Kadell. All rights reserved.
//

import UIKit
import CoreData

class AddViewController: UIViewController {

    //MARK: -Outlets 
    
    @IBOutlet weak var titleLabel: UITextField!
    @IBOutlet weak var textLabel: UITextView!
    
    
    var controller: NSFetchedResultsController<Notes>!
    
    var context: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isToolbarHidden = false
        self.edgesForExtendedLayout = []
//        let note = Notes(context: context)
//        note.title = titleLabel.text
//        context.insert(<#T##object: NSManagedObject##NSManagedObject#>)
    }

    
    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        print("saved")
        let note = Notes(context: context)
        note.title = titleLabel.text
        note.body = textLabel.text
        context.insert(note)
        try? context.save()
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
