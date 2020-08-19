//
//  CategoryModel.swift
//  Ecommerce
//
//  Created by Murali on 17/08/20.
//  Copyright © 2020 Murali. All rights reserved.
//

import Foundation

protocol JSONINitializer {
    init(_ json:Dictionary<String, Any>,_ persistent: StoreDataLocally)
}

struct Categories {
   private var category: [CategorySub] = []
   private var rankings: [Rankings] = []
    
    init(_ json:Dictionary<String, Any>,_ storage: StoreDataLocally) {
        var array = [json["categories"]]
        for case let value as Array<Any> in array {
            category =  value.map { (item) -> CategorySub  in
                CategorySub.init((item as? Dictionary<String, Any>)!)
            }
        }
        storage.storeCategory(category)
        
        array = [json["rankings"]]
        for case let value as Array<Any> in array {
            rankings =  value.map { (item) -> Rankings  in
                Rankings.init((item as? Dictionary<String, Any>)!)
            }
        }
        storage.storeRanking(rankings)
    }
}

struct CategorySub {
    var id: Int?
    var name: String?
    var productList: [AllProducts] = []
    var child_categories: [Int] = []
    
    init (_ json: Dictionary<String, Any>) {
        id = json["id"] as? Int
        name = json["name"] as? String
        
        let array = [json["products"]]
        for case let value as Array<Any> in array {
            productList = value.map { (item) -> AllProducts  in
                AllProducts.init((item as? Dictionary<String, Any>)!)
            }
        }
                
        let childArray = [json["child_categories"]]
        for case let value as Array<Any> in childArray {
            child_categories = value.map { (item) -> Int  in
                (item as? Int)!
            }
        }
    }
    
    struct AllProducts {
        var id: Int?
        var name: String?
        var date_added: String?
        var variants: [Variants] = []
        var tax: Taxes?
        init(_ json:Dictionary<String, Any>) {
            id = json["id"] as? Int
            date_added = json["date_added"] as? String
            name = json["name"] as? String
            let array = [json["variants"]]

            for case let value as Array<Any> in array {
                variants = value.map { (item) -> Variants  in
                    Variants.init((item as? Dictionary<String, Any>)!)
                }
            }
            
            let taxed = [json["tax"]]
            tax = Taxes.init(taxed)
        }
    }
    
    struct Variants  {
        var id: Int?
        var color: String?
        var size: Int?
        var price: Int?
        init(_ json:Dictionary<String, Any>) {
            id = json["id"] as? Int
            color = json["color"] as? String
            size = json["size"] as? Int
            price = json["price"] as? Int
        }
    }
    
    struct Taxes  {
        var name: String?
        var value: Float?
        init(_ json:Array<Any>) {
            for case let value as Dictionary<String,Any> in json {
                if let name = value["name"] as? String {
                    self.name = name
                }
                if let name = value["value"] as? Float {
                    self.value = name
                }
            }
        }
    }
}


extension Categories: Fetchable {
    static var apiBase: String { return Constants.extURLComponent }
}

extension Categories: JSONINitializer{
    
}
