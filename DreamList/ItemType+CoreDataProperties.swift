//
//  ItemType+CoreDataProperties.swift
//  DreamList
//
//  Created by Saul Rivera on 7/16/17.
//  Copyright © 2017 Dymtech. All rights reserved.
//

import Foundation
import CoreData


extension ItemType {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ItemType> {
        return NSFetchRequest<ItemType>(entityName: "ItemType")
    }

    @NSManaged public var type: String?
    @NSManaged public var toItem: Item?

}
