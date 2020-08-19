//
//  CategoryPresenter.swift
//  Ecommerce
//
//  Created by Murali on 17/08/20.
//  Copyright © 2020 Murali. All rights reserved.
//

import Foundation

protocol ErrorPresenter: class {
    func showError(_ error:Error)
}

protocol LoaderPresenter {
    func showLoading()
    func stopLoading()
}

typealias Presenter = ErrorPresenter & LoaderPresenter

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
