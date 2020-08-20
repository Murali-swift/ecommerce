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
    func fetchRelatedCategory(forTitle:String)
}

class  CategoryInteractor: CategoryInteractorProtocol {
    var presenter: CategoryPresenterProtocol?
    private var relatedCategories: [String:[Category]] = [:]
    private var categories: [Category] = []

    func fetchSubCategory(mainCategory:Category, forIndexPath: IndexPath, completion: (Category?)->()) {
        let subCategory = LocalCategoryFetchWorker().fetchCategory(mainCategory: mainCategory, forIndexPath: forIndexPath)
        presenter?.presentSubCategory(category: subCategory, completion: completion)
    }
    
    func fetchRelatedCategory(forTitle:String) {
        let key = relatedCategories.keys.sorted(by: {($0 > $1)})
        self.presenter?.updateMainCategory(key)

        if forTitle.isEmpty {
            presenter?.updateCategory(relatedCategories[key.first!]!)
        }else {
            key.forEach { (value) in
                if forTitle == value {
                    presenter?.updateCategory(relatedCategories[value]!)
                }
            }
        }
    }

    func fetchMainCategory() {
        let categoryWorker = CategoryWorker.init(persistance: PersistenceStorageManager.shared)
        presenter?.showLoading()
        categoryWorker.fetch(completion:{ [unowned self] result in
            self.presenter?.stopLoading()
            switch result {
            case .failure( let error):
                self.presenter?.showError(error)
            case .success(_):
                self.relatedCategories = LocalCategoryFetchWorker().classifyCategories()
                let key = self.relatedCategories.keys.sorted(by: {($0 > $1)})
                self.presenter?.updateDefaultMainCategory(key.first ?? "")
                self.fetchRelatedCategory(forTitle: "")
            }
        })
    }
}


