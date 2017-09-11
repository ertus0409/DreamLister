//
//  Store+CoreDataProperties.swift
//  DreamLister
//
//  Created by Guner Babursah on 18/07/2017.
//  Copyright © 2017 Guner Babursah. All rights reserved.
//

import Foundation
import CoreData


extension Store {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Store> {
        return NSFetchRequest<Store>(entityName: "Store")
    }

    @NSManaged public var name: String?
    @NSManaged public var toImage: Image?
    @NSManaged public var toItem: Item?

}
