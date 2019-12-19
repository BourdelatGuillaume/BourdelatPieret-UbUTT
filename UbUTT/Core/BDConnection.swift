//
//  BDConnection.swift
//  UbUTT
//
//  Created by if26-grp3 on 28/11/2019.
//  Copyright © 2019 BourdelatPieret. All rights reserved.
//

import Foundation
import CommonCrypto

public class BDConnection{
    
    private func connexionPage(page:String, requete:String, parametres:String) -> Data?{
        let now = Date()
        let format = DateFormatter() 
        format.dateFormat = "dd-MM-yyyy"
        var mdp:String = BDConnection.sha512(string:"GE"+format.string(from:now)+"IF26"+requete+parametres)
        //let params="requete="+requete+"&mdp="+mdp
        let params = ["requete":requete,"mdp":mdp,"parametre":parametres]
        
        var request = URLRequest(url: URL(string: page)!)
        request.httpMethod = "POST"
        request.cachePolicy = URLRequest.CachePolicy.reloadIgnoringLocalCacheData
        request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        //request.httpBody = params.data(using: String.Encoding.utf8)
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        var res:Data?
        let sem = DispatchSemaphore(value: 0)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            defer { sem.signal() }
            //print(response!)
            if(response != nil){
                let httpResponse = response as! HTTPURLResponse
                print("response code = \(httpResponse.statusCode)")
            }
            //let dataRes:Data? = "[{\"id_utilisateur\": \"1\",\"nom_utilisateur\": \"Bob\",\"prenom_utilisateur\": \"Erwan\",\"adresse_email\": \"bob.erwan@gmail.com\",\"num_telephone\": \"+33606407808\",\"password\": \"test1234\",\"id_image\": \"0\"}]".data(using: .utf8)
            
            //print(String(decoding:data!,as:UTF8.self))
            
            guard error == nil else {
                print(error!)
                return
            }
            
            guard let json = data else {
                print("No data")
                return
            }
            
            guard json.count != 0 else {
                print("Zero bytes of data")
                return
            }
            
            res = json
            //print(String(decoding: json, as: UTF8.self))
        }
        
        task.resume()
        sem.wait(timeout:DispatchTime.distantFuture)
        return res
    }
    
    public func execute(page:String,requete:String, parametres:String)->Data?{
        return self.connexionPage(page: page, requete: requete, parametres: parametres)
    }
    
    public static func sha512(string: String) -> String {
        var digest = [UInt8](repeating: 0, count: Int(CC_SHA512_DIGEST_LENGTH))
        if let data = string.data(using: String.Encoding.utf8) {
            data.withUnsafeBytes {
                _ = CC_SHA512($0, CC_LONG(data.count), &digest)
            }
        }
        
        var digestHex = ""
        for index in 0..<Int(CC_SHA512_DIGEST_LENGTH) {
            digestHex += String(format: "%02x", digest[index])
        }
        
        return digestHex
    }
}
