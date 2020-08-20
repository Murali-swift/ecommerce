//
//  ProductDetailPresenter.swift
//  Ecommerce
//
//  Created by Murali on 19/08/20.
//  Copyright © 2020 Murali. All rights reserved.
//

import Foundation

protocol ProductDetailPresenterProtocol:ErrorPresenter {
    func showProductDetail(_ forProduct :Products)
    func showVariant(selectedID:Int64,variants:  [Variants])
    func successfullyAddedToCart()
    func proceedWithPayment(_ defaultError: Error)
}


class ProductDetailPresenter: ProductDetailPresenterProtocol {
    weak var viewController: ProductDetailDisplayProtocol?

    func showError(_ error: Error) {
        viewController?.displayError(message: error)
    }

    func showProductDetail(_ forProduct :Products) {
        viewController?.displayProductDetail(forProduct)
    }
    
    func showVariant(selectedID:Int64,variants: [Variants]) {
        viewController?.updateVariantUI(selectedID: selectedID, variants: variants)
    }

    func successfullyAddedToCart() {
        viewController?.displaySuccessMessage(message: "Added To Cart")
    }
    
    func proceedWithPayment(_ defaultError: Error){
        viewController?.displayError(message: defaultError)
    }
}
