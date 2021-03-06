//
//  DetailViewController.swift
//  Homepwner
//
//  Created by Eric Dockery on 1/6/17.
//  Copyright © 2017 Eric Dockery. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var nameTextField: CustomUITextFieldClass!
    @IBOutlet weak var serialTextField: CustomUITextFieldClass!
    @IBOutlet weak var valueTextField: CustomUITextFieldClass!
    @IBOutlet var dateButton: UIButton!
    @IBOutlet var itemImageView: UIImageView!
    
    var item: Item! {
        didSet {
            navigationItem.title = item.name
        }
    }
    var imageStore: ImageStore!
    
    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        nameTextField.text = item.name
        valueTextField.text = numberFormatter.string(from: item.valueInDollars as NSNumber)
        dateButton.setTitle(dateFormatter.string(from: item.dateCreated as Date), for: .normal)
        serialTextField.text = item.serialNumber
        let key = item.itemKey
        let imageToDisplay = imageStore.imageForKey(key: key)
        itemImageView.image = imageToDisplay
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        view.endEditing(true)
        item.name = nameTextField.text ?? ""
        item.serialNumber = serialTextField.text ?? ""
        if let valueText = valueTextField.text, let value = numberFormatter.number(from: valueText) {
            item.valueInDollars = value.intValue
        }
        else {
            item.valueInDollars = 0
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ChangeDate" {
            let dateViewController = segue.destination as! DateViewController
            dateViewController.item = item
        }
    }
    
    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    @IBAction func removePicture(_ sender: Any) {
        if itemImageView.image != nil {
            itemImageView.image = nil
            imageStore.deleteImageForKey(key: item.itemKey)
        }
    }
    

}

extension DetailViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerEditedImage] as! UIImage
        imageStore.setImage(image: image, forKey: item.itemKey)
        itemImageView.image = image
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func takePicture(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let crosshair = UIButton(type: .contactAdd)
            crosshair.tintColor = UIColor.white
            crosshair.translatesAutoresizingMaskIntoConstraints = false
            imagePicker.cameraOverlayView?.addSubview(crosshair)
            imagePicker.cameraOverlayView?.isUserInteractionEnabled = false
            crosshair.centerXAnchor.constraint(equalTo: (imagePicker.cameraOverlayView?.centerXAnchor)!).isActive = true
            crosshair.centerYAnchor.constraint(equalTo: (imagePicker.cameraOverlayView?.centerYAnchor)!).isActive = true
            imagePicker.sourceType = .camera
        }
        else {
            imagePicker.sourceType = .photoLibrary
        }
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
        
    }

}

extension DetailViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
