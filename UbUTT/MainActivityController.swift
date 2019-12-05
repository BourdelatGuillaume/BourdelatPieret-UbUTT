//
//  MainActivityController.swift
//  UbUTT
//
//  Created by if26-grp1 on 26/11/2019.
//  Copyright © 2019 BourdelatPieret. All rights reserved.
//

import UIKit

class MainActivityController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let req:SQLRequest<Utilisateur> = SQLRequest()
        req.prepare(requete: "SELECT * FROM UTILISATEUR")
        let utils:Array<Utilisateur> = req.executerMultipleResult()
        
        let req2:SQLRequest = SQLRequest()
        req2.prepare(requete: "UPDATE UTILISATEUR SET PRENOM_UTILISATEUR=? WHERE ID_UTILISATEUR=?")
        req2.addParametres(parametre: ["Erwan","1"])
        req2.executerNoResult()
        
        let req3:SQLRequest<Utilisateur> = SQLRequest()
        req3.prepare(requete: "SELECT * FROM UTILISATEUR WHERE ID_UTILISATEUR=?")
        req3.addParametres(parametre: ["1"])
        let util:Utilisateur? = req3.executerOneResult()
        if(util != nil){
            print(util!.getPrenom_utilisateur())
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    /* prepareForSegue() -> https://learnappmaking.com/pass-data-between-view-controllers-swift-how-to/ */

}
