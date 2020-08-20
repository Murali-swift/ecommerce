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
    func fetchProducts(categoryID: Int64) -> [Products]
    func fetchProductsInSorted(categoryID: Int64,forName:String) -> [Products]
    func fetchFilter() -> [Ranking]
    func title(categoryID: Int64) -> String
}


class LocalProductWorker: LocalProductFetcherProtocol{
    func fetchProducts(categoryID: Int64) -> [Products] {
        let categoryFetcher = NSFetchRequest<Category>(entityName: "Category")
        categoryFetcher.predicate = NSPredicate(format: "id == %d", categoryID)
        if let category = try? PersistenceStorageManager.shared.context.fetch(categoryFetcher).last {
            return category.products?.array as? [Products] ?? []
        }
    
        return []
    }
    
    func fetchProductsInSorted(categoryID: Int64,forName:String) -> [Products]{
        var products = self.fetchProducts(categoryID: categoryID)
        products.sort(by: {$0.id > $1.id })
        var dict = [Int64: Int64]()
        let categoryFetcher = NSFetchRequest<Ranking>(entityName: "Ranking")
        categoryFetcher.predicate = NSPredicate(format: "ranking == %@", forName)
        if let ranking = try? PersistenceStorageManager.shared.context.fetch(categoryFetcher).last {
            if let orderType = ranking.orderType?.allObjects as? [ProductsOrderType], !orderType.isEmpty {
                orderType.forEach { (order) in
                    dict.updateValue(order.order_Count, forKey: order.id)
                }
                products.forEach { (product) in product.orderCount = dict[product.id] ?? 0 }
                products.sort(by: {$0.orderCount > $1.orderCount})
            }else if let shareType = ranking.shareType?.allObjects as? [ProductsShareType],!shareType.isEmpty {
                shareType.forEach { (order) in
                    dict.updateValue(order.shares, forKey: order.id)
                }
                products.forEach { (product) in product.shareCount = dict[product.id] ?? 0 }
                products.sort(by: {$0.shareCount > $1.shareCount})
            }else if let viewType = ranking.viewType?.allObjects as? [ProductsViewType],!viewType.isEmpty{
                viewType.forEach { (order) in
                    dict.updateValue(order.viewCount, forKey: order.id)
                }
                products.forEach { (product) in product.viewCount = dict[product.id] ?? 0 }
                products.sort(by: {$0.viewCount > $1.viewCount})
            }
        }
        
        return products
    }
    
    func fetchFilter() -> [Ranking] {
        if let rankings = try?  PersistenceStorageManager.shared.context.fetch(Ranking.fetchRequest()) as? [Ranking] {
            var set = Set<String>.init()
            let filters = rankings.filter { (ranking) -> Bool in
                if set.contains(ranking.ranking!) {
                    return false
                }else {
                    set.insert(ranking.ranking!)
                    return true
                }
            }
            return  filters
        }
        return []
    }
    
    func title(categoryID: Int64) -> String {
        let categoryFetcher = NSFetchRequest<Category>(entityName: "Category")
        categoryFetcher.predicate = NSPredicate(format: "id == %d", categoryID)
        if let category = try? PersistenceStorageManager.shared.context.fetch(categoryFetcher).last {
            return category.name ?? ""
        }
        return ""
    }
}
