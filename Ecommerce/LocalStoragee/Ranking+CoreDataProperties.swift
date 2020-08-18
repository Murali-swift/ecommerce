//
//  Ranking+CoreDataProperties.swift
//  Ecommerce
//
//  Created by Murali on 18/08/20.
//  Copyright © 2020 Murali. All rights reserved.
//
//

import Foundation
import CoreData


extension Ranking {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Ranking> {
        return NSFetchRequest<Ranking>(entityName: "Ranking")
    }

    @NSManaged public var ranking: String?
    @NSManaged public var orderType: NSSet?
    @NSManaged public var viewType: NSSet?
    @NSManaged public var shareType: NSSet?

}

// MARK: Generated accessors for orderType
extension Ranking {

    @objc(addOrderTypeObject:)
    @NSManaged public func addToOrderType(_ value: ProductsOrderType)

    @objc(removeOrderTypeObject:)
    @NSManaged public func removeFromOrderType(_ value: ProductsOrderType)

    @objc(addOrderType:)
    @NSManaged public func addToOrderType(_ values: NSSet)

    @objc(removeOrderType:)
    @NSManaged public func removeFromOrderType(_ values: NSSet)

}

// MARK: Generated accessors for viewType
extension Ranking {

    @objc(addViewTypeObject:)
    @NSManaged public func addToViewType(_ value: ProductsViewType)

    @objc(removeViewTypeObject:)
    @NSManaged public func removeFromViewType(_ value: ProductsViewType)

    @objc(addViewType:)
    @NSManaged public func addToViewType(_ values: NSSet)

    @objc(removeViewType:)
    @NSManaged public func removeFromViewType(_ values: NSSet)

}

// MARK: Generated accessors for shareType
extension Ranking {

    @objc(addShareTypeObject:)
    @NSManaged public func addToShareType(_ value: ProductsShareType)

    @objc(removeShareTypeObject:)
    @NSManaged public func removeFromShareType(_ value: ProductsShareType)

    @objc(addShareType:)
    @NSManaged public func addToShareType(_ values: NSSet)

    @objc(removeShareType:)
    @NSManaged public func removeFromShareType(_ values: NSSet)

}
