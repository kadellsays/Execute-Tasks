//
//  VCEx-Photos.swift
//  Execute Tasks
//
//  Created by Kadell on 4/27/17.
//  Copyright © 2017 Kadell. All rights reserved.
//

import Foundation
import Photos
import MobileCoreServices

extension AddEditViewController {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        switch info[UIImagePickerControllerMediaType] as! String {
            
        case String(kUTTypeImage):
           
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            addImageToView(image)
//            let imageView = UIImageView(image: image)
//            imageView.clipsToBounds = true
//            imageView.contentMode = .scaleAspectFit
//            imageView.widthAnchor.constraint(equalTo: self.view.widthAnchor)
//            imageView.heightAnchor.constraint(equalToConstant: 100)
//            textLabel.addSubview(imageView)
                }
            
        default:
            print("nope")
        }
        dismiss(animated: true, completion: nil)
    }
    
    func addImageToView(_ image: UIImage) {
        let imageContainer = UIView()
        let imageView = UIImageView(image: image)
        imageContainer.addSubview(imageView)
        imageView.sizeToFit()
        imageView.contentMode = .scaleAspectFit
        imageContainer.widthAnchor.constraint(equalTo: self.view.widthAnchor)
        imageContainer.heightAnchor.constraint(equalToConstant: 100)
        textLabel.addSubview(imageContainer)

    }
}
