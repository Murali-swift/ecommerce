//
//  Ranking.swift
//  Ecommerce
//
//  Created by Murali on 18/08/20.
//  Copyright © 2020 Murali. All rights reserved.
//

import Foundation

struct Rankings {
    let ranking: String?
    var products: [SubProduct] = []
    init (_ json: Dictionary<String, Any>) {
        ranking = json["ranking"] as? String
        let array = [json["products"]]
        for case let value as Array<Any> in array {
            products = value.map { (item) -> SubProduct  in
                SubProduct.init((item as? Dictionary<String, Any>)!)
            }
        }
    }
    
    struct SubProduct {
        let id: Int?
        let order_count: Int?
        let view_count: Int?
        let shares: Int?
        init(_ json:Dictionary<String, Any>) {
            id = json["id"] as? Int
            order_count = json["order_count"] as? Int
            view_count = json["view_count"] as? Int
            shares = json["shares"] as? Int
        }
    }
}
