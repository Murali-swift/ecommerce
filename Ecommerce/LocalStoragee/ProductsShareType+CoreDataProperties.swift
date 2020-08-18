//
//  ProductsShareType+CoreDataProperties.swift
//  Ecommerce
//
//  Created by Murali on 18/08/20.
//  Copyright © 2020 Murali. All rights reserved.
//
//

import Foundation
import CoreData


extension ProductsShareType {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProductsShareType> {
        return NSFetchRequest<ProductsShareType>(entityName: "ProductsShareType")
    }

    @NSManaged public var id: Int64
    @NSManaged public var view_count: Int64
    @NSManaged public var ranking: Ranking?

}
