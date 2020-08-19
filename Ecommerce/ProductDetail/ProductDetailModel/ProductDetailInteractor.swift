//
//  ProductDetailInteractor.swift
//  Ecommerce
//
//  Created by Murali on 19/08/20.
//  Copyright © 2020 Murali. All rights reserved.
//

import Foundation

protocol ProductDetailInteractorProtocol {
    func fetchProduct(id: Int64)
}

class  ProductDetailInteractor: ProductDetailInteractorProtocol {
    var presenter: ProductDetailPresenter?
    
    func fetchProduct(id: Int64) {
        if let product = LocalProductDetailWorker(productID: id).fetch() {
            presenter?.showProductDetail(product)
        }else {
           let error =  NSError(domain: "Not Found", code: 000, userInfo: [ NSLocalizedDescriptionKey: "Product Not Found"])
            presenter?.showError(error)
        }
    }
    
    
}
