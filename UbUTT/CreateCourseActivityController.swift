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

class CreateCourseActivityController: UIViewController, UIApplicationDelegate, GMSMapViewDelegate, isAbleToReceiveData {

    private var placesClient: GMSPlacesClient!
    private var destination: GMSAutocompletePrediction!
    private var destMarker: GMSMarker!
    
    @IBOutlet weak var map: GMSMapView!
    @IBOutlet weak var textPtDepart: UITextField!
    
    private var destinationSegueDone = false
    @IBOutlet weak var textPtArrivee: UITextField!
    @IBAction func onDestinationTextPressed(_ sender: UITextField) {
        if(!destinationSegueDone){
            performSegue(withIdentifier: DestinationPickerController.segueIdentifier, sender: self)
            destinationSegueDone = true
        }
    }
    
    private var destBtnState = 0
    @IBOutlet weak var destOnMapButton: UIButton!
    @IBAction func onClickDestinationOnMap(_ sender: UIButton) {
        if(destBtnState == 0){
            destOnMapButton.setTitle("Confirmer la destination", for: .normal)
            destBtnState = 1
            
            destMarker = GMSMarker()
            destMarker.position = map.camera.target
            destMarker.title = "Destination"
            destMarker.icon = UIImage(named: "flag_black_27x27.png")
            destMarker.map = map
        }else if(destBtnState == 1){
            destOnMapButton.setTitle("Placer la destination sur la carte", for: .normal)
            destBtnState = 0
            
            destMarker.map = nil
            performSegue(withIdentifier: ConfirmCourseController.segueIdentifier, sender: self)
        }
    }
    
    public static let segueWithHomeID = "segueBetweenAccueilAndCreateCourseActivities"
    
    var location:CLLocation?
    var destLocation:CLLocation?
    var user:Utilisateur?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        destOnMapButton.layer.cornerRadius = 4
        
        if(location != nil){
            map.isMyLocationEnabled = true
            map.delegate = self
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
        }else if segue.destination is ConfirmCourseController{
            let vc = segue.destination as? ConfirmCourseController
            vc?.originLocation = location
            vc?.destinationLocation = destLocation
        }
    }
    
    /* -------------------------------------------------------------------------------------- */
    
    /* GESTION MAP */
    
    func updateLocationOnMap(location: CLLocation){
        map.animate(to: GMSCameraPosition.camera(withLatitude: location.coordinate.latitude, longitude: location.coordinate.longitude, zoom: Constants.DEFAULT_ZOOM))
    }
    
    // Camera change Position this methods will call every time
    func mapView(_ mapView: GMSMapView, didChange cam: GMSCameraPosition) {
        if self.destBtnState == 1{
            destMarker.position = map.camera.target
        }
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
        getPlacesFromLocation(location: location!, completionHandler: { (place) -> Void in
            if place != nil {
                self.destLocation = place!.location
                self.performSegue(withIdentifier: ConfirmCourseController.segueIdentifier, sender: nil)
            } else {
                self.dismiss(animated: true, completion: nil)
            }
        })
    }
    
}
