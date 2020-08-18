//
//  CategoryInteractor.swift
//  Ecommerce
//
//  Created by Murali on 17/08/20.
//  Copyright © 2020 Murali. All rights reserved.
//
import Foundation

protocol CategoryInteractorProtocol {
    func fetchCategory()
}

class  CategoryInteractor: CategoryInteractorProtocol {
    var presenter: CategoryPresenterProtocol?

    func fetchCategory() {
        let categoryWorker = CategoryWorker.init(persistance: PersistenceStorageManager.shared)
        presenter?.showLoading()
        categoryWorker.fetch(completion:{ [weak self] result in
            self?.presenter?.stopLoading()
            switch result {
            case .failure( let error):
                print(error.localizedDescription)
                self?.presenter?.showError(error)
            case .success(let category):
                print(category)
                if let categories = try?  PersistenceStorageManager.shared.context.fetch(Category.fetchRequest()) as? [Category] {
                    self?.presenter?.updateCategory(categories)
                }
            }
        })
    }
}

protocol workerProtocol {
    associatedtype Model
    var persistanceManager: StoreDataLocally { get set }
    func fetch(completion:@escaping (Result<Model, Error>) -> Void)
}

class CategoryWorker: workerProtocol{
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
