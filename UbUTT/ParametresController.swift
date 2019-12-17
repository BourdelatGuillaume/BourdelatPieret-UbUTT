//
//  ParametresController.swift
//  UbUTT
//
//  Created by if26-grp1 on 13/12/2019.
//  Copyright © 2019 BourdelatPieret. All rights reserved.
//

import UIKit

class ParametresController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var nom: UITextField!
    @IBOutlet weak var prenom: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var numero: UITextField!
    @IBOutlet weak var pass: UITextField!
    @IBOutlet weak var save: UIButton!
    
    var user:Utilisateur?
    var imagePicker: ImagePicker!
    
    private var imageModified:Bool = false
    private var userModified:Bool = false
    private var emailModified:Bool = false
    private var telModified:Bool = false
    private var passwordModified:Bool = false
    
    var delegate:isAbleToReceiveData!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        
        if (user != nil) {
            let userImage:Image?  = user!.getImage()
            if (userImage != nil ) {
                if(userImage!.getImage() != nil){
                    image.image = userImage!.getImage()
                }
            } else {
                image.backgroundColor = UIColor.gray
            }
            nom.text = user!.getNom_utilisateur()
            prenom.text = user!.getPrenom_utilisateur()
            email.text = user!.getAdresse_email()
            numero.text = user!.getNum_telephone()
        }
    }
    
    @IBAction func onClickChangeImage(_ sender: UIButton) {
        self.imagePicker.present(from: sender)
    }
    
    @IBAction func onClickReturn(_ sender: UIButton) {
        delegate.pass(data: user!)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onClickSave(_ sender: UIButton) {
        save.isEnabled=false
        if(imageModified) {
            imageModified = false
            upload()
        }
        if(userModified){
            if(nom.text!.count<1){
                nom.backgroundColor = UIColor.red
            } else {
                nom.backgroundColor = UIColor.white
                user!.setNom_utilisateur(nom_utilisateur: nom.text!)
            }
            if(prenom.text!.count<1){
                prenom.backgroundColor = UIColor.red
            } else {
                prenom.backgroundColor = UIColor.white
                user!.setPrenom_utilisateur(prenom_utilisateur: prenom.text!)
            }
            user!.updateUtilisateur()
        }
        if(emailModified){
            if(email.text!.count<1){
                email.backgroundColor = UIColor.red
            } else {
                email.backgroundColor = UIColor.white
                let email_s:String = user!.getAdresse_email()
                user!.setAdresse_email(adresse_email: email.text!)
                if(!self.user!.updateEmail()){
                    self.user!.setAdresse_email(adresse_email: email_s)
                    email.backgroundColor = UIColor.red
                }
            }
        }
        if(telModified){
            if(numero.text!.count<10){
                numero.backgroundColor = UIColor.red
            } else {
                numero.backgroundColor = UIColor.white
                let num:String = self.user!.getNum_telephone()
                self.user!.setNum_telephone(num_telephone: numero.text!)
                if(!self.user!.updateTel()){
                    self.user!.setNum_telephone(num_telephone: num)
                    numero.backgroundColor = UIColor.red
                }
            }
        }
        if(passwordModified){
            if(pass.text!.count<6){
                pass.backgroundColor = UIColor.red
            } else {
                pass.backgroundColor = UIColor.white
                self.user!.setPassword(password: BDConnection.sha512(string: pass.text!))
                self.user!.updatePassword()
            }
        }
        userModified = false
        emailModified=false
        telModified=false
        passwordModified = false
    }
    
    @IBAction func onEditNom(_ sender: UITextField) {
        save.isEnabled=true
        userModified=true
    }
    @IBAction func onEditPrenom(_ sender: UITextField) {
        save.isEnabled=true
        userModified=true
    }
    @IBAction func onEditEmail(_ sender: UITextField) {
        emailModified=true
        save.isEnabled=true
    }
    @IBAction func onEditNum(_ sender: UITextField) {
        telModified=true
        save.isEnabled=true
    }
    @IBAction func onEditPass(_ sender: UITextField) {
        passwordModified=true
        save.isEnabled=true
    }
    
    public func upload(){
        let userImage:Image = Image()
        userImage.setImage(image: image.image!)
        userImage.upload()
        if(userImage.getId_image() != 0){
            self.user!.setImage(image: userImage)
            self.user!.setId_image(id_image: userImage.getId_image())
            let req:SQLRequest = SQLRequest()
            req.prepare(requete: "UPDATE UTILISATEUR SET ID_IMAGE= ? WHERE ID_UTILISATEUR = ?")
            req.addParametres(parametre: [String(userImage.getId_image()), String(self.user!.getId_utilisateur())])
            req.executerNoResult()
        }
    }
}

extension ParametresController: ImagePickerDelegate {
    
    func didSelect(image: UIImage?) {
        self.image.image = image
        self.imageModified = true
        save.isEnabled=true
    }
}
