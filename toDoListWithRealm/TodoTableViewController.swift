//
//  TodoTableViewController.swift
//  toDoListWithRealm
//
//  Created by Murat Menzilci on 20.10.2021.
//

import RealmSwift
import UIKit

class ToDoListItem: Object {
    @objc dynamic var item : String = ""
    @objc dynamic var date : Date = Date()
}

class TodoTableViewController: UITableViewController {
   
    private let realm = try! Realm()
    private var data = [ToDoListItem]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        data = realm.objects(ToDoListItem.self).map( { $0 })

    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row].item
        return cell
    }
    
    @IBAction func tapAddButton(_ sender: Any) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "enter") as? EntryViewController else {
            return
        }
        vc.completionHandler = { [weak self] in
            self?.refresh()
        }
        
    }
    
    func refresh() {
        data = realm.objects(ToDoListItem.self).map( { $0 })
        tableView.reloadData()
    }
}
