//
//  ProductInteractor.swift
//  Ecommerce
//
//  Created by Murali on 19/08/20.
//  Copyright © 2020 Murali. All rights reserved.
//

import Foundation

protocol ProductInteractorProtocol {
    func fetchProductForCategory(id:Int64)
}

class  ProductInteractor: ProductInteractorProtocol {
    var presenter: ProductPresenterProtocol?

    func fetchProductForCategory(id: Int64) {
        let products = LocalProductWorker(categoryID: id).fetch()
        
    }
    
}
