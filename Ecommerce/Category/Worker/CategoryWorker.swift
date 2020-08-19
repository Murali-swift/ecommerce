//
//  CategoryWorker.swift
//  Ecommerce
//
//  Created by Murali on 19/08/20.
//  Copyright © 2020 Murali. All rights reserved.
//

import Foundation
import CoreData

protocol WorkerProtocol {
    associatedtype Model
    var persistanceManager: StoreDataLocally { get set }
    func fetch(completion:@escaping (Result<Model, Error>) -> Void)
}

class CategoryWorker: WorkerProtocol{
    var persistanceManager: StoreDataLocally
    typealias Model = Categories
    
    init(persistance: StoreDataLocally) {
        persistanceManager = persistance
    }

    func fetch(completion:@escaping (Result<Categories, Error>) -> Void) {
        let client = Client(session: URLSession.shared)
        client.fetch(Categories.self, persistent:persistanceManager) { (result) in
            completion(result)
        }
    }
}

protocol LocalCategoryFetcherProtocol {
    func mainCategories()->[Category]
    func fetchCategory(mainCategory:Category, forIndexPath: IndexPath) -> Category?
}

class LocalCategoryFetchWorker:LocalCategoryFetcherProtocol {
    func mainCategories()->[Category] {
        if let categories = try?  PersistenceStorageManager.shared.context.fetch(Category.fetchRequest()) as? [Category] {
            return  categories.filter({$0.subCategories?.allObjects.count ?? 0 > 0})
        }
        return []
    }
    
    func fetchCategory(mainCategory:Category, forIndexPath: IndexPath) -> Category? {
        if var ids = mainCategory.subCategories?.allObjects as? [ChildCategory] {
            ids.sort{$0.ids < $1.ids}
              let id = ids[forIndexPath.row].ids
              let categoryFetcher = NSFetchRequest<Category>(entityName: "Category")
              categoryFetcher.predicate = NSPredicate(format: "id == %d", id)
              return try? PersistenceStorageManager.shared.context.fetch(categoryFetcher).last
        }
        return nil
    }
}
