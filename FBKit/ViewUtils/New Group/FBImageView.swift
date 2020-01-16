//
//  FBImageView.swift
//  FBKit
//
//  Created by Felipe Correia on 10/01/20.
//  Copyright © 2020 Felip38rito. All rights reserved.
//

import UIKit

/// UIImageView extension to enable
/// caching on loading from internet
/// and solve the "wrong image in collection error"
public class FBImageView: UIImageView {
    /// Control variable for showing or not the cached version
    /// correcting the behaviour of loading wrong image
    internal var imageURL: String?
    /// Control if the download will proceed or not
    internal var proceedDownload: Bool = true
    
    /// The default delegate of imageView
    public var delegate: FBImageDelegate?
    
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
            self.delegate?.didLoadFromCache(key: url, image: cached_object)
            return
        }
        /// If the delegate is active then the result of this method will say if the download will be maded
        if let delegate = self.delegate {
            proceedDownload = delegate.willDownload(url: url)
        }
        
        if proceedDownload {
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
                        self.delegate?.didDownload(url: url, image: image)
                    }
                    
                    /// store the image object in cache
    //                FBImageCache.cache.setObject(image, forKey: url as NSString)
                    FBImageCache.current.store(image: image, key: url)
                }
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
