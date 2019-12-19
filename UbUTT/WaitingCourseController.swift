//
//  WaitingcourseActiveController.swift
//  UbUTT
//
//  Created by if26-grp3 on 12/12/2019.
//  Copyright © 2019 BourdelatPieret. All rights reserved.
//

import UIKit
import GoogleMaps

class WaitingCourseController: UIViewController {

    @IBAction func cancelCourse(_ sender: UIButton) {
        abortCourseActive()
    }
    
    @IBOutlet weak var map: GMSMapView!
    var originLocation: CLLocation!
    var originMarker: GMSMarker!
    var destinationLocation: CLLocation!
    var destinationMarker: GMSMarker!
    
    var user: Utilisateur!
    var courseActive: Course!
    var eventRunnable: EventCourseRunnable?
    
    var timer: Timer?
    var minute: Int = 0
    var second: Int = 0
    
    var conducteurDejaEnChemin = false
    var conducteurMarker: GMSMarker = GMSMarker()
    
    @IBOutlet weak var timerView: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    
    public static let segueIdentifier = "segueBetweenConfirmAndWaiting"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem?.action = #selector(WaitingCourseController.back(sender:))
        map.isUserInteractionEnabled = false
        
        if user != nil && destinationLocation != nil && originLocation != nil && courseActive != nil {
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
            
            conducteurMarker.title = "Conducteur"
            conducteurMarker.icon = UIImage(named: "local_taxi_black_24x24.png")
            conducteurMarker.map = map
            
            eventRunnable = EventCourseRunnable(user:user){ courseActive, error in
                if(error != ""){
                    print(error)
                }else{
                    switch(courseActive.getId_statut()){
                    case 2: // conducteur en chemin
                        if(!self.conducteurDejaEnChemin){
                            self.conducteurDejaEnChemin = true
                            self.timer?.invalidate()
                            self.second = 0
                            self.minute = 0
                        }
                        
                        let tmpArray = courseActive.getPosition_conducteur().split(separator: ",", maxSplits: 2)
                        let conducteurLocation = CLLocationCoordinate2D(latitude: Double(tmpArray[0])!, longitude: Double(tmpArray[1])!)
                        DispatchQueue.main.async{
                            self.updateConducteurMarker(conducteurLatLng: conducteurLocation)
                            self.updateCameraBetween2Points(origin: self.originLocation.coordinate, destination: conducteurLocation)
                            self.timerView.isHidden = true
                            self.cancelButton.isHidden = true
                            self.map.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                        }
                        
                        let result:Double = HaversineCalculator.calculateDistance(p1: self.originLocation.coordinate, p2: conducteurLocation)
                        
                        if (result < 40) { // distance between conducteur and origin location is less than 40 meters
                            self.courseActive.setId_statut(id_statut: 3)
                            self.courseActive.updateStatut()
                            DispatchQueue.main.async{
                                self.originMarker.map = nil
                            }
                        }
                        break;
                    case 3: // course en cours
                        let tmpArray = courseActive.getPosition_conducteur().split(separator: ",", maxSplits: 2)
                        let conducteurLocation = CLLocationCoordinate2D(latitude: Double(tmpArray[0])!, longitude: Double(tmpArray[1])!)
                        DispatchQueue.main.async{
                            self.updateConducteurMarker(conducteurLatLng: conducteurLocation)
                            self.updateCameraBetween2Points(origin: self.destinationLocation.coordinate, destination: conducteurLocation)
                        }
                        
                        let result:Double = HaversineCalculator.calculateDistance(p1: self.destinationLocation.coordinate, p2: conducteurLocation)
                        
                        if (result < 40) { // distance between conducteur and destination location is less than 40 meters
                            self.courseActive.setId_statut(id_statut: 4)
                            self.courseActive.updateStatut()
                            self.eventRunnable?.stop()
                            self.navigationController?.dismiss(animated: true)
                        }
                        
                        break;
                    default:
                        print("wrong id_statut")
                        break;
                    }
                }
            }
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
        eventRunnable?.stop()
    }

    @objc func back(sender: UIBarButtonItem){
        abortCourseActive()
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
        self.map.animate(to: GMSCameraPosition.camera(withLatitude: abs(origin.latitude+destination.latitude)/2, longitude: abs(origin.longitude+destination.longitude)/2, zoom: zoomToUse))
    }
    
    func updateConducteurMarker(conducteurLatLng:CLLocationCoordinate2D){
        self.conducteurMarker.position = conducteurLatLng
    }
    
    /* FIN MAP */
    
    /* -------------------------------------------------------------------------------------- */
    
    func abortCourseActive(){
        courseActive.setId_statut(id_statut: 5)
        courseActive.updateStatut()
        navigationController?.popToRootViewController(animated: true)
    }
    
}
