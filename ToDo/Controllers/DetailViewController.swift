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
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var mapView: MKMapView!

    var itemInformation: (ItemManager, Int)?
    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter
    }()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        guard let itemInfo = itemInformation else { return }
        let selectedItem = itemInfo.0.item(at: itemInfo.1)

        titleLabel.text = selectedItem.title
        locationLabel.text = selectedItem.location?.name
        descriptionLabel.text = selectedItem.description

        if let timestamp = selectedItem.timestamp {
            let date = Date(timeIntervalSince1970: timestamp)
            dateLabel.text = dateFormatter.string(from: date)
        }
    }
}
