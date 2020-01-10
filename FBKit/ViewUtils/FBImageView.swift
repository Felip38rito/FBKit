//
//  FBImageView.swift
//  FBKit
//
//  Created by Felipe Correia on 10/01/20.
//  Copyright © 2020 Felip38rito. All rights reserved.
//

import UIKit

/// A singleton who store cached images
public class FBImageCache {
    internal let cache = NSCache<NSString, UIImage>()
    
    public static let current = FBImageCache()
    /// Impossible to instance from its own
    private init() {  }
    
    public func store(image: UIImage, key: String) {
        cache.setObject(image, forKey: key as NSString)
    }
    
    public func get(key: String) -> UIImage? {
        cache.object(forKey: key as NSString)
    }
}

/// UIImageView extension to enable
/// caching on loading from internet
/// and solve the "wrong image in collection error"
public class FBImageView: UIImageView {
    /// Control variable for showing or not the cached version
    /// correcting the behaviour of loading wrong image
    internal var imageURL: String?
    /**
     Load image from url via https and store in the cache before showing
     
     - Parameter url: URL in string to load from
    */
    public func load(from url: String) {
        self.image = nil
        /// Assing the url to this object for control
        self.imageURL = url
        
        if let cached_object = FBImageCache.current.get(key: url) {
            self.image = cached_object
            return
        }
        
        /// Download the image in a background thread
        DispatchQueue.global().async { [self] in
            guard let url_remote = URL(string: url) else { return }
            guard let data = try? Data(contentsOf: url_remote) else { return }
            
            /// Setup the image in the main thread
            DispatchQueue.main.async {
                guard let image = UIImage(data: data) else { return }
                
                /// The bugfix verification:
                /// Only set the image when the url matches avoinding strange changes in collections
                if self.imageURL == url {
                    self.image = image
                }
                
                /// store the image object in cache
//                FBImageCache.cache.setObject(image, forKey: url as NSString)
                FBImageCache.current.store(image: image, key: url)
            }
        }
    }
    
    /**
     Convenience method: Load a named asset in the catalog
     - Parameter name: Name of the asset in the catalog
     */
    public func load(name: String) {
        self.image = UIImage(named: name)
    }
}
