//
//  PlacesTableViewController.swift
//  NearMe
//
//  Created by Shivam Maheshwari on 26/06/23.
//

import Foundation
import UIKit
import MapKit

class PlacesTableViewController: UITableViewController {
    
    private var userLocation: CLLocation
    private var places: [PlaceAnnotation]
    
    private var indexForSelectedRow: Int? {
        self.places.firstIndex(where: { $0.isSelected == true })
    }
    
    init(userLocation: CLLocation, places: [PlaceAnnotation]) {
        self.userLocation = userLocation
        self.places = places
        super.init(nibName: nil, bundle: nil)
        
        //register tableView
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "PlaceCell")
        self.places.swapAt(indexForSelectedRow ?? 0, 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return places.count
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlaceCell", for: indexPath)
        let place = places[indexPath.row]
        
        //cell configuration
        var context = cell.defaultContentConfiguration()
        context.text = place.name
        context.secondaryText = formatDistanceForDisplay(calculateDistance(from: userLocation,
                                                                           to: place.location))
        
        cell.contentConfiguration = context
        cell.backgroundColor = place.isSelected == true ? UIColor.lightGray : UIColor.clear
        return cell
    }
    
    override func tableView(_ tableView: UITableView,
                            didSelectRowAt indexPath: IndexPath) {
        let place = self.places[indexPath.row]
        let placeDetailVC = PlaceDetailViewController(place: place)
        present(placeDetailVC, animated: true)
    }
}

private extension PlacesTableViewController {
    func calculateDistance(from: CLLocation,
                           to: CLLocation) -> CLLocationDistance {
        from.distance(from: to)
    }
    
    func formatDistanceForDisplay(_ distance: CLLocationDistance) -> String {
        let meters = Measurement(value: distance, unit: UnitLength.meters)
        return meters.converted(to: .miles).formatted()
    }
}
