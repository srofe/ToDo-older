//
//  InputViewController.swift
//  ToDo
//
//  Created by Simon Rofe on 2/12/17.
//  Copyright © 2017 Simon Rofe. All rights reserved.
//

import UIKit
import CoreLocation

class InputViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!

    var itemManager: ItemManager?
    lazy var geocoder = CLGeocoder()
    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func saveItem(_ sender: UIButton) {
        guard let title = titleTextField.text, title.count > 0 else { return }

        let timestamp = dateFormatter.date(from: dateTextField.text!) ?? nil
        let description = descriptionTextField.text
        let locationName = locationTextField.text ?? ""
        var location: Location?
        if let address = addressTextField.text, address.count > 0 {
            geocoder.geocodeAddressString(address) { [unowned self] (placeMarks, error) in
                let placeMark = placeMarks?.first
                location = Location(name: locationName, coordinate: placeMark?.location?.coordinate)
                let newItem = ToDoItem(title: title,
                                       description: description,
                                       timestamp: timestamp?.timeIntervalSince1970,
                                       location: location)
                self.itemManager?.add(item: newItem)
            }
        } else {
            let newItem = ToDoItem(title: title,
                                   description: description,
                                   timestamp: timestamp?.timeIntervalSince1970,
                                   location: location)
            self.itemManager?.add(item: newItem)
        }
    }

    @IBAction func cancel(_ sender: UIButton) {
    }
}
