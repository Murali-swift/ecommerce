//
//  ProductsShareType+CoreDataProperties.swift
//  Ecommerce
//
//  Created by Murali on 20/08/20.
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
    @NSManaged public var shares: Int64
    @NSManaged public var ranking: Ranking?

}
