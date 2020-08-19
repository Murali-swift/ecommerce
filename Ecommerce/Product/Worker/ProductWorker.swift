//
//  ProductWorker.swift
//  Ecommerce
//
//  Created by Murali on 19/08/20.
//  Copyright © 2020 Murali. All rights reserved.
//

import Foundation
import CoreData

protocol LocalProductFetcherProtocol {
    init(categoryID: Int64)
    func fetch()->[Products] 
}


class LocalProductWorker: LocalProductFetcherProtocol{
   private var productCategoryId: Int64
    
    required init(categoryID: Int64) {
        productCategoryId = categoryID
    }
    
    func fetch()->[Products] {
        let categoryFetcher = NSFetchRequest<Category>(entityName: "Category")
        categoryFetcher.predicate = NSPredicate(format: "id == %d", productCategoryId)
        if let category = try? PersistenceStorageManager.shared.context.fetch(categoryFetcher).last {
            return category.products?.array as? [Products] ?? []
        }
    
        return []
    }
    
    func title() -> String {
        let categoryFetcher = NSFetchRequest<Category>(entityName: "Category")
        categoryFetcher.predicate = NSPredicate(format: "id == %d", productCategoryId)
        if let category = try? PersistenceStorageManager.shared.context.fetch(categoryFetcher).last {
            return category.name ?? ""
        }
        return ""
    }
}
