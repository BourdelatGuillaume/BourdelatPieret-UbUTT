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
    var locCoord:CLLocationCoordinate2D!
    var user:Conducteur!
    var course:Course!
    var destinationLoc:CLLocationCoordinate2D!
    
    var eventRunnable: EventCourseRunnable?
    
    @IBOutlet weak var map: GMSMapView!
    var conducteurMarker: GMSMarker = GMSMarker()
    var passagerMarker: GMSMarker = GMSMarker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        map.isUserInteractionEnabled = false
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        conducteurMarker.title = "Conducteur"
        conducteurMarker.icon = UIImage(named: "local_taxi_black_24x24.png")
        conducteurMarker.map = map
        
        passagerMarker.title = "Passager"
        passagerMarker.icon = UIImage(named: "person_pin_circle_black_24x24.png")
        let tmpArray = course.getPoint_depart().split(separator: ",", maxSplits: 2)
        passagerMarker.position = CLLocationCoordinate2D(latitude: Double(tmpArray[0])!, longitude: Double(tmpArray[1])!)
        passagerMarker.map = map
        
        eventRunnable = EventCourseRunnable(user:user.getUtilisateur()!){ courseActive, error in
            if(error != ""){
                print(error)
            }else{
                switch(courseActive.getId_statut()){
                case 2: // conducteur en chemin
                    self.updateLocationForCourse(course: courseActive)
                    break;
                case 3: // course en cours
                    self.updateLocationForCourse(course: courseActive)
                    break;
                case 4: // en attente des notes (on le rajoute car le passager passe la course en statut et bloque le conducteur du coup)
                    let result:Double = HaversineCalculator.calculateDistance(p1: self.location.coordinate, p2: self.destinationLoc)
                    
                    if (result < 20) { // distance between conducteur and destination location is less than 20 meters
                        self.dismiss(animated:true)
                    }
                    break;
                default:
                    print("wrong id_statut")
                    break;
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let tmpArray = course.getPoint_arrivee().split(separator: ",", maxSplits: 2)
        destinationLoc = CLLocationCoordinate2D(latitude: Double(tmpArray[0])!, longitude: Double(tmpArray[1])!)
        updateConducteurMarker()
        
        locationManager.delegate = self
        if(CLLocationManager.authorizationStatus() == .authorizedWhenInUse || CLLocationManager.authorizationStatus() == .authorizedAlways){
            locationManager.startUpdatingLocation()
        }else{
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        locationManager.stopUpdatingLocation()
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
    
    func updateConducteurMarker(){
        conducteurMarker.position = location.coordinate
        updateCameraBetween2Points(origin: location.coordinate, destination: destinationLoc)
    }
    
    /* FIN MAP */
    
    /* -------------------------------------------------------------------------------------- */
    
    func updateLocationForCourse(course: Course){
        course.setPosition_conducteur(position_conducteur: String(locCoord.latitude)+","+String(locCoord.longitude))
        course.updatePosition_conducteur()
    }
    
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
            self.locCoord = loc.coordinate
            updateConducteurMarker()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("locationManagerError: \(error)")
    }
    
}
