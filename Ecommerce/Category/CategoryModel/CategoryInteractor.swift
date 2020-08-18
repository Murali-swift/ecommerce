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
        let categoryWorker = CategoryWorker.init()
        presenter?.showLoading()
        categoryWorker.fetch(completion:{ [weak self] result in
            self?.presenter?.stopLoading()
            switch result {
            case .failure( let error):
                print(error.localizedDescription)
                self?.presenter?.showError(error)
            case .success(let category):
                print(category)
                self?.presenter?.updateCategory(category)
            }
        })
    }
}

protocol workerProtocol {
    associatedtype Model
    func fetch(completion:@escaping (Result<Model, Error>) -> Void)
}

class CategoryWorker: workerProtocol{
    typealias Model = Category
    
    func fetch(completion:@escaping (Result<Category, Error>) -> Void) {
        let client = Client(session: URLSession.shared)
        client.fetch(Category.self) { (result) in
            completion(result)
        }
    }
}
