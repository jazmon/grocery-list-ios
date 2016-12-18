//
//  ViewController.swift
//  Grocery List
//
//  Created by Atte Huhtakangas on 16/11/2016.
//  Copyright © 2016 Atte Huhtakangas. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, TableViewCellDelegate {

    @IBOutlet var newItemField: UITextField!
    @IBOutlet var tableView: UITableView!

//    struct Category {
//        var items: [Grocery]
//        var name: String
//    }
//    var groceryItems: GroceryItems?
//    var categories = [String]()
//    var groceries = [Grocery]()
    var categories = [GroceryCategory]()

    override func viewDidLoad() {
        super.viewDidLoad()

//        if let savedGroceries = loadGroceries() {
//            groceries += savedGroceries;
//        } else {
//            groceries += loadSampleGroceries();
//        }
        if let savedCategories = loadCategories() {
            print("found saved categories")
            categories += savedCategories
        } else {
            print("no ssaved vategories foudn")
            categories += loadSampleCategories()
        }

        self.tableView.isEditing = true
    }

    func loadSampleCategories() -> [GroceryCategory] {
        print("load sample categoreis")
        var categories = [GroceryCategory]()

        let uncategorized: GroceryCategory = GroceryCategory(name: "Uncategorized")!
        let lettuce: Grocery = Grocery(name: "Lettuce", price: 0, amount: 1)!
        uncategorized.items.append(lettuce)
        categories.append(uncategorized)

        let meats: GroceryCategory = GroceryCategory(name: "Meats")!
        let bacon: Grocery = Grocery(name: "Bacon", price: 0, amount: 1)!
        meats.items.append(bacon)

        categories.append(meats)
        return categories
    }

    @IBAction func addPressed(_ sender: UIButton) {
        if let text = newItemField.text {
            // clear input text
            self.newItemField.text = ""

            // get index where to append
            let section = 0
            let index = self.categories[section].items.count
            // Add to data source
            if let item = Grocery(name: text, price: 0, amount: 1) {
                self.categories[section].items.append(item)

                // insert into table
                let indexPathForRow = IndexPath(row: index, section: section)
                self.tableView.beginUpdates()
                self.tableView.insertRows(at: [indexPathForRow], with: .bottom)
                self.tableView.endUpdates()
            }

        }
    }

    // MARK: - Tableview datasource

     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell

        let item = categories[indexPath.section].items[indexPath.row]
        cell.textLabel?.text = item.name
        cell.selectionStyle = .none
        cell.delegate = self
        cell.grocery = item
        cell.category = indexPath.section
        cell.row = indexPath.row

        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return categories.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return categories[section].name
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories[section].items.count
    }

    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .none
    }

    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }

    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let item = self.categories[sourceIndexPath.section].items.remove(at: sourceIndexPath.row)
        categories[destinationIndexPath.section].items.insert(item, at: destinationIndexPath.row)
    }

    // MARK: TableViewCellDelegate methods

    func groceryDeleted(grocery: Grocery, section: Int, row: Int) {
//        if let position
//        if let item = self.categories.
        print("grocery deleted")

        categories[section].items.remove(at: row)

        let indexPathForRow = IndexPath(row: row, section: section)
        self.tableView.beginUpdates()
        self.tableView.deleteRows(at: [indexPathForRow], with: UITableViewRowAnimation.fade)
        self.tableView.endUpdates()
    }

    // MARK: NSCoding

    func saveCategories() {
        let isSaveSuccessful = NSKeyedArchiver.archiveRootObject(categories, toFile: GroceryCategory.archiveURL.path)

        if !isSaveSuccessful {
            print("Failed to save groceries...")
        }
    }

    func loadCategories() -> [GroceryCategory]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: GroceryCategory.archiveURL.path) as? [GroceryCategory]
    }


    // MARK: state (re)storing

    override func encodeRestorableState(with coder: NSCoder) {
        print("viewCtrl, encode state")
        coder.encode(newItemField.text, forKey: "newItem")
        saveCategories()
        super.encodeRestorableState(with: coder)
    }

    override func decodeRestorableState(with coder: NSCoder) {
        print("viewCtrl, decode state")
        newItemField.text = coder.decodeObject(forKey: "newItem") as? String
//        self.groceryItems = loadModel() ?? GroceryItems()
//        if let categories = loadCategories() {
//            print("found categories")
//            self.categories = categories
//        }
        super.decodeRestorableState(with: coder)
    }
}
