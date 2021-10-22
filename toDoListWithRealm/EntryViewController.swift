//
//  EntryViewController.swift
//  toDoListWithRealm
//
//  Created by Murat Menzilci on 20.10.2021.
//

import RealmSwift
import UIKit

class EntryViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    private let realm = try! Realm()
    public var completionHandler: (() -> Void)?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.becomeFirstResponder()
        textField.delegate = self
        
        datePicker.setDate(Date(), animated: true)
        
        //Add Navigation Save Item
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(TapSaveButton))
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc func TapSaveButton() {
        if let text =  textField.text, !text.isEmpty {
            let date = datePicker.date
            realm.beginWrite()
            
            let newItem = ToDoListItem()
            newItem.date = date
            newItem.item = text
            realm.add(newItem)
            
            try! realm.commitWrite()
            completionHandler?()
        } else {
            print("Add something")
        }
    }

}
