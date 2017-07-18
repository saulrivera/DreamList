//
//  ItemDetailsVC.swift
//  DreamList
//
//  Created by Saul Rivera on 7/17/17.
//  Copyright © 2017 Dymtech. All rights reserved.
//

import UIKit
import CoreData

class ItemDetailsVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageItem: UIImageView!
    @IBOutlet weak var storePicker: UIPickerView!
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var priceField: UITextField!
    @IBOutlet weak var detailsField: UITextField!
    
    var stores = [Store]()
    var types = [ItemType]()
    var itemToEdit: Item?
    
    var imagePicker: UIImagePickerController!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let topItem = self.navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        }

        storePicker.delegate = self
        storePicker.dataSource = self
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
//        let store = Store(context: context)
//        store.name = "Best Buy"
//        
//        let store2 = Store(context: context)
//        store2.name = "Liverpool"
//        
//        let store3 = Store(context: context)
//        store3.name = "Tesla Dealership"
//        
//        let store4 = Store(context: context)
//        store4.name = "Target"
//        
//        let store5 = Store(context: context)
//        store5.name = "Amazon"
//        
//        let store6 = Store(context: context)
//        store6.name = "K Mart"
//        
//        let type = ItemType(context: context)
//        type.type = "Electronics"
//        
//        let type2 = ItemType(context: context)
//        type2.type = "Music"
//        
//        let type3 = ItemType(context: context)
//        type3.type = "Games"
//        
//        let type4 = ItemType(context: context)
//        type4.type = "Food"
//        
//        let type5 = ItemType(context: context)
//        type5.type = "Paints"
//        
//        let type6 = ItemType(context: context)
//        type6.type = "Forniture"
//
//        ad.saveContext()
        getStores()
        getTypes()
        
        if itemToEdit != nil {
            loadItemData()
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return stores[row].name
        } else {
            return types[row].type
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return stores.count
        } else {
            return types.count
        }
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func getStores() {
        let fetchRequest: NSFetchRequest<Store> = Store.fetchRequest()
        do {
            self.stores = try context.fetch(fetchRequest)
            self.storePicker.reloadAllComponents()
        } catch {
            let error = error as NSError
            print("\(error)")
        }
    }
    
    func getTypes() {
        let fetchRequest: NSFetchRequest<ItemType> = ItemType.fetchRequest()
        do {
            self.types = try context.fetch(fetchRequest)
            self.storePicker.reloadAllComponents()
        } catch {
            let error = error as NSError
            print("\(error)")
        }
    }
    
    @IBAction func savePressed(_ sender: UIButton) {
        var item: Item!
        
        if itemToEdit == nil {
            item = Item(context: context)
        } else {
            item = itemToEdit
        }
        
        let picture = Image(context: context)
        picture.image = imageItem.image
        item.toImage = picture
        
        if let title = titleField.text {
            item.title = title
        }
        if let price = priceField.text {
            item.price = (price as NSString).doubleValue
        }
        if let details = detailsField.text {
            item.details = details
        }
        item.toStore = stores[storePicker.selectedRow(inComponent: 0)]
        item.toItemType = types[storePicker.selectedRow(inComponent: 1)]
        ad.saveContext()
        navigationController?.popViewController(animated: true)
    }
    
    func loadItemData() {
        if let item = itemToEdit {
            titleField.text = item.title
            priceField.text = String(item.price)
            detailsField.text = item.details
            imageItem.image = item.toImage?.image as? UIImage
            
            if let store = item.toStore {
                var index = 0
                repeat {
                    let s = stores[index]
                    if s.name == store.name {
                        storePicker.selectRow(index, inComponent: 0, animated: false)
                        break
                    }
                    index += 1
                } while index < stores.count
            }
            
            if let type = item.toItemType {
                var index = 0
                repeat {
                    let t = types[index]
                    if t.type == type.type {
                        storePicker.selectRow(index, inComponent: 1, animated: false)
                        break
                    }
                    index += 1
                } while index < types.count
            }
        }
    }

    @IBAction func deletePressed(_ sender: UIBarButtonItem) {
        if itemToEdit != nil {
            context.delete(itemToEdit!)
        }
        ad.saveContext()
        navigationController?.popViewController(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let img = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageItem.image = img
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addImage(_ sender: UIButton) {
        present(imagePicker, animated: true, completion: nil)
    }
    
    
}
