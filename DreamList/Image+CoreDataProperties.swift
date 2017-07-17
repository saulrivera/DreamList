//
//  Image+CoreDataProperties.swift
//  DreamList
//
//  Created by Saul Rivera on 7/16/17.
//  Copyright © 2017 Dymtech. All rights reserved.
//

import Foundation
import CoreData


extension Image {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Image> {
        return NSFetchRequest<Image>(entityName: "Image")
    }

    @NSManaged public var image: NSObject?
    @NSManaged public var toItem: Item?
    @NSManaged public var toStore: Store?

}
