//
//  Category+CoreDataProperties.swift
//  Ecommerce
//
//  Created by Murali on 18/08/20.
//  Copyright © 2020 Murali. All rights reserved.
//
//

import Foundation
import CoreData


extension Category {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category")
    }

    @NSManaged public var id: Int64
    @NSManaged public var name: String?
    @NSManaged public var products: NSOrderedSet?
    @NSManaged public var subCategories: NSSet?

}

// MARK: Generated accessors for products
extension Category {

    @objc(insertObject:inProductsAtIndex:)
    @NSManaged public func insertIntoProducts(_ value: Products, at idx: Int)

    @objc(removeObjectFromProductsAtIndex:)
    @NSManaged public func removeFromProducts(at idx: Int)

    @objc(insertProducts:atIndexes:)
    @NSManaged public func insertIntoProducts(_ values: [Products], at indexes: NSIndexSet)

    @objc(removeProductsAtIndexes:)
    @NSManaged public func removeFromProducts(at indexes: NSIndexSet)

    @objc(replaceObjectInProductsAtIndex:withObject:)
    @NSManaged public func replaceProducts(at idx: Int, with value: Products)

    @objc(replaceProductsAtIndexes:withProducts:)
    @NSManaged public func replaceProducts(at indexes: NSIndexSet, with values: [Products])

    @objc(addProductsObject:)
    @NSManaged public func addToProducts(_ value: Products)

    @objc(removeProductsObject:)
    @NSManaged public func removeFromProducts(_ value: Products)

    @objc(addProducts:)
    @NSManaged public func addToProducts(_ values: NSOrderedSet)

    @objc(removeProducts:)
    @NSManaged public func removeFromProducts(_ values: NSOrderedSet)

}

// MARK: Generated accessors for subCategories
extension Category {

    @objc(addSubCategoriesObject:)
    @NSManaged public func addToSubCategories(_ value: ChildCategory)

    @objc(removeSubCategoriesObject:)
    @NSManaged public func removeFromSubCategories(_ value: ChildCategory)

    @objc(addSubCategories:)
    @NSManaged public func addToSubCategories(_ values: NSSet)

    @objc(removeSubCategories:)
    @NSManaged public func removeFromSubCategories(_ values: NSSet)

}
