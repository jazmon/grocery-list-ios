//
//  ViewController.swift
//  Grocery List
//
//  Created by Atte Huhtakangas on 16/11/2016.
//  Copyright © 2016 Atte Huhtakangas. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, TableViewCellDelegate {

    @IBOutlet var tableView: UITableView!

    var groceryListItems: [GroceryListItem] = []

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

    // MARK: - TableViewCellDelegate methosd

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
}
