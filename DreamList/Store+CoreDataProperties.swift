//
//  Store+CoreDataProperties.swift
//  DreamList
//
//  Created by Saul Rivera on 7/16/17.
//  Copyright © 2017 Dymtech. All rights reserved.
//

import Foundation
import CoreData


extension Store {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Store> {
        return NSFetchRequest<Store>(entityName: "Store")
    }

    @NSManaged public var name: String?
    @NSManaged public var toItem: Item?
    @NSManaged public var toImage: Image?

}
