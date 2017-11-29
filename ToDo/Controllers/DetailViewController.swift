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

}
