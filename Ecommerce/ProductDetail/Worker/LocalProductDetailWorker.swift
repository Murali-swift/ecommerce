//
//  LocalProductDetailWorker.swift
//  Ecommerce
//
//  Created by Murali on 19/08/20.
//  Copyright © 2020 Murali. All rights reserved.
//

import Foundation
import CoreData

protocol LocalProductDetailFetcherProtocol {
    init(productID: Int64)
    func fetch()->Products?
}


class LocalProductDetailWorker: LocalProductDetailFetcherProtocol{
   private var productId: Int64
    
    required init(productID: Int64) {
        self.productId = productID
    }
    
    func fetch()->Products? {
        let productFetcher = NSFetchRequest<Products>(entityName: "Products")
        productFetcher.predicate = NSPredicate(format: "id == %d", productId)
        if let product = try? PersistenceStorageManager.shared.context.fetch(productFetcher).last {
            return product
        }
    
        return nil
    }
    
}
