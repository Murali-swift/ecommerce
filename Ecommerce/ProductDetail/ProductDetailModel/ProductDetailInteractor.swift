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
    func fetchVariant(id: Int64)
    func addToCard(id: Int64)
    func buyCard(id: Int64)
}

class  ProductDetailInteractor: ProductDetailInteractorProtocol {
    var presenter: ProductDetailPresenter?
    private var variants: [Variants] = []

    func fetchProduct(id: Int64) {
        if let product = LocalProductDetailWorker(productID: id).fetch() {
            presenter?.showProductDetail(product)
            if let variants = product.variant?.array as? [Variants]{
                self.variants = variants
                presenter?.showVariant(selectedID: self.variants.first?.id ?? 0, variants: variants)
            }
        }else {
           let error =  NSError(domain: "Not Found", code: 000, userInfo: [ NSLocalizedDescriptionKey: "Product Not Found"])
            presenter?.showError(error)
        }
    }
    
    func fetchVariant(id: Int64) {
        self.variants.forEach { (item) in
            if item.id == id {
                presenter?.showVariant(selectedID: item.id , variants: variants)
            }
        }
        
    }
    
    func addToCard(id: Int64){
        presenter?.successfullyAddedToCart()
    }
    
    func buyCard(id: Int64) {
        let error =  NSError(domain: "Payment Process Failed", code: 000, userInfo: [ NSLocalizedDescriptionKey: "Payment Process Failed"])
        presenter?.proceedWithPayment(error)
    }
    
}
