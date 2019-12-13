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
    
    var user:Utilisateur?
    @IBOutlet weak var stars: UILabel!
    @IBOutlet weak var btEnregistrer: UIButton!
    @IBOutlet weak var modele: UITextField!
    @IBOutlet weak var plaque: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (self.user != nil) {
            modele.text = user!.getConducteur()!.getModele_voiture()
            plaque.text = user!.getConducteur()!.getPlaque_immatriculation()
            stars.text = String(format:"%.1f", (user!.getConducteur()!.getNoteConducteur()))
        }
    }
    
    @IBAction func onEditModele(_ sender: UITextField) {
        btEnregistrer.isEnabled=true
    }
    
    @IBAction func onEditPlaque(_ sender: UITextField) {
        btEnregistrer.isEnabled=true
    }
    @IBAction func onSave(_ sender: UIButton) {
        btEnregistrer.isEnabled=false
            if (modele.text!.count < 1) {
                modele.backgroundColor = UIColor.red
            } else {
                modele.backgroundColor = UIColor.white
                self.user!.getConducteur()!.setModele_voiture(modele_voiture: modele.text!);
            }
            if (plaque.text!.count < 1) {
                plaque.backgroundColor = UIColor.red
            } else {
                plaque.backgroundColor = UIColor.white
                self.user!.getConducteur()!.setPlaque_immatriculation(plaque_immatriculation: plaque.text!);
            }
            self.user!.getConducteur()!.update();
    }
    @IBAction func onReturn(_ sender: UIButton) {
        delegate.pass(data: user!)
        dismiss(animated: true, completion: nil)
    }

}
