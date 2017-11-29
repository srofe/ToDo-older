//
//  DetailViewController.swift
//  ToDo
//
//  Created by Simon Rofe on 29/11/17.
//  Copyright © 2017 Simon Rofe. All rights reserved.
//

import UIKit
import MapKit

class DetailViewController: UIViewController {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var timestampLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var mapView: MKMapView!

    var itemInformation: (ItemManager, Int)?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        guard let itemInfo = itemInformation else { return }
        let selectedItem = itemInfo.0.item(at: itemInfo.1)

        titleLabel.text = selectedItem.title
    }
}
