//
//  ProductsOrderType+CoreDataProperties.swift
//  Ecommerce
//
//  Created by Murali on 18/08/20.
//  Copyright © 2020 Murali. All rights reserved.
//
//

import Foundation
import CoreData


extension ProductsOrderType {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProductsOrderType> {
        return NSFetchRequest<ProductsOrderType>(entityName: "ProductsOrderType")
    }

    @NSManaged public var id: Int64
    @NSManaged public var order_Count: Int64
    @NSManaged public var ranking: Ranking?

}
