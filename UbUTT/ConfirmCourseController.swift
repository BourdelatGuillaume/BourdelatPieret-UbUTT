//
//  ConfirmCourseController.swift
//  UbUTT
//
//  Created by if26-grp3 on 10/12/2019.
//  Copyright © 2019 BourdelatPieret. All rights reserved.
//

import UIKit
import GoogleMaps

class ConfirmCourseController: UIViewController {

    public static let segueIdentifier: String = "segueBetweenCreateCourseAndConfirmCourse"
    
    @IBOutlet weak var map: GMSMapView!
    var originLocation: CLLocation!
    var destinationLocation: CLLocation!
    
    var user: Utilisateur!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if user != nil && destinationLocation != nil && originLocation != nil {
            
        } else {
            self.dismiss(animated: true)
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        updateCameraBetween2Points(origin: originLocation.coordinate, destination: destinationLocation.coordinate)
    }
    
    /* -------------------------------------------------------------------------------------- */
    
    /* GESTION MAP */
    
    func updateCameraBetween2Points(origin: CLLocationCoordinate2D, destination: CLLocationCoordinate2D){
        // centrer la caméra entre le début et la fin du trajet
        var zoomToUse = Constants.DISTRICT_ZOOM;
        if(abs(origin.latitude-destination.latitude) > 0.001 || abs(origin.longitude-destination.longitude) > 0.001){
            zoomToUse = Constants.DEFAULT_ZOOM;
        }else if(abs(origin.latitude-destination.latitude) > 0.01 || abs(origin.longitude-destination.longitude) > 0.01){
            zoomToUse = Constants.TOWN_ZOOM;
        }
        map.animate(to: GMSCameraPosition.camera(withLatitude: abs(origin.latitude+destination.latitude)/2, longitude: abs(origin.longitude+destination.longitude)/2, zoom: zoomToUse))
    }
    
    func updateLocationOnMap(location: CLLocation){
        map.animate(to: GMSCameraPosition.camera(withLatitude: location.coordinate.latitude, longitude: location.coordinate.longitude, zoom: Constants.DEFAULT_ZOOM))
    }
    
    /* FIN MAP */
    
    /* -------------------------------------------------------------------------------------- */
    

}
