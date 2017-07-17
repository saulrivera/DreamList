//
//  Item+CoreDataClass.swift
//  DreamList
//
//  Created by Saul Rivera on 7/16/17.
//  Copyright © 2017 Dymtech. All rights reserved.
//

import Foundation
import CoreData


public class Item: NSManagedObject {
    
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        self.created = NSDate()
    }
    

}
