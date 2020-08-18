//
//  Products+CoreDataProperties.swift
//  Ecommerce
//
//  Created by Murali on 18/08/20.
//  Copyright © 2020 Murali. All rights reserved.
//
//

import Foundation
import CoreData


extension Products {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Products> {
        return NSFetchRequest<Products>(entityName: "Products")
    }

    @NSManaged public var date_added: String?
    @NSManaged public var id: Int64
    @NSManaged public var name: String?
    @NSManaged public var owner: Category?
    @NSManaged public var variant: NSSet?
    @NSManaged public var tax: Tax?

}

// MARK: Generated accessors for variant
extension Products {

    @objc(addVariantObject:)
    @NSManaged public func addToVariant(_ value: Variants)

    @objc(removeVariantObject:)
    @NSManaged public func removeFromVariant(_ value: Variants)

    @objc(addVariant:)
    @NSManaged public func addToVariant(_ values: NSSet)

    @objc(removeVariant:)
    @NSManaged public func removeFromVariant(_ values: NSSet)

}
