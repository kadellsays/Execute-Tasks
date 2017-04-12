//
//  ViewController.swift
//  Execute Tasks
//
//  Created by Kadell on 4/7/17.
//  Copyright © 2017 Kadell. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, NSFetchedResultsControllerDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    
    fileprivate let reuseIdentifier = "ToDoCell"

    var controller: NSFetchedResultsController<Notes>!
    
    var context: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    let request: NSFetchRequest = Notes.fetchRequest()
   
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.isToolbarHidden = true
        request.sortDescriptors = [NSSortDescriptor(key: #keyPath(Notes.title), ascending: true) ]
        controller = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
         controller.delegate = self
        try!controller.performFetch()
        
        collectionView.reloadData()
    }
    

    //CollectionView DataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if let sections = controller.sections {
            let info  = sections[section]
//            if info.numberOfObjects != 0 {
                return info.numberOfObjects
//            }
        }
        
        return 1
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as!ToDoCollectionViewCell
       
            let object = self.controller.object(at: indexPath)
            cell.titleLabel.text = object.title
            cell.backgroundColor = Colors.babyBlue
            
        
        return cell
    }
    
    
    
    
    //MARK: -CollectionView Delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let object = self.controller.object(at: indexPath)
   

        
        if let addEditVC = storyboard?.instantiateViewController(withIdentifier: "AddEditVC") as? AddViewController {
            
            print(object.title!)
            if let title = object.title {
                addEditVC.resultText = title
                navigationController?.pushViewController(addEditVC, animated: true)
            }
        }
    }
    

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        
    }
    
    
    
    //MARK: -Actions
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "AddEditVC") as? AddViewController {
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
}

