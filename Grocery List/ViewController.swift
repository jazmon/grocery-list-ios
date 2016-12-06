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

    //var groceryListItems: [GroceryListItem] = []
    var groceryItems: GroceryItems!

    @IBAction func addPressed(_ sender: UIButton) {
        if let text = newItemField.text {
            // clear input text
            self.newItemField.text = ""

            // get index where to append
            let section = 0
            let index = self.groceryItems.countFor(index: section)
            // Add to data source
            self.groceryItems.add(item: GroceryListItem(text: text), to: section)

            // insert into table
            let indexPathForRow = IndexPath(row: index, section: section)
            self.tableView.beginUpdates()
            self.tableView.insertRows(at: [indexPathForRow], with: .bottom)
            self.tableView.endUpdates()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()


        // tableView.backgroundColor = UIColor.black

//        if groceryItems.count > 0 {
//            return
//        }

        self.groceryItems = GroceryItems()

        // groceryItems.add(item: GroceryListItem(text: "bacon"), to: "undefined")
        // groceryItems.add(item: GroceryListItem(text: "eggs"), to: "undefined")
    }

    // MARK: - Tableview datasource



     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell

        // let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")

        let item = groceryItems.getItem(list: indexPath.section, index: indexPath.row)
        cell.textLabel?.text = item.text
        cell.selectionStyle = .none
        // cell.delegat = self
        cell.delegate = self
        cell.groceryListItem = item
        return cell
        /*let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "foo")
        return cell*/
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return groceryItems.listCount
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return groceryItems.categoryNames[section];
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groceryItems.countFor(index: section)
    }

    // MARK: TableViewCellDelegate methosd

    func groceryListItemDeleted(groceryListItem: GroceryListItem) {
        print("groverylistitemdeleted")

        if let position = groceryItems.remove(item: groceryListItem) {
            print("pos")

            let indexPathForRow = IndexPath(row: position.index, section: position.section)
            self.tableView.beginUpdates()
            self.tableView.deleteRows(at: [indexPathForRow], with: UITableViewRowAnimation.fade)
            self.tableView.endUpdates()
        }

//        if let index = groceryItems.index(where: {$0.text == groceryListItem.text}) {
//            groceryListItems.remove(at: index)
//
//            self.tableView.beginUpdates()
//            let indexPathForRow = IndexPath(row: index, section: 0)
//            self.tableView.deleteRows(at: [indexPathForRow], with: UITableViewRowAnimation.fade)
//            tableView.endUpdates()
//        }

    }

    // MARK: state (re)storing

//    override func encodeRestorableState(with coder: NSCoder) {
//        print("viewCtrl, encode state")
//        coder.encode(newItemField.text, forKey: "newItem")
//        saveModel()
//        super.encodeRestorableState(with: coder)
//    }
//
//    override func decodeRestorableState(with coder: NSCoder) {
//        print("viewCtrl, decode state")
//        newItemField.text = coder.decodeObject(forKey: "newItem") as? String
//        self.groceryItems = loadModel() ?? GroceryItems()
//        super.decodeRestorableState(with: coder)
//    }
//
//    func saveModel() {
//        print("archiving")
//        let defaultProps = UserDefaults.standard
//        let data = NSKeyedArchiver.archivedData(withRootObject: groceryItems)
//        defaultProps.set(data, forKey: prefKey)
//        defaultProps.synchronize()
//    }
//
//    func loadModel() -> GroceryItems? {
//        print("restoring")
//        let defaultProps = UserDefaults.standard
//
////        if let data: AnyObject? = defaultProps.object(forKey: prefKey) {
////            let model = [GroceryListItem] =
////        }
////        let data: NSData = defaultProps.object(forKey: prefKey) as! NSData
//        if let data: NSData = defaultProps.object(forKey: prefKey) as? NSData {
//
//            let model: GroceryItems = try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as! GroceryItems
//
//            return model
//        }
//        return nil
//    }
}
