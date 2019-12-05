//
//  UtilisateurConnection.swift
//  UbUTT
//
//  Created by if26-grp1 on 05/12/2019.
//  Copyright © 2019 BourdelatPieret. All rights reserved.
//

import Foundation

public class UtilisateurConnection {
    //private SQLiteConnection sqlConnection
    
    /**
     * Constructeur permettant de se connecter à la base de données SQLite
     * @param context
     */
    init(){
        
    }
    
    /*public UtilisateurConnection(Context context){
    this.sqlConnection = new SQLiteConnection(context)
    }*/
    
    /**
     * Vérifie si un utilisateur est enregistré dans la base SQLite
     * @return true si connecté
     */
    public func isConnected() -> Bool{
        /*SQLiteDatabase dbb = sqlConnection.getWritableDatabase()
        Cursor cursor = dbb.query("UTILISATEUR",new String[]{"ID_UTILISATEUR"},null,null,null,null,null)
        return cursor.getCount()>0*/
        return true
    }
    
    /**
     * Rétourne un utilisateur correspondant à l'utilisateur enregistré en base SQLite si le mot de
     * passe et num de téléphone son correct
     * @return l'utilisateur connecté
     */
    public func getUtilisateurConnecte() -> Utilisateur?{
        var res:Utilisateur?
        if(isConnected()){
            //SQLiteDatabase dbb = sqlConnection.getWritableDatabase()
            //Cursor cursor = dbb.query("UTILISATEUR",new String[]{"ID_UTILISATEUR","NUM_TELEPHONE","PASSWORD"},null,null,null,null,null)
            //cursor.moveToFirst()
            var params:Array<String> = ["+33606407806","3f08b178cf44b2ba1745bd72cf6c7db6f5097385511e85ca9f210f12376ea0a43bc8323b0ec4a6b92c5ab3912bb7cc1b4b043ac811f664ba4af7f3c51974935c","1"]
            //params[0]=cursor.getString(cursor.getColumnIndex("NUM_TELEPHONE"))
            //params[1]=cursor.getString(cursor.getColumnIndex("PASSWORD"))
            //params[2]=cursor.getString(cursor.getColumnIndex("ID_UTILISATEUR"))
            let req:SQLRequest<Utilisateur> =  SQLRequest()
            req.prepare(requete:"SELECT * FROM UTILISATEUR WHERE NUM_TELEPHONE LIKE ? AND PASSWORD LIKE ? AND ID_UTILISATEUR = ?")
            req.addParametres(parametre: params)
            res = req.executerOneResult()
        }
        return res
    }
    
    /**
     * Supprime l'utilisateur enregistré dans la base SQLite
     */
    public func disconnect() -> Void{
        //SQLiteDatabase dbb = sqlConnection.getWritableDatabase()
        //dbb.delete("UTILISATEUR",null,null)
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
            //SQLiteDatabase dbb = sqlConnection.getWritableDatabase()
            //ContentValues contentValues = new ContentValues()
            //contentValues.put("ID_UTILISATEUR",utilisateur.getId_utilisateur())
            //contentValues.put("NUM_TELEPHONE",utilisateur.getNum_telephone())
            //contentValues.put("PASSWORD",utilisateur.getPassword())
            //dbb.insert("UTILISATEUR",null,contentValues)
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
        //SQLiteDatabase dbb = sqlConnection.getWritableDatabase()
        //ContentValues contentValues = new ContentValues()
        //contentValues.put("NUM_TELEPHONE",tel)
        //dbb.update("UTILISATEUR",contentValues,"ID_UTILISATEUR="+id,null)
    }
    
    public func updatePasswordSQLite( password:String, id:Int){
        //SQLiteDatabase dbb = sqlConnection.getWritableDatabase()
        //ContentValues contentValues = new ContentValues()
        //contentValues.put("PASSWORD",password)
        //dbb.update("UTILISATEUR",contentValues,"ID_UTILISATEUR="+id,null)
    }
}
