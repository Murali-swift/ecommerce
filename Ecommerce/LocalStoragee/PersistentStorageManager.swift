//
//  PersistentStorageManager.swift
//  Ecommerce
//
//  Created by Murali on 18/08/20.
//  Copyright © 2020 Murali. All rights reserved.
//

import Foundation
import CoreData

protocol StoreDataLocally {
    func storeCategory(_ list:[CategorySub])
    func storeRanking(_ list: [Rankings])
}

final class PersistenceStorageManager {
    private init() {}
    static let shared = PersistenceStorageManager()
    lazy var context = persistentContainer.viewContext

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreDataModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

extension PersistenceStorageManager:StoreDataLocally {
    func storeCategory(_ list: [CategorySub]) {
        for categoryItem in list {
            let categories = Category(context: context)
            categories.id = Int64(categoryItem.id ?? 0)
            categories.name = categoryItem.name
            for productItem in categoryItem.productList {
                let product = Products(context: context)
                product.id = Int64(productItem.id ?? 0)
                product.name = productItem.name
                product.owner = categories
                product.date_added = productItem.date_added
                for varientItem in productItem.variants {
                    let variant = Variants(context: context)
                    variant.id = Int64(varientItem.id ?? 0)
                    variant.price = Int64(varientItem.price ?? 0)
                    variant.color = varientItem.color
                    variant.size = Int64(varientItem.size ?? 0)
                    product.addToVariant(variant)
                }
                let tax = Tax(context: context)
                tax.name = productItem.tax?.name
                tax.value = productItem.tax?.value ?? 0.0
                product.tax = tax
                categories.addToProducts(product)

            }
        }
    }
    
    func storeRanking(_ list: [Rankings]) {
        for item in list {
            let rank = Ranking(context: context)
            rank.ranking = item.ranking
            for subItem in item.products {
                if let value = subItem.order_count {
                    let order = ProductsOrderType(context: context)
                    order.id = Int64(subItem.id ?? 0)
                    order.order_Count = Int64(value)
                    rank.addToOrderType(order)
                }else if let value = subItem.shares {
                    let share = ProductsShareType (context: context)
                    share.id = Int64(subItem.id ?? 0)
                    share.view_count = Int64(value)
                    rank.addToShareType(share)
                }else if let value = subItem.view_count {
                    let viewCount = ProductsViewType (context: context)
                    viewCount.id = Int64(subItem.id ?? 0)
                    viewCount.shares = Int64(value)
                    rank.addToViewType(viewCount)
                }
            }
        }
        try? context.save()
    }
}
