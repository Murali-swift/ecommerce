//
//  ProductInteractor.swift
//  Ecommerce
//
//  Created by Murali on 19/08/20.
//  Copyright © 2020 Murali. All rights reserved.
//

import Foundation

protocol ProductInteractorProtocol {
    func fetchProductForCategory(id: Int64)
    func fetchProductForCategory(id: Int64, filter:String?)
    func titleForCategory(id:Int64)
}

class  ProductInteractor: ProductInteractorProtocol {
    var presenter: ProductPresenterProtocol?

    func titleForCategory(id:Int64) {
        presenter?.updateTitle(LocalProductWorker(categoryID: id).title())
    }
    
    func fetchProductForCategory(id: Int64) {
        presenter?.updateProduct(LocalProductWorker(categoryID: id).fetch())
    }
    
    func fetchProductForCategory(id: Int64, filter:String?) {
        if filter?.isEmpty ?? true || filter == "All" {
            self.fetchProductForCategory(id: id)
        }else {
            
//            presenter?.updateProduct(products)
        }
    }
    

    
}
