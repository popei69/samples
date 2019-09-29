//
//  ProductService.swift
//  Core
//
//  Created by Benoit PASQUIER on 28/09/2019.
//  Copyright © 2019 Benoit PASQUIER. All rights reserved.
//

import Foundation

public protocol ProductServiceProtocol {
    func getAllProducts() -> [Product]
}

public final class ProductService: ProductServiceProtocol {
    
    public init() { }
    
    public func getAllProducts() -> [Product] {
        
        // imagine we fetch products from server
        let products = [Product(name: "shoe", price: 100), Product(name: "t-shirt", price: 30)]
        
        return products
    }
}
