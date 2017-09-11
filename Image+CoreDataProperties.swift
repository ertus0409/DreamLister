//
//  Image+CoreDataProperties.swift
//  DreamLister
//
//  Created by Guner Babursah on 18/07/2017.
//  Copyright © 2017 Guner Babursah. All rights reserved.
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
