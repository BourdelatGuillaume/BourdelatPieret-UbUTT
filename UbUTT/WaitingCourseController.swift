//
//  WaitingCourseController.swift
//  UbUTT
//
//  Created by if26-grp3 on 12/12/2019.
//  Copyright © 2019 BourdelatPieret. All rights reserved.
//

import UIKit
import GoogleMaps

class WaitingCourseController: UIViewController {

    
    @IBOutlet weak var map: GMSMapView!
    var originLocation: CLLocation!
    var originMarker: GMSMarker!
    var destinationLocation: CLLocation!
    var destinationMarker: GMSMarker!
    
    var user: Utilisateur!
    
    var timer: Timer?
    var minute: Int = 0
    var second: Int = 0
    
    @IBOutlet weak var timerView: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem?.action = #selector(WaitingCourseController.back(sender:))
        map.isUserInteractionEnabled = false
        
        if user != nil && destinationLocation != nil && originLocation != nil {
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
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            self.second = self.second + 1;
            
            // au bout de 10 minutes d'attentes, on coupe
            if(self.minute == 10 && self.second == 60){
                self.navigationController?.popToRootViewController(animated: true)
            }else if(self.second == 60){
                self.minute = self.minute + 1;
                self.second = 0;
            }
            
            let mn = self.minute < 10 ? "0"+String(self.minute) : String(self.minute)
            let sec = self.second < 10 ? "0"+String(self.second) : String(self.second)
            self.timerView.text =  mn + ":" + sec
        }
        updateCameraBetween2Points(origin: originLocation.coordinate, destination: destinationLocation.coordinate)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        timer?.invalidate()
    }

    @objc func back(sender: UIBarButtonItem){
        navigationController?.popToRootViewController(animated: true)
        // todo delete from database the course
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
    
    /* FIN MAP */
    
    /* -------------------------------------------------------------------------------------- */
    
}
