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
public class Statut {
    private var id_statut:Int
    private var statut:String
    
    init(){
        self.id_statut=0
        self.statut=""
    }
    
    /*
    public static func getBDStatutByID(id:Int) -> Statut{
        SQLRequest<Statut> req = new SQLRequest<>(Statut.class)
        req.prepare("SELECT * FROM STATUT WHERE ID_STATUT= ?")
        req.addParametres(new String[]{String.valueOf(id)})
        return req.executerOneResult()
    }*/
    
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
