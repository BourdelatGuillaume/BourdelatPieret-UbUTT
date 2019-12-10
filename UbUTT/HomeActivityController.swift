//
//  HomeActivityController.swift
//  UbUTT
//
//  Created by if26-grp3 on 05/12/2019.
//  Copyright © 2019 BourdelatPieret. All rights reserved.
//

import UIKit
import GoogleMaps

class HomeActivityController : UIViewController, UIApplicationDelegate {
    
    @IBOutlet weak var map: GMSMapView!
    @IBOutlet weak var newCourseBtn: UIButton!
    
    @IBOutlet weak var leading: NSLayoutConstraint!
    @IBOutlet weak var trailing: NSLayoutConstraint!
    @IBOutlet weak var menuHamburgerNoir: UIView!
    @IBOutlet weak var menuHamburger: UIView!
    
    @IBOutlet weak var btMenuDriver: UIButton!
    @IBOutlet weak var textMenuNameUser: UILabel!
    @IBOutlet weak var textMenuNoteUser: UILabel!
    
    
    private let locationManager = CLLocationManager()
    
    private var location:CLLocation!
    
    var user:Utilisateur?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newCourseBtn.layer.cornerRadius = 4
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        map.isMyLocationEnabled = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        menuHamburgerNoir.addGestureRecognizer(tap)
        
        if(user != nil){
            if(user!.getConducteur() != nil){
                btMenuDriver.isHidden = false
            } else {
                btMenuDriver.isHidden = true
            }
            textMenuNameUser.text=user!.getNom_utilisateur()+" "+user!.getPrenom_utilisateur()
            textMenuNoteUser.text = String(format:"%.1f", user!.getNoteUtilisateur())
        }
    }
    
    @IBAction func onMenuClick(_ sender: UIButton) {
        menuHamburgerNoir.isHidden = false
        menuHamburger.isHidden = false
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        menuHamburgerNoir.isHidden = true
        menuHamburger.isHidden = true
    }
    
    @IBAction func onClickParametre(_ sender: UIButton) {
    }
    
    @IBAction func onClickHistory(_ sender: UIButton) {
    }
    
    @IBAction func onClickDriver(_ sender: UIButton) {
    }
    
    @IBAction func onClickDisconnect(_ sender: UIButton) {
        let uc:UtilisateurConnection = UtilisateurConnection();
        uc.disconnect();
        self.dismiss(animated: true, completion: nil)
        performSegue(withIdentifier: "segueDisconnect", sender: nil)
    }
    
    @IBAction func onClickPolitic(_ sender: UIButton) {
    }
    
    override func viewWillAppear(_ animated: Bool) {
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
    
    func updateLocationOnMap(){
        map.animate(to: GMSCameraPosition.camera(withLatitude: location.coordinate.latitude, longitude: location.coordinate.longitude, zoom: Constants.DEFAULT_ZOOM))
    }
    
    /* FIN MAP */
    
    /* -------------------------------------------------------------------------------------- */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.destination is UINavigationController{
            let navVC = segue.destination as? UINavigationController
            let vc = navVC?.topViewController as? CreateCourseActivityController
            vc?.user = self.user
            vc?.location = location
        }
    }
    
}
/* LOCATION MANAGER */
extension HomeActivityController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
            case .authorizedAlways:
                // unused in this app
                print("user allow app to get location data when app is active or in background")
            case .authorizedWhenInUse:
                locationManager.startUpdatingLocation()
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
            updateLocationOnMap()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("locationManagerError: \(error)")
    }
    
}
