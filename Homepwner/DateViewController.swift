//
//  DateViewController.Swift
//  Homepwner
//
//  Created by Eric Dockery on 1/10/17.
//  Copyright © 2017 Eric Dockery. All rights reserved.
//

import UIKit

class DateViewController: UIViewController {
    @IBOutlet var updateItemDatePicker: UIDatePicker!
    var item: Item!
    override func viewDidLoad() {
        super.viewDidLoad()
        updateItemDatePicker.minimumDate = item.dateCreated as Date
    }
   
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        item.dateCreated = updateItemDatePicker.date as NSDate
    }
}
