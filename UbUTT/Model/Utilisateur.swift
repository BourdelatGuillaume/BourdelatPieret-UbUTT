//
//  Utilisateur.swift
//  UbUTT
//
//  Created by if26-grp1 on 26/11/2019.
//  Copyright © 2019 BourdelatPieret. All rights reserved.
//

import Foundation

/**
 * Classe représentant un utilisateur de l'application
 */
public class Utilisateur : Entity{
    
    private var id_utilisateur:Int
    private var nom_utilisateur:String
    private var prenom_utilisateur:String
    private var adresse_email:String
    private var num_telephone:String
    private var password:String
    private var id_image:Int
    
    private var conducteur:Conducteur?
    private var image:Image?
    private var courses:Array<Course>
 
    required init(){
        self.id_utilisateur=0
        self.nom_utilisateur=""
        self.prenom_utilisateur=""
        self.adresse_email=""
        self.num_telephone=""
        self.password=""
        self.id_image=0
        self.courses=Array()
        super.init()
    }
    
    required init( dictionary: [String : Any]){
        self.id_utilisateur=dictionary["id_utilisateur"] as? Int ?? 0
        self.nom_utilisateur=dictionary["nom_utilisateur"] as? String ?? ""
        self.prenom_utilisateur=dictionary["prenom_utilisateur"] as? String ?? ""
        self.adresse_email=dictionary["adresse_email"] as? String ?? ""
        self.num_telephone=dictionary["num_telephone"] as? String ?? ""
        self.password=dictionary["password"] as? String ?? ""
        self.id_image=dictionary["id_image"] as? Int ?? 0
        self.courses=Array()
        super.init(dictionary: dictionary)
    }
    
    public static func getBDUtilisateurByID(id:Int) -> Utilisateur?{
        let req:SQLRequest<Utilisateur> = SQLRequest()
        req.prepare(requete:"SELECT * FROM UTILISATEUR WHERE ID_UTILISATEUR = ?")
        req.addParametres(parametre:[String(id)])
        return req.executerOneResult()
    }
    
    private func getBDImage() -> Void{
        let req:SQLRequest<Image> = SQLRequest()
        req.prepare(requete:"SELECT * FROM IMAGE WHERE ID_IMAGE = ?")
        req.addParametres(parametre:[String(self.id_image)])
        self.image = req.executerOneResult()
    }
    
    public func getImage() -> Image?{
        if(self.image == nil){
            getBDImage()
        }
        return self.image
    }
    
    
    public func getConducteur() -> Conducteur?{
        if(self.conducteur == nil){
            self.conducteur = Conducteur.getBDConducteurByIDUtilisateur(id:self.id_utilisateur)
        }
        return self.conducteur
    }
    
    public func setConducteur(conducteur:Conducteur) -> Void {
        self.conducteur = conducteur
    }
    
    public func getCourses() -> Array<Course>{
        if(self.courses.count<1){
            let req:SQLRequest<Course> = SQLRequest()
            req.prepare(requete:"SELECT * FROM COURSE WHERE ID_PASSAGER = ?")
            req.addParametres(parametre:[String(self.id_utilisateur)])
            self.courses = req.executerMultipleResult()
        }
        return self.courses
    }
    
    public func getNoteUtilisateur() -> Double{
        var courses:Array<Course>  = self.getCourses()
        var res:Double = 5.0
        for c in courses {
            if(c.getNote_passager() != -1) {
                res += Double(c.getNote_passager())
            }
        }
        res /= Double(courses.count+1)
        return res
    }
    
    public func getCourseActive() -> Course?{
        let req:SQLRequest<Course> = SQLRequest()
        req.prepare(requete: "SELECT * FROM COURSE WHERE ID_PASSAGER = ? AND ID_STATUT <> 5")
        req.addParametres(parametre: [String(self.id_utilisateur)])
        var course:Course? = req.executerOneResult()
        if(course==nil && self.getConducteur() != nil){
            req.prepare(requete: "SELECT * FROM COURSE WHERE ID_CONDUCTEUR = ? AND ID_STATUT <> 5")
            req.addParametres(parametre: [String(self.getConducteur()!.getId_conducteur())])
            course = req.executerOneResult()
        }
        return course
    }
    
