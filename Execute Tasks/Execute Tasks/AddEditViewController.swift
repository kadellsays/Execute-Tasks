//
//  AddViewController.swift
//  Execute Tasks
//
//  Created by Kadell on 4/7/17.
//  Copyright © 2017 Kadell. All rights reserved.
//

import UIKit
import CoreData
import MobileCoreServices

class AddEditViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate, UINavigationControllerDelegate {

    //MARK: -Outlets
    @IBOutlet weak var titleLabel: UITextField!
    @IBOutlet weak var textLabel: UITextView!
    
    
    var currentlyEditing: Bool = false
    var currentNoteBeingEdited : Notes!
    
    var controller: NSFetchedResultsController<Notes>!
    
    var context: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
     let imagePickerController = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isToolbarHidden = false
        self.edgesForExtendedLayout = []
        titleLabel.delegate = self
        textLabel.delegate = self
        imagePickerController.delegate = self
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if currentlyEditing {
        self.titleLabel.text = currentNoteBeingEdited.title
        self.textLabel.text = currentNoteBeingEdited.body!
        }
        
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
    }

    //MARK: -Actions
    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        if currentlyEditing {
            currentNoteBeingEdited.title = titleLabel?.text
            currentNoteBeingEdited.body = textLabel?.text
            try? context.save()
            
        } else {
        let note = Notes(context: context)
        note.title = titleLabel?.text
        note.body = textLabel?.text
        context.insert(note)
        try? context.save()
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func cameraButtonPressed(_ sender: UIBarButtonItem) {
        imagePickerController.allowsEditing = false
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.mediaTypes = [String(kUTTypeImage)]
        self.present(imagePickerController, animated: true, completion: nil)
    }
    

}
