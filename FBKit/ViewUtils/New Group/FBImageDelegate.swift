//
//  FBImageDelegate.swift
//  FBKit
//
//  Created by Felipe Correia on 16/01/20.
//  Copyright © 2020 Felip38rito. All rights reserved.
//

import Foundation

/// Control the lifecycle of an FBImageView when loading or storing images
public protocol FBImageDelegate {
    /// Will download a image from internet
    func willDownload(url: String) -> Bool
    /// Did complete the download
    func didDownload(url: String)
    /// Did load from cache
    func didLoadFromCache(key: String)
}

/// I'll provide a default implementation for the methods above
extension FBImageDelegate {
    func willDownload(url: String) -> Bool {
        print("FBImageDelegate: Downloading", url)
        return true
    }
    
    func didDownload(url: String) {
        print("FBImageDelegate:", url, "download complete")
    }
    
    func didLoadFromCache(key: String) {
        print("FBImageDelegate:", key, "loaded from cache")
    }
}
