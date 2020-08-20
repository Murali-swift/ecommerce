//
//  Products+CoreDataProperties.swift
//  Ecommerce
//
//  Created by Murali on 20/08/20.
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
    @NSManaged public var viewCount: Int64
    @NSManaged public var shareCount: Int64
    @NSManaged public var orderCount: Int64
    @NSManaged public var owner: Category?
    @NSManaged public var tax: Tax?
    @NSManaged public var variant: NSOrderedSet?

}

// MARK: Generated accessors for variant
extension Products {

    @objc(insertObject:inVariantAtIndex:)
    @NSManaged public func insertIntoVariant(_ value: Variants, at idx: Int)

    @objc(removeObjectFromVariantAtIndex:)
    @NSManaged public func removeFromVariant(at idx: Int)

    @objc(insertVariant:atIndexes:)
    @NSManaged public func insertIntoVariant(_ values: [Variants], at indexes: NSIndexSet)

    @objc(removeVariantAtIndexes:)
    @NSManaged public func removeFromVariant(at indexes: NSIndexSet)

    @objc(replaceObjectInVariantAtIndex:withObject:)
    @NSManaged public func replaceVariant(at idx: Int, with value: Variants)

    @objc(replaceVariantAtIndexes:withVariant:)
    @NSManaged public func replaceVariant(at indexes: NSIndexSet, with values: [Variants])

    @objc(addVariantObject:)
    @NSManaged public func addToVariant(_ value: Variants)

    @objc(removeVariantObject:)
    @NSManaged public func removeFromVariant(_ value: Variants)

    @objc(addVariant:)
    @NSManaged public func addToVariant(_ values: NSOrderedSet)

    @objc(removeVariant:)
    @NSManaged public func removeFromVariant(_ values: NSOrderedSet)

}
