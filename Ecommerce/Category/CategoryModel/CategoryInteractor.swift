//
//  CategoryInteractor.swift
//  Ecommerce
//
//  Created by Murali on 17/08/20.
//  Copyright © 2020 Murali. All rights reserved.
//
import Foundation

protocol CategoryInteractorProtocol {
    func fetchMainCategory()
    func fetchSubCategory(mainCategory:Category, forIndexPath: IndexPath, completion:(Category?)->())
}

class  CategoryInteractor: CategoryInteractorProtocol {
    var presenter: CategoryPresenterProtocol?

    func fetchSubCategory(mainCategory:Category, forIndexPath: IndexPath, completion: (Category?)->()) {
        let subCategory = LocalCategoryFetchWorker().fetchCategory(mainCategory: mainCategory, forIndexPath: forIndexPath)
        presenter?.presentSubCategory(category: subCategory, completion: completion)
    }

    func fetchMainCategory() {
        let categoryWorker = CategoryWorker.init(persistance: PersistenceStorageManager.shared)
        presenter?.showLoading()
        categoryWorker.fetch(completion:{ [weak self] result in
            self?.presenter?.stopLoading()
            switch result {
            case .failure( let error):
                self?.presenter?.showError(error)
            case .success(_):
                self?.presenter?.updateCategory(LocalCategoryFetchWorker().mainCategories())
            }
        })
    }
}


