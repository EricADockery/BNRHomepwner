//
//  CustomUITextFieldClass.swift
//  Homepwner
//
//  Created by Eric Dockery on 1/9/17.
//  Copyright © 2017 Eric Dockery. All rights reserved.
//

import UIKit

class CustomUITextFieldClass: UITextField {
    override func resignFirstResponder() -> Bool {
        super.resignFirstResponder()
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.blue.cgColor
        return true
    }
    override func becomeFirstResponder() -> Bool {
        super.becomeFirstResponder()
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.red.cgColor
        return true
    }
}
