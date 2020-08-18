//
//  ChildCategory+CoreDataProperties.swift
//  Ecommerce
//
//  Created by Murali on 18/08/20.
//  Copyright © 2020 Murali. All rights reserved.
//
//

import Foundation
import CoreData


extension ChildCategory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ChildCategory> {
        return NSFetchRequest<ChildCategory>(entityName: "ChildCategory")
    }

    @NSManaged public var ids: Int64
    @NSManaged public var categories: Category?

}
