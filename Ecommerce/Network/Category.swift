//
//  CategoryModel.swift
//  Ecommerce
//
//  Created by Murali on 17/08/20.
//  Copyright © 2020 Murali. All rights reserved.
//

import Foundation

struct Category: Decodable {
    let id: Int
    let name: String
    let products: Products
    let child_categories: [Int]
    let rankings: Rankings
    struct Products: Decodable {
        let id: Int
        let name: String
        let date_added: String
        let variants: Variants
        let tax: Tax
    }
    
    struct Variants: Decodable  {
        let id: Int
        let color: String
        let size: Int
        let price: Int
    }
    
    struct Tax: Decodable  {
        let name: String
        let value: Float
    }
    
    struct Rankings: Decodable {
        let ranking: String
        let products: SubProduct
        
        struct SubProduct: Decodable{
            let id: Int
            let order_count: Int
        }
    }
}
