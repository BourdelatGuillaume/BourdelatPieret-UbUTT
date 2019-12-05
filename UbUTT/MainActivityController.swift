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
        let bd:BDConnection = BDConnection()
        bd.execute(page:"https://appliweb.000webhostapp.com/if26/SQLMultipleResult.php",requete: "SELECT * FROM UTILISATEUR",parametres:"")
        // Do any additional setup after loading the view.
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
