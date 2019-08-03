//
//  UIImage + Extension.swift
//  News app
//
//  Created by Hassan Mostafa on 8/1/19.
//  Copyright © 2019 Hassan Mostafa. All rights reserved.
//

import UIKit
let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    // for downloading + caching images
    func downloadImageWithCache(stringUrl: String){
        self.image = nil
        guard let imageUrl = URL(string: stringUrl) else{return}
        // if cache exist -----
        if let imageFromCache = imageCache.object(forKey: stringUrl as AnyObject) as? UIImage {
            self.image = imageFromCache
        }else{
            // if cach does not exist ----
            URLSession.shared.dataTask(with: imageUrl) { (data, res, err) in
                if err == nil {
                    
                    DispatchQueue.main.async {
                        if let downloadedImage = UIImage(data: data!){
                            imageCache.setObject(downloadedImage, forKey: stringUrl as AnyObject)
                            self.image = downloadedImage
                        }
                    }
                }else{
                    print(err!)
                }
                }.resume()
        }
    }
}

