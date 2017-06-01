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


extension NSTextAttachment {
    func setImageWidth(width: CGFloat) {
        bounds = CGRect(x: bounds.origin.x,y: bounds.origin.y, width: width, height: width)
    }
}


extension AddEditViewController: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {

            let fullString = NSMutableAttributedString(string: "Start")
            
            let imageAttachment = NSTextAttachment()
            imageAttachment.image = image
            imageAttachment.setImageWidth(width: view.frame.size.width - 30)
            
            let imageString = NSAttributedString(attachment: imageAttachment)
            
            fullString.append(imageString)
            fullString.append(NSAttributedString(string: "End"))
            
            DispatchQueue.main.async {
                self.textLabel.attributedText = fullString
                
            }
        }
            

        dismiss(animated: true, completion: nil)
    }
    
  }
