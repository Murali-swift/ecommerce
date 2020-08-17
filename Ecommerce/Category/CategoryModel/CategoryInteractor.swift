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
        categoryWorker.fetch(completion:{ result in
            switch result {
            case .failure( let error):
                print(error.localizedDescription)
            case .success(let category):
                print(category)
            }
        })
    }
}

protocol workerProtocol {
    func fetch(completion:@escaping (Result<Category, Error>) -> Void)
}

class CategoryWorker: workerProtocol{
    func fetch(completion:@escaping (Result<Category, Error>) -> Void) {
        let client = Client(session: URLSession.shared)
        client.fetch(Category.self) { (result) in
            completion(result)
        }
    }
}
