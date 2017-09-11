//
//  Item+CoreDataClass.swift
//  DreamLister
//
//  Created by Guner Babursah on 18/07/2017.
//  Copyright © 2017 Guner Babursah. All rights reserved.
//

import Foundation
import CoreData


public class Item: NSManagedObject {
    
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        
        self.created = NSDate()
    }

}