    public func updateUtilisateur() -> Void{
        let req:SQLRequest  = SQLRequest()
        req.prepare(requete: "UPDATE UTILISATEUR SET NOM_UTILISATEUR = ?, PRENOM_UTILISATEUR= ? WHERE ID_UTILISATEUR=?")
        req.addParametres(parametre:[self.nom_utilisateur,self.prenom_utilisateur,String(self.id_utilisateur)])
        req.executerNoResult()
    }
    
    /*public func updateEmail(context:Context) -> Bool{
        UtilisateurConnection uc = new UtilisateurConnection(context)
        if(!uc.alreadyExistEmail(self.adresse_email)) {
            SQLRequest req = new SQLRequest()
            req.prepare("UPDATE UTILISATEUR SET ADRESSE_EMAIL = ? WHERE ID_UTILISATEUR=?")
            req.addParametres(new String[]{self.adresse_email, String.valueOf(self.id_utilisateur)})
            req.executerNoResult()
            return true
        } else {
            return false
        }
    }*/
    
    /*public func updateTel(context:Context) -> Bool{
        UtilisateurConnection uc = new UtilisateurConnection(context)
        if(!uc.alreadyExistTel(self.num_telephone)) {
            SQLRequest req = new SQLRequest()
            req.prepare("UPDATE UTILISATEUR SET NUM_TELEPHONE = ? WHERE ID_UTILISATEUR=?")
            req.addParametres(new String[]{self.num_telephone, String.valueOf(self.id_utilisateur)})
            req.executerNoResult()
            uc.updateTelSQLite(self.num_telephone,self.id_utilisateur)
            return true
        } else {
            return false
        }
    }*/
    
    /*public func updatePassword(Context context) -> Void{
        UtilisateurConnection uc = new UtilisateurConnection(context)
        SQLRequest req = new SQLRequest()
        req.prepare("UPDATE UTILISATEUR SET PASSWORD = ? WHERE ID_UTILISATEUR=?")
        req.addParametres(new String[]{self.password, String.valueOf(self.id_utilisateur)})
        req.executerNoResult()
        uc.updatePasswordSQLite(self.password,self.id_utilisateur)
    }*/
    
    /*
     Update user without checking the data
     */
    public func update() -> Void{
        let req:SQLRequest = SQLRequest()
        req.prepare(requete:"UPDATE UTILISATEUR SET NOM_UTILISATEUR = ?, PRENOM_UTILISATEUR=?, ADRESSE_EMAIL = ?,NUM_TELEPHONE=?, PASSWORD=? WHERE ID_UTILISATEUR=?")
        req.addParametres(parametre:[self.nom_utilisateur, self.prenom_utilisateur,self.adresse_email,self.num_telephone,self.password,String(self.id_utilisateur)])
        req.executerNoResult()
    }
    
    public func setId_utilisateur(id_utilisateur:Int)  -> Void{
        self.id_utilisateur = id_utilisateur
    }
    
    public func setNom_utilisateur(nom_utilisateur:String) -> Void {
        self.nom_utilisateur = nom_utilisateur
    }
    
    public func setPrenom_utilisateur(prenom_utilisateur:String)  -> Void{
        self.prenom_utilisateur = prenom_utilisateur
    }
    
    public func setAdresse_email(adresse_email:String)  -> Void{
        self.adresse_email = adresse_email
    }
    
    public func setNum_telephone(num_telephone:String)  -> Void{
        self.num_telephone = num_telephone
    }
    
    public func setPassword(password:String)  -> Void{
        self.password = password
    }
    
    public func setId_image(id_image:Int)  -> Void{
        self.id_image = id_image
    }
    
    public func getId_utilisateur() -> Int {
        return id_utilisateur
    }
    
    public func getNom_utilisateur() -> String{
        return nom_utilisateur
    }
    
    public func getPrenom_utilisateur() -> String{
        return prenom_utilisateur
    }
    
    public func getAdresse_email() -> String{
        return adresse_email
    }
    
    public func getNum_telephone() -> String{
        return num_telephone
    }
    
    public func getPassword() -> String{
        return password
    }
    
    public func getId_image() -> Int{
        return id_image
    }
    
}
