//
//  ViewController.swift
//  Grocery List
//
//  Created by Atte Huhtakangas on 16/11/2016.
//  Copyright © 2016 Atte Huhtakangas. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, TableViewCellDelegate {

    let prefKey = "groceryListItems"
    @IBOutlet var newItemField: UITextField!
    @IBOutlet var tableView: UITableView!

    var groceryItems: GroceryItems?

    @IBAction func addPressed(_ sender: UIButton) {
        if let text = newItemField.text {
            // clear input text
            self.newItemField.text = ""

            // get index where to append
            let section = 0
            let index = self.groceryItems!.countFor(index: section)
            // Add to data source
            self.groceryItems!.add(item: GroceryListItem(text: text), to: section)

            // insert into table
            let indexPathForRow = IndexPath(row: index, section: section)
            self.tableView.beginUpdates()
            self.tableView.insertRows(at: [indexPathForRow], with: .bottom)
            self.tableView.endUpdates()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        if self.groceryItems != nil {
            return
        }

        self.groceryItems = GroceryItems()
        self.tableView.isEditing = true

        // groceryItems.add(item: GroceryListItem(text: "bacon"), to: "undefined")
        // groceryItems.add(item: GroceryListItem(text: "eggs"), to: "undefined")
    }

    // MARK: - Tableview datasource

     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell

        let item = groceryItems!.getItem(list: indexPath.section, index: indexPath.row)
        cell.textLabel?.text = item.text
        cell.selectionStyle = .none
        cell.delegate = self
        cell.groceryListItem = item

        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return groceryItems!.listCount
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return groceryItems!.categoryNames[section];
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groceryItems!.countFor(index: section)
    }

    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .none
    }

    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }

    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let object = self.groceryItems!.remove(itemIndex: sourceIndexPath.row, from: sourceIndexPath.section)
        self.groceryItems!.insert(item: object!, list: destinationIndexPath.section, to: destinationIndexPath.row)
    }

    // MARK: TableViewCellDelegate methosd

    func groceryListItemDeleted(groceryListItem: GroceryListItem) {
        if let position = groceryItems!.remove(item: groceryListItem) {
            let indexPathForRow = IndexPath(row: position.index, section: position.section)
            self.tableView.beginUpdates()
            self.tableView.deleteRows(at: [indexPathForRow], with: UITableViewRowAnimation.fade)
            self.tableView.endUpdates()
        }
    }

    // MARK: state (re)storing

    override func encodeRestorableState(with coder: NSCoder) {
        print("viewCtrl, encode state")
        coder.encode(newItemField.text, forKey: "newItem")
        saveModel()
        super.encodeRestorableState(with: coder)
    }

    override func decodeRestorableState(with coder: NSCoder) {
        print("viewCtrl, decode state")
        newItemField.text = coder.decodeObject(forKey: "newItem") as? String
        self.groceryItems = loadModel() ?? GroceryItems()
        super.decodeRestorableState(with: coder)
    }

    func saveModel() {
        print("archiving")
        let defaultProps = UserDefaults.standard
        let data = NSKeyedArchiver.archivedData(withRootObject: groceryItems!)
        defaultProps.set(data, forKey: prefKey)
        defaultProps.synchronize()
    }

    func loadModel() -> GroceryItems? {
        print("restoring")
//        if self.groceryItems != nil {
//            print("returning current items")
//            return self.groceryItems
//        }
        let defaultProps = UserDefaults.standard

//        if let data: AnyObject? = defaultProps.object(forKey: prefKey) {
//            let model = [GroceryListItem] =
//        }
//        let data: NSData = defaultProps.object(forKey: prefKey) as! NSData
        if let data: NSData = defaultProps.object(forKey: prefKey) as? NSData {

//            let model: GroceryItems = try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as! GroceryItems
            var model: GroceryItems?
            do {
                try model = NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? GroceryItems
            } catch {
                print("error in trying to unarchive")
                return nil
            }
            print("returning model")
            return model ?? nil
//            if let model: GroceryItems = NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? GroceryItems {
//
//            }
//            return model
        }
        print("no data")
        return nil
    }
}
