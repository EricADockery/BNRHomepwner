//
//  ItemViewControllerTableViewExtension.swift
//  Homepwner
//
//  Created by Eric Dockery on 1/5/17.
//  Copyright © 2017 Eric Dockery. All rights reserved.
//
import UIKit

extension ItemsViewController {
    
    //MARK: Table ViewDelegate //MARK: TableView DataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemStore.allItems.count + 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
        cell.updateLabels()
        if indexPath.row == itemStore.allItems.count {
            cell.nameLabel?.text = "No More Items!"
            cell.serialNumberLabel?.text = ""
            cell.valueLabel?.text = ""
          
        }
        else {
            let item = itemStore.allItems[indexPath.row]
            //Chapter 11 Bronze challenge:
            if item.valueInDollars >= 50 {
                cell.updateBackgroundColor(colorCode: 0)
            } else {
                cell.updateBackgroundColor(colorCode: 1)
            }
            cell.nameLabel?.text = item.name
            cell.valueLabel?.text = "$\(item.valueInDollars)"
            cell.serialNumberLabel?.text = item.serialNumber
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if indexPath.row == itemStore.allItems.count {
            return nil
        }
        return indexPath
    }
    
    /*
    override func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        if indexPath.row == itemStore.allItems.count {
            return false
        }
        return true
    }
 */
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        itemStore.moveItemAtIndex(fromIndex: sourceIndexPath.row, toIndex: destinationIndexPath.row)
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let removeAction = UITableViewRowAction(style: UITableViewRowActionStyle.destructive, title: "Remove") { (action, indexPath) in
            let item = self.itemStore.allItems[indexPath.row]
            let title = "Delete \(item.name)"
            let message = "Are you sure you want to delete this item?"
            let deleteAlertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            deleteAlertController.addAction(cancelAction)
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: { (action) in
                self.itemStore.removeItem(item: item)
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
            })
            deleteAlertController.addAction(deleteAction)
            self.present(deleteAlertController, animated: true, completion: nil)
        }
        removeAction.backgroundColor = UIColor.orange
        return [removeAction]
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        if indexPath.row == itemStore.allItems.count {
            return .none
        }
        return .delete
    }
    
    //https://developer.apple.com/library/content/documentation/UserExperience/Conceptual/TableView_iPhone/ManageReorderRow/ManageReorderRow.html
    override func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
        if sourceIndexPath.row == itemStore.allItems.count || proposedDestinationIndexPath.row == itemStore.allItems.count {
            return sourceIndexPath
        }
        return proposedDestinationIndexPath
    }
    
}
