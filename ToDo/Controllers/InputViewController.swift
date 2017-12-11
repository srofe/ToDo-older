//
//  InputViewController.swift
//  ToDo
//
//  Created by Simon Rofe on 2/12/17.
//  Copyright © 2017 Simon Rofe. All rights reserved.
//

import UIKit

class InputViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func saveItem(_ sender: UIButton) {
    }

    @IBAction func cancel(_ sender: UIButton) {
    }
}
