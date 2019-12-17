//
//  ConducteurActivityController.swift
//  UbUTT
//
//  Created by if26-grp3 on 17/12/2019.
//  Copyright © 2019 BourdelatPieret. All rights reserved.
//

import UIKit
import GoogleMaps

class ConducteurActivityController: UIViewController {

    private let locationManager = CLLocationManager()
    public static let segueIdentifier: String = "segueBetweenWorkAndConducteurCourse"
    
    var location:CLLocation!
    var user:Conducteur!
    var course:Course!
    
    @IBOutlet weak var map: GMSMapView!
    var conducteurMarker: GMSMarker = GMSMarker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        map.isUserInteractionEnabled = false
        
        conducteurMarker.title = "Conducteur"
        conducteurMarker.icon = UIImage(named: "local_taxi_black_24x24.png")
        conducteurMarker.map = map
        
        let tmpArray = course.getPoint_arrivee().split(separator: ",", maxSplits: 2)
        let destination = CLLocationCoordinate2D(latitude: Double(tmpArray[0])!, longitude: Double(tmpArray[1])!)
        updateConducteurMarker(destinationLoc: destination)
    }

    /* -------------------------------------------------------------------------------------- */
    
    /* GESTION MAP */
    
    func updateCameraBetween2Points(origin: CLLocationCoordinate2D, destination: CLLocationCoordinate2D){
        // centrer la caméra entre le début et la fin du trajet
        var zoomToUse = Constants.DISTRICT_ZOOM;
        if(abs(origin.latitude-destination.latitude) > 0.001 || abs(origin.longitude-destination.longitude) > 0.0005){
            zoomToUse = Constants.DEFAULT_ZOOM;
        }else if(abs(origin.latitude-destination.latitude) > 0.01 || abs(origin.longitude-destination.longitude) > 0.005){
            zoomToUse = Constants.TOWN_ZOOM;
        }
        map.animate(to: GMSCameraPosition.camera(withLatitude: abs(origin.latitude+destination.latitude)/2, longitude: abs(origin.longitude+destination.longitude)/2, zoom: zoomToUse))
    }
    
    func updateConducteurMarker(destinationLoc: CLLocationCoordinate2D){
        conducteurMarker.position = location.coordinate
        updateCameraBetween2Points(origin: location.coordinate, destination: destinationLoc)
    }
    
    /* FIN MAP */
    
    /* -------------------------------------------------------------------------------------- */
    
}
/* LOCATION MANAGER */
extension ConducteurActivityController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways:
            // unused in this app
            print("user allow app to get location data when app is active or in background")
        case .authorizedWhenInUse:
            self.locationManager.startUpdatingLocation()
            print("user allow app to get location data only when app is active")
        case .denied:
            print("user tap 'disallow' on the permission dialog, cant get location data")
        case .restricted:
            print("parental control setting disallow location data")
        case .notDetermined:
            print("the location permission dialog haven't shown before, user haven't tap allow/disallow")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // .requestLocation will only pass one location to the locations array hence we can access it by taking the first element of the array
        if let loc = locations.first {
            self.location = loc
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("locationManagerError: \(error)")
    }
    
}