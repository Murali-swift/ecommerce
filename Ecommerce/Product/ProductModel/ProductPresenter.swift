//
//  ProductPresenter.swift
//  Ecommerce
//
//  Created by Murali on 19/08/20.
//  Copyright © 2020 Murali. All rights reserved.
//

import Foundation

protocol ProductPresenterProtocol:Presenter {
    func updateProduct(_ product:[Products])
    
}


class ProductPresenter:ProductPresenterProtocol {
    weak var viewController: ProductDisplayProtocol?

    func updateProduct(_ product: [Products]) {
        viewController?.displayContent(products: product)
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
