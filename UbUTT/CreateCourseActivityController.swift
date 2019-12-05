//
//  CreateCourseActivityController.swift
//  UbUTT
//
//  Created by if26-grp3 on 05/12/2019.
//  Copyright © 2019 BourdelatPieret. All rights reserved.
//

import UIKit
import GoogleMaps

class CreateCourseActivityController: UIViewController, UIApplicationDelegate {

    @IBOutlet weak var map: GMSMapView!
    
    public static let segueWithHomeID = "segueBetweenAccueilAndCreateCourseActivities"
    
    private var location:CLLocationCoordinate2D!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //updateLocationOnMap() -> faut passer la location et la récupérer
    }
    
    /* -------------------------------------------------------------------------------------- */
    
    /* GESTION MAP */
    
    func updateLocationOnMap(){
        map.animate(to: GMSCameraPosition.camera(withLatitude: location.latitude, longitude: location.longitude, zoom: Constants.DEFAULT_ZOOM))
    }
    
    /* FIN MAP */
    
    /* -------------------------------------------------------------------------------------- */
    
}
