//
//  CategoryPresenter.swift
//  Ecommerce
//
//  Created by Murali on 17/08/20.
//  Copyright © 2020 Murali. All rights reserved.
//

import Foundation

protocol Presenter: class {
    func showError(_ error:Error)
    func showLoading()
    func stopLoading()
}

protocol CategoryPresenterProtocol:Presenter {
    func updateCategory(_ categories:[Category])
    func presentSubCategory(category:Category?,completion:(Category?)->())
}


class CategoryPresenter:CategoryPresenterProtocol {
    weak var viewController: CategoryDisplayProtocol?

    func updateCategory(_ categories: [Category]) {
        viewController?.displayContent(categories: categories)
    }
    
    func presentSubCategory(category:Category?,completion:(Category?)->()) {
        completion(category)
    }

    func showError(_ error: Error) {
        viewController?.displayError(message: error)
    }
    
    func showLoading() {
        viewController?.displayLoading()
    }
    
    func stopLoading() {
        viewController?.removeLoading()
    }
    
    
}
