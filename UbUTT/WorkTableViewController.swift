//
//  WorkTableViewController.swift
//  UbUTT
//
//  Created by if26-grp3 on 17/12/2019.
//  Copyright © 2019 BourdelatPieret. All rights reserved.
//

import UIKit

class WorkTableViewController: UITableViewController {

    public static let segueIdentifier: String = "segueBetweenWorkActivityAndWorkTable"
    var user:Conducteur?
    
    var courses: [Course] = [Course]()
    
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
        cell.labelDestination.text = "100 m" // c'est la distance
        
        return cell
    }

}
