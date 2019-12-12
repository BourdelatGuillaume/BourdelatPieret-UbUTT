//
//  DriverController.swift
//  UbUTT
//
//  Created by if26-grp1 on 12/12/2019.
//  Copyright © 2019 BourdelatPieret. All rights reserved.
//

import UIKit

class DriverController: UIViewController {
    
    var delegate:isAbleToReceiveData!
    @IBOutlet weak var stars: UILabel!
    @IBOutlet weak var btEnregistrer: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //HomeActivity -> implémente isAbleToReceiveData
        //implémente fonction pass(Utilisateur)
        //prepare segue -> delegate = self
        
        //Driver->delegate.pass(user)
        //dismiss()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onEditModele(_ sender: UITextField) {
    }
    
    @IBAction func onEditPlaque(_ sender: UITextField) {
    }
    @IBAction func onSave(_ sender: UIButton) {
    }
    @IBAction func onReturn(_ sender: UIButton) {
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
