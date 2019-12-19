//
//  WorkTableViewController.swift
//  UbUTT
//
//  Created by if26-grp3 on 17/12/2019.
//  Copyright © 2019 BourdelatPieret. All rights reserved.
//

import UIKit
import GoogleMapsBase

class WorkTableViewController: UITableViewController {

    public static let segueIdentifier: String = "segueBetweenWorkActivityAndWorkTable"
    var user: Conducteur!
    var lastLocation: CLLocation!
    
    var courses: [Course] = [Course]()
    var selectedCourse: Course!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 40
        
        courses = Course.getAvailableCoursesForConducteur(user: user!)
        if(courses.count < 1){
            self.dismiss(animated:true)
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courses.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CourseViewCell", for: indexPath) as? CourseViewCell  else {
            fatalError("The dequeued cell is not an instance of CourseViewCell.")
        }
        let course = courses[indexPath.row]
        
        cell.labelPrix.text = String(format: "%.0f€", course.getPrix_estime())
        
        let tmpOrigin = course.getPoint_depart().split(separator: ",", maxSplits: 2)
        let originLocation: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: Double(tmpOrigin[0])!, longitude: Double(tmpOrigin[1])!)
        let tmpDest = course.getPoint_arrivee().split(separator: ",", maxSplits: 2)
        let destinationLocation: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: Double(tmpDest[0])!, longitude: Double(tmpDest[1])!)
        
        var distance:Double = HaversineCalculator.calculateDistance(p1: originLocation, p2: destinationLocation)
        var unite = "m";
        if distance > 1000 {
            distance = distance/1000;
            unite = "km";
        }
        cell.labelDestination.text = String.localizedStringWithFormat("%.2f %@", distance, unite) // c'est la distance
        
        cell.takeButton.tag = indexPath.row
        cell.takeButton.addTarget(self, action: #selector(courseSelected(_:)), for: .touchUpInside)
        
        return cell
    }
    
    @objc func courseSelected(_ sender: UIButton){
        selectedCourse = courses[sender.tag]
        selectedCourse.setId_statut(id_statut: 2)
        selectedCourse.setId_conducteur(id_conducteur: (user?.getId_conducteur())!)
        selectedCourse.setPosition_conducteur(position_conducteur: String(lastLocation.coordinate.latitude)+","+String(lastLocation.coordinate.longitude))
        selectedCourse.updatePosition_conducteur()
        selectedCourse.updateId_conducteur()
        selectedCourse.updateStatut()
        //courses.remove(at: sender.tag)
        //self.tableView.reload
        performSegue(withIdentifier: ConducteurActivityController.segueIdentifier, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.destination is ConducteurActivityController{
            let vc = segue.destination as? ConducteurActivityController
            vc?.user = user
            vc?.course = selectedCourse
            vc?.location = lastLocation
        }
    }

}
