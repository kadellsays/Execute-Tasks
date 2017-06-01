//
//  ViewController.swift
//  Execute Tasks
//
//  Created by Kadell on 4/7/17.
//  Copyright © 2017 Kadell. All rights reserved.
//

import UIKit
import CoreData
import AVFoundation
import Photos

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, NSFetchedResultsControllerDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    
    fileprivate let reuseIdentifier = "ToDoCell"

    var controller: NSFetchedResultsController<Notes>!
    
    var context: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    let request: NSFetchRequest = Notes.fetchRequest()
   
    let manager = PHImageManager.default()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Text"
        self.collectionView.backgroundColor = Colors.lightGray
        self.navigationController?.navigationBar.barTintColor = Colors.lightPurple
        if let layout = collectionView?.collectionViewLayout as? CustomLayout {
            layout.delegate = self
        }

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
                return info.numberOfObjects
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
   
        
        if let addEditVC = storyboard?.instantiateViewController(withIdentifier: "AddEditVC") as? AddEditViewController {
                
                addEditVC.currentlyEditing = true
                addEditVC.currentNoteBeingEdited = object
                
                navigationController?.pushViewController(addEditVC, animated: true)
            }
    }
    
    
    
    

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        
    }
    
    
    
    //MARK: -Actions
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "AddEditVC") as? AddEditViewController {
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func assignbackground(){
        let background = UIImage(named: "background")
        
        var imageView : UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIViewContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        collectionView.addSubview(imageView)
        self.collectionView.sendSubview(toBack: imageView)
    }
    
    
}

extension ViewController: LayoutDelegate {
    
    func collectionView(collectionView:UICollectionView, heightForPhotoAtIndexPath indexPath: NSIndexPath,
                        withWidth width: CGFloat) -> CGFloat {
//        let photo = controller.sections?[indexPath.row].numberOfObjects
////            photos[indexPath.item]
//        let boundingRect =  CGRect(x: 0, y: 0, width: width, height: CGFloat(MAXFLOAT))
//        let rect  = AVMakeRectWithAspectRatioInsideRect(photo.image.size, boundingRect)
        return 100
//            rect.size.height
    }
    
    
    func collectionView(collectionView: UICollectionView,
                        heightForAnnotationAtIndexPath indexPath: NSIndexPath, withWidth width: CGFloat) -> CGFloat {
//        let annotationPadding = CGFloat(4)
//        let annotationHeaderHeight = CGFloat(17)
//        let photo = controller.sections?[indexPath.row].numberOfObjects
////            photos[indexPath.item]
//        let font = UIFont(name: "AvenirNext-Regular", size: 10)!
//        let commentHeight = photo.heightForComment(font, width: width)
//        let height = annotationPadding + annotationHeaderHeight + commentHeight + annotationPadding
        return 0
    }
    
    
}

