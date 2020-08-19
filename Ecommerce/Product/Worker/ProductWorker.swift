//
//  ProductWorker.swift
//  Ecommerce
//
//  Created by Murali on 19/08/20.
//  Copyright © 2020 Murali. All rights reserved.
//

import Foundation

protocol LocalProductFetcherProtocol {
    init(categoryID: Int64)
}


class LocalProductWorker: LocalProductFetcherProtocol{
   private var productCategoryId: Int64
    
    required init(categoryID: Int64) {
        productCategoryId = categoryID
    }
    
    func fetch()->[Products] {
        
    }
}
