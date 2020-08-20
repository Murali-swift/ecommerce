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
            var products: [Products] = []
            for productItem in categoryItem.productList {
                let product = Products(context: context)
                product.id = Int64(productItem.id ?? 0)
                product.name = productItem.name
                product.owner = categories
                product.date_added = productItem.date_added

                let variants =  productItem.variants.compactMap { (varientItem) -> Variants in
                    let variant = Variants(context: context)
                    variant.id = Int64(varientItem.id ?? 0)
                    variant.price = Int64(varientItem.price ?? 0)
                    variant.color = varientItem.color
                    variant.size = Int64(varientItem.size ?? 0)
                    return variant
                }
                if !variants.isEmpty {
                    product.addToVariant(NSOrderedSet.init(array: variants))
                }

                let tax = Tax(context: context)
                tax.name = productItem.tax?.name
                tax.value = productItem.tax?.value ?? 0.0
                product.tax = tax
                products.append(product)
//                categories.addToProducts(product)
            }
            if !products.isEmpty {
                categories.addToProducts(NSOrderedSet.init(array: products.compactMap({$0})))
            }
            
            let childs = categoryItem.child_categories.compactMap { (id) -> ChildCategory in
                let child = ChildCategory(context: context)
                child.ids = Int64(id)
                return child
            }

//            var childs = [ChildCategory]()
//            for id in categoryItem.child_categories {
//                let child = ChildCategory(context: context)
//                child.ids = Int64(id)
//                childs.append(child)
//            }
            if !childs.isEmpty {
                categories.addToSubCategories(NSSet.init(array: childs))
            }
        }
    }
    
    func storeRanking(_ list: [Rankings]) {
        for item in list {
            let rank = Ranking(context: context)
            rank.ranking = item.ranking
            var orders = [ProductsOrderType]()
            var shares = [ProductsShareType]()
            var views = [ProductsViewType]()

            for subItem in item.products {
                if let value = subItem.order_count {
                    let order = ProductsOrderType(context: context)
                    order.id = Int64(subItem.id ?? 0)
                    order.order_Count = Int64(value)
                    orders.append(order)
                }else if let value = subItem.shares {
                    let share = ProductsShareType (context: context)
                    share.id = Int64(subItem.id ?? 0)
                    share.shares  = Int64(value)
                    shares.append(share)
                }else if let value = subItem.view_count {
                    let viewCount = ProductsViewType (context: context)
                    viewCount.id = Int64(subItem.id ?? 0)
                    viewCount.viewCount = Int64(value)
                    views.append(viewCount)
                }
            }
            if !orders.isEmpty {
                rank.addToOrderType(NSSet.init(array: orders))
            }
            if !shares.isEmpty {
                rank.addToShareType(NSSet.init(array: shares))
            }
            if !views.isEmpty {
                rank.addToViewType(NSSet.init(array: views))
            }
        }

    }
}
