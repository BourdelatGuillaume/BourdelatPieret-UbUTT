//
//  CreateCourseActivityController.swift
//  UbUTT
//
//  Created by if26-grp3 on 05/12/2019.
//  Copyright © 2019 BourdelatPieret. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class CreateCourseActivityController: UIViewController, UIApplicationDelegate, isAbleToReceiveData {

    private var placesClient: GMSPlacesClient!
    private var destination: GMSAutocompletePrediction!
    
    @IBOutlet weak var map: GMSMapView!
    @IBOutlet weak var textPtDepart: UITextField!
    
    @IBOutlet weak var textPtArrivee: UITextField!
    @IBAction func onDestinationTextPressed(_ sender: UITextField) {
        performSegue(withIdentifier: DestinationPickerController.segueIdentifier, sender: nil)
    }
    
    @IBOutlet weak var destOnMapButton: UIButton!
    @IBAction func onClickDestinationOnMap(_ sender: UIButton) {
        // @todo
    }
    
    public static let segueWithHomeID = "segueBetweenAccueilAndCreateCourseActivities"
    
    var location:CLLocation?
    var user:Utilisateur?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        destOnMapButton.layer.cornerRadius = 4
        
        if(location != nil){
            map.isMyLocationEnabled = true
            placesClient = GMSPlacesClient.shared()
            getPlacesFromLocation(location: location!, completionHandler: { (place) -> Void in
                if place != nil {
                    self.textPtDepart.text = place!.name
                } else {
                    self.dismiss(animated: true, completion: nil)
                }
            })
        }else{
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        updateLocationOnMap(location: location!)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.destination is DestinationPickerController{
            let vc = segue.destination as? DestinationPickerController
            vc?.delegate = self
            vc?.location = self.location
        }
    }
    
    /* -------------------------------------------------------------------------------------- */
    
    /* GESTION MAP */
    
    func updateLocationOnMap(location: CLLocation){
        map.animate(to: GMSCameraPosition.camera(withLatitude: location.coordinate.latitude, longitude: location.coordinate.longitude, zoom: Constants.DEFAULT_ZOOM))
    }
    
    /* FIN MAP */
    
    /* GESTION API PLACES */
    
    func getPlacesFromLocation(location: CLLocation, completionHandler: @escaping (CLPlacemark?) -> Void){
        let geocoder = CLGeocoder()
        // Look up the location and pass it to the completion handler
        geocoder.reverseGeocodeLocation(location,
            completionHandler: { (placemarks, error) in
                if error == nil {
                    let firstLocation = placemarks?[0]
                    completionHandler(firstLocation)
                }else {
                    // An error occurred during geocoding.
                    completionHandler(nil)
                }
        })
    }
    
    /* FIN API PLACES */
    
    /* -------------------------------------------------------------------------------------- */
    
    func pass(data: GMSAutocompletePrediction) {
        destination = data
        textPtArrivee.text = destination.attributedPrimaryText.string
        performSegue(withIdentifier: ConfirmCourseController.segueIdentifier, sender: nil)
    }
    
}
