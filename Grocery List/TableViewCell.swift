//
//  TableViewCell.swift
//  Grocery List
//
//  Created by Atte Huhtakangas on 19/11/2016.
//  Copyright © 2016 Atte Huhtakangas. All rights reserved.
//

import UIKit
import Foundation

// A protocol that the TableViewCell uses to inform its delegate of state change
protocol TableViewCellDelegate {
    // indicates that the given item has been deleted
    func groceryDeleted(grocery: Grocery, section: Int, row: Int)
}

class TableViewCell: UITableViewCell {

    var originalCenter: CGPoint = CGPoint()
    var deleteOnDragRelease: Bool = false
    var delegate: TableViewCellDelegate?
    var grocery: Grocery?
    var row: Int?
    var category: Int?
//    var groceryListItem: GroceryListItem?

    override func awakeFromNib() {
        super.awakeFromNib()

        let recognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan(recognizer:)))
        recognizer.delegate = self
        addGestureRecognizer(recognizer)
    }

//    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        self.groceryListItem = aDecoder.decodeObject(forKey: "groceryListItem") as? GroceryListItem
//        super.init(coder: aDecoder)
//        //fatalError("init(coder:) has not been implemented")
//    }
//
//    override func decodeRestorableState(with coder: NSCoder) {
//        coder.encode(self.groceryListItem, forKey: "groceryListItem")
//    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//        // Configure the view for the selected state
//    }

    // MARK - gesture handler methods

    func handlePan(recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            // when the gesture begins, record the current center location
            originalCenter = center
            break
        case .changed:
            let translation = recognizer.translation(in: self)
            center = CGPoint(x: originalCenter.x + translation.x, y: originalCenter.y)
            // has the user dragged the item far enough to initiate a delete/complete?

            deleteOnDragRelease = frame.origin.x < -frame.size.width / 2.0 || frame.origin.x > frame.size.width / 2.0
            break
        case .ended:
            // the frame this cell had before user dragged it
            let originalFrame = CGRect(x: 0, y: frame.origin.y,
                                       width: bounds.size.width, height: bounds.size.height)
            if !deleteOnDragRelease {
                // if the item is not being deleted, snap back to the original location
                UIView.animate(withDuration: 0.2, animations: {self.frame = originalFrame})
            } else if delegate != nil && grocery != nil {
                delegate!.groceryDeleted(grocery: grocery!, section: category!, row: row!)
            }
            break
        default:
            break
        }
    }

    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if let panGestureRecognizer = gestureRecognizer as? UIPanGestureRecognizer {
            let translation = panGestureRecognizer.translation(in: superview!)
            if fabs(translation.x) > fabs(translation.y) {
                return true
            }
            return false
        }
        return false
    }

}
