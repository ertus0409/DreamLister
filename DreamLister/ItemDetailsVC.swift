//
//  ItemDetailsVCViewController.swift
//  DreamLister
//
//  Created by Guner Babursah on 19/07/2017.
//  Copyright © 2017 Guner Babursah. All rights reserved.
//

import UIKit
import CoreData

class ItemDetailsVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var stores = [Store]()
    var type = [ItemType]()
    
    @IBOutlet weak var titlewField: CustomTextField!
    @IBOutlet weak var priceField: CustomTextField!
    @IBOutlet weak var detailsField: CustomTextField!
    @IBOutlet weak var storePicker: UIPickerView!
    @IBOutlet weak var typePicker: UIPickerView!
    @IBOutlet weak var thumbImage: UIImageView!
    @IBOutlet weak var selectStoreBtn: UIButton!
    @IBOutlet weak var selectItemTypePressed: UIButton!
    
    
    var itemToEdit: Item?
    var imagePicekr: UIImagePickerController!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        typePicker.isHidden = true
        storePicker.isHidden = true
        
        if let topItem = self.navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        }
        
        storePicker.dataSource = self
        storePicker.delegate = self
        typePicker.dataSource = self
        typePicker.delegate = self
        imagePicekr = UIImagePickerController()
        imagePicekr.delegate = self
        
//        storeTestData()
//        typeTestData()
        getTypes()
        getStores()
        
        if itemToEdit != nil {
            loadItemData()
        }

    }
    
    
//                  PICKERVIEW FUNCTIONS
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 0 {
            let store = stores[row]
            return store.name
        } else {
            let typ = type[row]
            return typ.type
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 0{
        return stores.count
        }
        else {
            return type.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 0 {
            storePicker.isHidden = true
        } else {
            typePicker.isHidden = true
        }
        
    }
//                  GET TYPES
    func getTypes(){
        let fetchRequest: NSFetchRequest<ItemType> = ItemType.fetchRequest()
        do {
            self.type = try context.fetch(fetchRequest)
            self.typePicker.reloadAllComponents()
        }catch {
            //handle error
        }
    }
    
//                  GET STORES
    func getStores() {
        let fetchRequest: NSFetchRequest<Store> = Store.fetchRequest()
        
        do {
            self.stores = try context.fetch(fetchRequest)
            self.storePicker.reloadAllComponents()
        }catch {
          //  handle the error
        }
    }
    
//              LOADING DATA TO THE NEXT PAGE
    func loadItemData() {
        
        if let item = itemToEdit {
            titlewField.text = item.title
            priceField.text = "\(item.price)"
            detailsField.text = item.details
            
            thumbImage.image = item.toImage?.image as? UIImage
            if let store = item.toStore {
                
                var index = 0
                repeat {
                    let s = stores[index]
                    if s.name == store.name {
                        storePicker.selectRow(index, inComponent: 0, animated: false)
                        break
                    }
                    index+=1
                }while (index < stores.count)
            }
            if let typ = item.toItemType {
                var inde = 0
                repeat {
                    let t = type[inde]
                    if t.type == typ.type {
                        typePicker.selectRow(inde, inComponent: 0, animated: false)
                        break
                    }
                    inde+=1
                }while (inde < type.count)
            }
        }
    }
    
    
    @IBAction func savePressed(_ sender: UIButton) {
        
//        let item = Item(context: context)
        var item: Item!
        let picture = Image(context: context)
        picture.image = thumbImage.image
        
        if itemToEdit == nil {
            item = Item(context: context)
        }else {
            item = itemToEdit
        }
        
        item.toImage = picture
        
        if let title = titlewField.text {
            item.title = title
        }
        if let price = priceField.text {
            item.price = (price as NSString).doubleValue
        }
        if let details = detailsField.text {
            item.details = details
        }
        
        item.toStore = stores[storePicker.selectedRow(inComponent: 0)]
        
        item.toItemType = type[typePicker.selectedRow(inComponent: 0)]
        
        ad.saveContext()
        
        navigationController?.popViewController(animated: true)

        
    }
//                  TYPE TEST DATA
    func typeTestData() {
        
        let type1 = ItemType(context: context)
        type1.type = "Electronics"
        
        let type2 = ItemType(context: context)
        type2.type = "Cars"
        
        let type3 = ItemType(context: context)
        type3.type = "BullShit"
        
    }
    
//                  STORE TEST DATA
    func storeTestData() {
        
        let store1 = Store(context: context)
        store1.name = "Best Buy"
        
        let store2 = Store(context: context)
        store2.name = "tepretOğulları Otomotiv"
        
        let store3 = Store(context: context)
        store3.name = "Fly Tech"
        
        let store4 = Store(context: context)
        store4.name = "Amazon"
        
        let store5 = Store(context: context)
        store5.name = "Applw Store"
        
        let store6 = Store(context: context)
        store6.name = "Ikea"
        
        let store7 = Store(context: context)
        store7.name = "Tekel Bayi"
        
        ad.saveContext()
    }
    
//                  DELETING ITEM
    
    @IBAction func deleteItemPressed(_ sender: UIBarButtonItem) {
        
        if itemToEdit != nil {
            context.delete(itemToEdit!)
            ad.saveContext()
        }
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addImage(_ sender: UIButton) {
        present(imagePicekr, animated: true, completion: nil)
    }
    
    
//                  IMAGE PICKING
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let img = info[UIImagePickerControllerOriginalImage] as? UIImage {
            thumbImage.image = img
        }
        imagePicekr.dismiss(animated: true, completion: nil)
    }
    
//                  SELECTING ITEMS ACTION
    
    @IBAction func selectStorePressed(_ sender: UIButton) {
        storePicker.isHidden = false
    }
    
    @IBAction func selectItemTypePressed(_ sender: UIButton) {
        typePicker.isHidden = false
    }
    
    
    
    
    
    

}
