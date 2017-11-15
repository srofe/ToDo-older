//
//  Location.swift
//  ToDo
//
//  Created by Simon Rofe on 15/11/17.
//  Copyright © 2017 Simon Rofe. All rights reserved.
//

import Foundation
import CoreLocation

struct Location {
    let name: String
    let coordinate: CLLocationCoordinate2D?

    init(name: String, coordinate: CLLocationCoordinate2D? = nil) {
        self.name = name
        self.coordinate = coordinate
    }
}
