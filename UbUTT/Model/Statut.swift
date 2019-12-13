//
//  Statut.swift
//  UbUTT
//
//  Created by if26-grp1 on 26/11/2019.
//  Copyright © 2019 BourdelatPieret. All rights reserved.
//

import Foundation

/**Classe représentant un statut de course
 *
 */
public class Statut:Entity {
    private var id_statut:Int
    private var statut:String
    
    required init(){
        self.id_statut=0
        self.statut=""
        super.init()
    }
    
    required init( dictionary: [String : Any]){
        self.id_statut=Int(dictionary["id_statut"] as? String ?? "0")!
        self.statut=dictionary["statut"] as? String ?? ""
        super.init(dictionary: dictionary)
    }
    
    
    public static func getBDStatutByID(id:Int) -> Statut?{
        let req:SQLRequest<Statut> = SQLRequest()
        req.prepare(requete:"SELECT * FROM STATUT WHERE ID_STATUT= ?")
        req.addParametres(parametre: [String(id)])
        return req.executerOneResult()
    }
    
    public func getId_statut() -> Int{
        return id_statut
    }
    
    public func getStatut() -> String{
        return statut
    }
    
    public func setId_statut(id_statut:Int) -> Void{
        self.id_statut = id_statut
    }
    
    public func setStatut(statut:String) -> Void{
        self.statut = statut
    }
}
