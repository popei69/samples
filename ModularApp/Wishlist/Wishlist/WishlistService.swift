//
//  WishlistService.swift
//  Wishlist
//
//  Created by Benoit PASQUIER on 28/09/2019.
//  Copyright © 2019 Benoit PASQUIER. All rights reserved.
//

import Foundation

public protocol WishlistServiceProtocol {
    func getWishlist()
}

public final class WishlistService: WishlistServiceProtocol {
    
    public func getWishlist() {
        let test = "test"
    }
}
