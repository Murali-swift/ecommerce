//
//  Tax+CoreDataProperties.swift
//  Ecommerce
//
//  Created by Murali on 18/08/20.
//  Copyright © 2020 Murali. All rights reserved.
//
//

import Foundation
import CoreData


extension Tax {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Tax> {
        return NSFetchRequest<Tax>(entityName: "Tax")
    }

    @NSManaged public var name: String?
    @NSManaged public var value: Float
    @NSManaged public var product: Products?

}
