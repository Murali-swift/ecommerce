//
//  ProductInteractor.swift
//  Ecommerce
//
//  Created by Murali on 19/08/20.
//  Copyright © 2020 Murali. All rights reserved.
//

import Foundation

protocol ProductInteractorProtocol {
    func fetchProductForCategory(id: Int64, filter:String?)
    func titleForCategory(id:Int64)
    func fetchRankingFilter()
}

class  ProductInteractor: ProductInteractorProtocol {
    var presenter: ProductPresenterProtocol?

    func titleForCategory(id:Int64) {
        presenter?.updateTitle(LocalProductWorker().title(categoryID: id))
    }
    
    func fetchProductForCategory(id: Int64, filter:String? = "All") {
        if filter?.isEmpty ?? true{
            presenter?.updateProduct(LocalProductWorker().fetchProducts(categoryID: id))
        }else {
            presenter?.updateProduct(LocalProductWorker().fetchProductsInSorted(categoryID: id, forName: filter!))
//            presenter?.updateProduct(products)
        }
    }
    
    func fetchRankingFilter() {
        presenter?.updateFilter(LocalProductWorker().fetchFilter())
    }
    

    
}
