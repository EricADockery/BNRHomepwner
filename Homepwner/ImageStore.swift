//
//  ImageStore.swift
//  Homepwner
//
//  Created by Eric Dockery on 1/10/17.
//  Copyright © 2017 Eric Dockery. All rights reserved.
//

import UIKit

class ImageStore {
    let cache = NSCache<AnyObject, AnyObject>()
    
    func setImage(image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as AnyObject)
        let imageURL = imageURLForKey(key: key)
        if let data = UIImageJPEGRepresentation(image, 0.5) {
            do {
                try data.write(to: imageURL, options: .atomic)
            }
            catch let writeError{
                print("Error writing the image to disk: \(writeError)")
            }
        }
    }
    
    func imageForKey(key:String) -> UIImage? {
        if let existingImage = cache.object(forKey: key as AnyObject) as? UIImage {
            return existingImage
        }
        let imageURL = imageURLForKey(key: key)
        guard let imageFromDisk = UIImage(contentsOfFile: imageURL.path) else {
            return nil
        }
        cache.setObject(imageFromDisk, forKey: key as AnyObject)
        return imageFromDisk
    }
    
    func deleteImageForKey(key: String) {
        cache.removeObject(forKey: key as AnyObject)
        let imageURL = imageURLForKey(key: key)
        do {
            try FileManager.default.removeItem(at: imageURL)
        }
        catch let deleteError{
            print("Error removing the image from disk: \(deleteError)")
        }
    }
    
    func imageURLForKey(key: String) -> URL {
        let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        return documentDirectory.appendingPathComponent(key)
    }
}
