//
//  PoliticController.swift
//  UbUTT
//
//  Created by if26-grp1 on 12/12/2019.
//  Copyright © 2019 BourdelatPieret. All rights reserved.
//

import UIKit

class PoliticController: UIViewController {

    @IBOutlet weak var perso: UILabel!
    @IBOutlet weak var geoloc: UILabel!
    @IBOutlet weak var images: UILabel!
    @IBOutlet weak var deleteBt: UIButton!
    @IBOutlet weak var titrePerso: UILabel!
    @IBOutlet weak var titreGeo: UILabel!
    @IBOutlet weak var titreImage: UILabel!
    
    var user:Utilisateur?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        perso.text = "Les données recueillis servent à l'identification de l'utilisateur courant: nom, prénom, numéro de téléphone, email. Les données recueillis servent à l'identification de l'utilisateur conducteur: modèle de voiture, plaque d'immatriculation. Seuls le nom et le prénom dans le cadre d'un utilisateur courant sont divilgués aux utilisateurs conducteurs.Pour l'utilisateur conducteur le modèle de voiture et le numéro de plaque d'immatriculation seront divulgués à l'utilisateur courant.Le numéro de téléphone et email ne seront jamais divulgués et servent seulement à vous contacter.Les données seront conservées pendant tant que l'utilisateur sera actif et conservés maximum 3 ans après l'inactivité d'un utilisateur.A tout moment l'utilisateur peut consulter les données le concernant, les modifier, les supprimées."
        perso.numberOfLines=21
        perso.frame.size.height = 280
        titreGeo.frame.origin.y = 400
        geoloc.frame.origin.y=420
        geoloc.text = "Les données relatives à la position de l'utilisateur. Ces données permettent à l'application de trouver les conducteurs les plus proches pour vous. De savoir d'où vous partez et où vous arrivez afin de s'assurer que la course se déroule dans les meilleures conditions. Le point de départ et d'arrivés seront conservés pour permettre aux deux utilisateurs d'une course (conducteur et utilisateur courant) de pouvoir consulter un historique des courses. Les données de position ne seront conservées que durant le temps de la course. Seul le point de départ et d'arrivés seront conservés sur la durée de votre compte (voir données personnelles pour connaître la durée de vie d'un compte UbUTT). A tout moment l'utilisateur peut consulter les données le concernant, les modifier, les supprimées."
        geoloc.numberOfLines=20
        geoloc.frame.size.height = 280
        titreImage.frame.origin.y = 600
        images.frame.origin.y = 620
        images.text="Les images recuillies servent à l'identification de l'utilisateur mais ne sont pas obligatoires.Les utilisateurs pourront voir cette image. Seuls les images sélectionnés et envoyer seront stockés et montrées.Les autres images de votre bibliothèque d'image ne seront même pas consultable par nous. Les images seront stockés pendant la durée de votre compte (voir données personnelles pour connaître la durée de vie d'un compte UbUTT). A tout moment l'utilisateur peut consulter les données le concernant, les modifier, les supprimées."
        images.numberOfLines=20
        images.frame.size.height = 280
        
        if(user != nil){
            deleteBt.isHidden=false
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onClickDelete(_ sender: UIButton) {
        let dialogMessage = UIAlertController(title: "Confirmation", message: "Etes vous sûr de vouloir supprimer votre compte ?", preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            self.deleteUser()
        })
        
        let cancel = UIAlertAction(title: "Annuler", style: .cancel) { (action) -> Void in
        }
        
        dialogMessage.addAction(ok)
        dialogMessage.addAction(cancel)
        
        self.present(dialogMessage, animated: true, completion: nil)
    }
    
    public func deleteUser(){
        self.user!.setNom_utilisateur(nom_utilisateur: "Anonyme");
        self.user!.setPrenom_utilisateur(prenom_utilisateur: "");
        self.user!.setAdresse_email(adresse_email: "");
        self.user!.setNum_telephone(num_telephone: "");
        self.user!.update();
        if(self.user!.getConducteur() != nil){
            self.user!.getConducteur()!.setPlaque_immatriculation(plaque_immatriculation: "");
            self.user!.getConducteur()!.update();
        }
        let uc:UtilisateurConnection = UtilisateurConnection();
        uc.disconnect();
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onClickReturn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
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
