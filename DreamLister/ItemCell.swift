//
//  ItemCell.swift
//  DreamLister
//
//  Created by Guner Babursah on 18/07/2017.
//  Copyright © 2017 Guner Babursah. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {

    @IBOutlet weak var details: UILabel!
    @IBOutlet weak var thumb: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var storeLbl: UILabel!
    @IBOutlet weak var itemTypeLbl: UILabel!
    
    func configureCell(item: Item) {
        
        details.text = item.details
        title.text = item.title
        price.text = "$\(item.price)"
        thumb.image = item.toImage?.image as? UIImage
        storeLbl.text = item.toStore?.name
        itemTypeLbl.text = item.toItemType?.type
    }

}
