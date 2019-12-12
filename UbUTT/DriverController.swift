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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (self.user != nil) {
            //input_modele.setText(user.getConducteur().getModele_voiture());
            //input_plaque.setText(user.getConducteur().getPlaque_immatriculation());
            stars.text = String(format:"%.1f", (user!.getConducteur()!.getNoteConducteur()))
        }
        
        //HomeActivity -> implémente isAbleToReceiveData
        //implémente fonction pass(Utilisateur)
        //prepare segue -> delegate = self
        
        //Driver->delegate.pass(user)
        //dismiss()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onEditModele(_ sender: UITextField) {
        btEnregistrer.isEnabled=true
    }
    
    @IBAction func onEditPlaque(_ sender: UITextField) {
        btEnregistrer.isEnabled=true
    }
    @IBAction func onSave(_ sender: UIButton) {
        btEnregistrer.isEnabled=false
        /*if(modeleModified || plaqueModified) {
            if (input_modele.getText().toString().length() < 1) {
                input_modele.setBackgroundColor(getResources().getColor(R.color.lightRed));
            } else {
                input_modele.setBackgroundColor(Color.WHITE);
                this.user.getConducteur().setModele_voiture(input_modele.getText().toString());
            }
            if (input_plaque.getText().toString().length() < 1) {
                input_plaque.setBackgroundColor(getResources().getColor(R.color.lightRed));
            } else {
                input_plaque.setBackgroundColor(Color.WHITE);
                this.user.getConducteur().setPlaque_immatriculation(input_plaque.getText().toString().toUpperCase());
            }
            this.user.getConducteur().update();
        }*/
    }
    @IBAction func onReturn(_ sender: UIButton) {
        delegate.pass(data: user!)
        dismiss(animated: true, completion: nil)
    }

}
