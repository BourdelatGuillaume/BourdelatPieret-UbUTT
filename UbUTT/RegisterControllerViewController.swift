//
//  RegisterControllerViewController.swift
//  UbUTT
//
//  Created by if26-grp1 on 05/12/2019.
//  Copyright © 2019 BourdelatPieret. All rights reserved.
//

import UIKit

class RegisterControllerViewController: UIViewController {

    @IBOutlet weak var nom: UITextField!
    @IBOutlet weak var prenom: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var numero: UITextField!
    @IBOutlet weak var pass: UITextField!
    @IBOutlet weak var politic: UISwitch!
    
    var user:Utilisateur?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func onClickRegister(_ sender: UIButton) {
        if(nom.text!.count>0){
            nom.backgroundColor = UIColor.red
        } else {
            nom.backgroundColor = UIColor.white
        }
        if(prenom.text!.count>0){
            prenom.backgroundColor = UIColor.red
        } else {
            prenom.backgroundColor = UIColor.white
        }
        if(email.text!.count>0){
            email.backgroundColor = UIColor.red
        } else {
            email.backgroundColor = UIColor.white
        }
        if(numero.text!.count<10){
            numero.backgroundColor = UIColor.red
        } else {
            numero.backgroundColor = UIColor.white
        }
        if(pass.text!.count<6){
            pass.backgroundColor = UIColor.red
        } else {
            pass.backgroundColor = UIColor.white
        }
        let utilisateurConnection:UtilisateurConnection =  UtilisateurConnection();
        let utilisateur:Utilisateur? = utilisateurConnection.register(nom: nom.text!, prenom: prenom.text!, email: email.text!, num_tel: numero.text!, password: pass.text!)
        if (utilisateur != nil) {
            signIn(user: utilisateur!)
        } /*else {
            Toast toast = Toast.makeText(this, "L'email ou le numéro de téléphone est déjà utilisé", Toast.LENGTH_LONG);
            toast.show();
        }*/
    }
    
    private func signIn(user:Utilisateur){
        self.user = user
        //self.dismiss(animated: true, completion: nil)
        performSegue(withIdentifier: "segueHome", sender: nil)
        
    }
    
    @IBAction func onClickReturn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        performSegue(withIdentifier: "segueConnection", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is HomeActivityController
        {
            let vc = segue.destination as? HomeActivityController
            vc?.user = self.user
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

}
