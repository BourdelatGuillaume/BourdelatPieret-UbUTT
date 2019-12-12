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
    
    @IBOutlet weak var btnConfirm: UIButton!
    
    @IBOutlet weak var map: GMSMapView!
    var originLocation: CLLocation!
    var originMarker: GMSMarker!
    var destinationLocation: CLLocation!
    var destinationMarker: GMSMarker!
    
    @IBOutlet weak var textDistance: UILabel!
    var distance: Double?
    @IBOutlet weak var textPrix: UILabel!
    var prix: Double?
    
    var user: Utilisateur!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnConfirm.layer.cornerRadius = 4
        map.isUserInteractionEnabled = false
        
        if user != nil && destinationLocation != nil && originLocation != nil {
            distance = getDistance()
            prix = distance!*Constants.pricePerMeter
            var unite = "m";
            if distance! > 1000 {
                distance = distance!/1000;
                unite = "km";
            }
            textDistance.text = String.localizedStringWithFormat("%.2f %@", distance!, unite)
            textPrix.text = String(Int(prix!-1)) + " - " + String(Int(prix!+1)) + " €"
            
            originMarker = GMSMarker()
            originMarker.position = originLocation.coordinate
            originMarker.title = "Départ"
            originMarker.icon = UIImage(named: "person_pin_circle_black_24x24.png")
            originMarker.map = map
            destinationMarker = GMSMarker()
            destinationMarker.position = destinationLocation.coordinate
            destinationMarker.title = "Destination"
            destinationMarker.icon = UIImage(named: "flag_black_27x27.png")
            destinationMarker.map = map
        } else {
            self.dismiss(animated: true)
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        updateCameraBetween2Points(origin: originLocation.coordinate, destination: destinationLocation.coordinate)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.destination is WaitingCourseController{
            let vc = segue.destination as? WaitingCourseController
            vc?.originLocation = originLocation
            vc?.destinationLocation = destinationLocation
            vc?.user = user
        }
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
    
    func updateLocationOnMap(location: CLLocation){
        map.animate(to: GMSCameraPosition.camera(withLatitude: location.coordinate.latitude, longitude: location.coordinate.longitude, zoom: Constants.DEFAULT_ZOOM))
    }
    
    /* FIN MAP */
    
    /* -------------------------------------------------------------------------------------- */
    
    private func getDistance() -> Double{
        return HaversineCalculator.calculateDistance(p1: originLocation.coordinate, p2: destinationLocation.coordinate);
    }

}
