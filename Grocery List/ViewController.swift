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

    var groceryListItems: [GroceryListItem] = []

    @IBAction func addPressed(_ sender: UIButton) {
        if let text = newItemField.text {

            // self.groceryListItems.append(GroceryListItem(text: text))
            self.newItemField.text = ""
            let index = self.groceryListItems.count
            self.groceryListItems.insert(GroceryListItem(text: text), at: index)
            let indexPathForRow = IndexPath(row: index, section: 0)
            self.tableView.beginUpdates()
            self.tableView.insertRows(at: [indexPathForRow], with: .automatic)
            self.tableView.endUpdates()
        }


    }
    override func viewDidLoad() {
        super.viewDidLoad()


        // tableView.backgroundColor = UIColor.black

        if groceryListItems.count > 0 {
            return
        }

        groceryListItems.append(GroceryListItem(text: "bacon"))
        groceryListItems.append(GroceryListItem(text: "eggs"))
    }

    // MARK: - Tableview datasource

     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell

        // let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        let item = groceryListItems[indexPath.row]
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
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groceryListItems.count
    }

    // MARK: TableViewCellDelegate methosd

    func groceryListItemDeleted(groceryListItem: GroceryListItem) {
        print("groverylistitemdeleted")

        if let index = groceryListItems.index(where: {$0.text == groceryListItem.text}) {
            groceryListItems.remove(at: index)

            self.tableView.beginUpdates()
            let indexPathForRow = IndexPath(row: index, section: 0)
            self.tableView.deleteRows(at: [indexPathForRow], with: UITableViewRowAnimation.fade)
            tableView.endUpdates()
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
        self.groceryListItems = loadModel() ?? []
        super.decodeRestorableState(with: coder)
    }

    func saveModel() {
        print("archiving")
        let defaultProps = UserDefaults.standard
        let data = NSKeyedArchiver.archivedData(withRootObject: groceryListItems)
        defaultProps.set(data, forKey: prefKey)
        defaultProps.synchronize()
    }

    func loadModel() -> [GroceryListItem]? {
        print("restoring")
        let defaultProps = UserDefaults.standard

//        if let data: AnyObject? = defaultProps.object(forKey: prefKey) {
//            let model = [GroceryListItem] =
//        }
//        let data: NSData = defaultProps.object(forKey: prefKey) as! NSData
        if let data: NSData = defaultProps.object(forKey: prefKey) as? NSData {

            let model: [GroceryListItem] = try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as! [GroceryListItem]

            return model
        }
        return nil
    }
}
