//
//  UtilisateurConnection.swift
//  UbUTT
//
//  Created by if26-grp1 on 05/12/2019.
//  Copyright © 2019 BourdelatPieret. All rights reserved.
//

import Foundation

public class UtilisateurConnection {
    private let sql:SQLiteConnection
    
    /**
     * Constructeur permettant de se connecter à la base de données SQLite
     */
    init(){
        self.sql = SQLiteConnection()
    }
    
    /**
     * Vérifie si un utilisateur est enregistré dans la base SQLite
     * @return true si connecté
     */
    public func isConnected() -> Bool{
        self.sql.prepare(queryString: "SELECT ID_UTILISATEUR FROM UTILISATEUR")
        self.sql.execute()
        let res:Bool = self.sql.readText(column: 0) != nil
        self.sql.close()
        return res
    }
    
    /**
     * Rétourne un utilisateur correspondant à l'utilisateur enregistré en base SQLite si le mot de
     * passe et num de téléphone son correct
     * @return l'utilisateur connecté
     */
    public func getUtilisateurConnecte() -> Utilisateur?{
        var res:Utilisateur?
        if(isConnected()){
            self.sql.prepare(queryString: "SELECT NUM_TELEPHONE, PASSWORD, ID_UTILISATEUR FROM UTILISATEUR")
            self.sql.execute()
            if(self.sql.readText(column: 0) != nil && self.sql.readText(column: 1) != nil && self.sql.readText(column: 2) != nil){
                var params:Array<String> = [self.sql.readText(column: 0)!,self.sql.readText(column: 1)!,self.sql.readText(column: 2)!]
                let req:SQLRequest<Utilisateur> =  SQLRequest()
                req.prepare(requete:"SELECT * FROM UTILISATEUR WHERE NUM_TELEPHONE LIKE ? AND PASSWORD LIKE ? AND ID_UTILISATEUR = ?")
                req.addParametres(parametre: params)
                res = req.executerOneResult()
            }
            self.sql.close()
        }
        return res
    }
    
    /**
     * Supprime l'utilisateur enregistré dans la base SQLite
     */
    public func disconnect() -> Void{
        self.sql.prepare(queryString: "DELETE FROM UTILISATEUR")
        self.sql.execute()
        self.sql.close()
    }
    
    /**
     * Vérifie si le couplet num de tel et password son correct par rapport à la base distante,
     * retourne l'utilisateur si correct et enregistre l'utilisateur dans la base SQLite
     * @param num_telephone
     * @param password Mot de passe non hashé
     * @return un objet utilisateur correspondant
     */
    public func connection( num_telephone:String,  password:String) -> Utilisateur?{
        var utilisateur:Utilisateur?
        let pass:String = BDConnection.sha512(string:password)
        let req:SQLRequest<Utilisateur> =  SQLRequest()
        req.prepare(requete:"SELECT * FROM UTILISATEUR WHERE NUM_TELEPHONE LIKE ? AND PASSWORD LIKE ?")
        req.addParametres(parametre:[num_telephone,pass])
        utilisateur = req.executerOneResult()
        if(utilisateur != nil){
            self.sql.prepare(queryString: "INSERT INTO UTILISATEUR(ID_UTILISATEUR, NUM_TELEPHONE, PASSWORD) VALUES (?,?,?)")
            self.sql.addParamInt(param: utilisateur!.getId_utilisateur())
            self.sql.addParamText(param: utilisateur!.getNum_telephone())
            self.sql.addParamText(param: utilisateur!.getPassword())
            self.sql.execute()
            self.sql.close()
        }
        return utilisateur
    }
    
    /**
     * Enregistre un nouvel utilisateur sur la base distante si aucun utilisateur avec num de tel
     * et email ne correspondent, connecte l'utilisateur et retourne un object Utilisateur
     * corresondant
     *
     * @param nom
     * @param prenom
     * @param email
     * @param num_tel
     * @param password Mot de passe non hashé
     * @return un objet utilisateur correspondant au nouvel utilisateur
     */
    public func register( nom:String,  prenom:String, email:String, num_tel:String,  password:String) -> Utilisateur?{
        var utilisateur:Utilisateur?
        if(!alreadyExist(email:email,num_tel:num_tel)){
            let req:SQLRequest =  SQLRequest()
            req.prepare(requete:"INSERT INTO UTILISATEUR(NOM_UTILISATEUR, PRENOM_UTILISATEUR, ADRESSE_EMAIL,NUM_TELEPHONE,PASSWORD) " +
            "VALUES (?,?,?,?,?)")
            req.addParametres(parametre: [nom,prenom,email,num_tel,BDConnection.sha512(string:password)])
            req.executerNoResult()
            utilisateur=self.connection(num_telephone:num_tel,password:password)
        }
        return utilisateur
    }
    
    /**
     * Vérifie si l'utilisateur n'existe pas déjà (email, num de tel)
     * @param email
     * @param num_tel
     * @return true si existe déjà
     */
    public func alreadyExist( email:String, num_tel:String) -> Bool{
        let req:SQLRequest<Utilisateur> = SQLRequest()
        req.prepare(requete:"SELECT * FROM UTILISATEUR WHERE NUM_TELEPHONE LIKE ? OR ADRESSE_EMAIL LIKE ?")
        req.addParametres(parametre: [num_tel,email])
        return req.executerOneResult() != nil
    }
    
    /**
     * Vérifie si l'utilisateur n'existe pas déjà (email)
     * @param email
     * @return true si existe déjà
     */
    public func alreadyExistEmail(email:String) -> Bool{
        let req:SQLRequest<Utilisateur> = SQLRequest()
        req.prepare(requete:"SELECT * FROM UTILISATEUR WHERE ADRESSE_EMAIL LIKE ?")
        req.addParametres(parametre: [email])
        return req.executerOneResult() != nil
    }
    
    /**
     * Vérifie si l'utilisateur n'existe pas déjà (tel)
     * @param tel
     * @return true si existe déjà
     */
    public func alreadyExistTel(tel:String) -> Bool{
        let req:SQLRequest<Utilisateur> = SQLRequest()
        req.prepare(requete:"SELECT * FROM UTILISATEUR WHERE NUM_TELEPHONE LIKE ?")
        req.addParametres(parametre: [tel])
        return req.executerOneResult() != nil
    }
    
    public func updateTelSQLite( tel:String, id:Int){
        self.sql.prepare(queryString: "UPDATE UTILISATEUR SET NUM_TELEPHONE=? WHERE ID_UTILISATEUR=?")
        self.sql.addParamText(param: tel)
        self.sql.addParamInt(param: id)
        self.sql.execute()
        self.sql.close()
    }
    
    public func updatePasswordSQLite( password:String, id:Int){
        self.sql.prepare(queryString: "UPDATE UTILISATEUR SET PASSWORD=? WHERE ID_UTILISATEUR=?")
        self.sql.addParamText(param: password)
        self.sql.addParamInt(param: id)
        self.sql.execute()
        self.sql.close()
    }
}
