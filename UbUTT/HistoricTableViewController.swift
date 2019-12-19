//
//  HistoricController.swift
//  UbUTT
//
//  Created by if26-grp1 on 13/12/2019.
//  Copyright © 2019 BourdelatPieret. All rights reserved.
//

import UIKit

class HistoricTableViewController: UITableViewController {
    
    var user:Utilisateur?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 105
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return user!.getCourses().count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HistoricViewCell", for: indexPath) as? HistoricViewCell  else {
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }
        
        let course = user!.getCourses()[indexPath.row]
        
        cell.date.text = course.getDate()
        cell.prix.text = String(format:"%.1f", course.getPrix_estime())+"€"
        
        let conducteur:Conducteur? = course.getConducteur()
        
        let statut:Statut? = course.getStatut()
        if(statut != nil){
            cell.statut.text = statut!.getStatut()
        }
        
        if (conducteur != nil) {
            cell.modele.text = conducteur!.getModele_voiture()
            if(course.getNote_conducteur() != -1){
                cell.note.text = String(course.getNote_conducteur())
            }
            let userConducteur:Utilisateur? = conducteur!.getUtilisateur()
            if(userConducteur != nil){
                cell.nom.text = userConducteur!.getPrenom_utilisateur() + " " + userConducteur!.getNom_utilisateur()
            }
        }
        
        return cell
    }
    
}
