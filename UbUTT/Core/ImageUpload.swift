//
//  ImageUpload.swift
//  UbUTT
//
//  Created by if26-grp1 on 17/12/2019.
//  Copyright © 2019 BourdelatPieret. All rights reserved.
//

import Foundation


public class ImageUpload{
    private var data:NSData
    
    init(data:NSData){
        self.data=data
    }

    public func upload() -> String{
        let now = Date()
        let format = DateFormatter()
        format.dateFormat = "dd-MM-yyyy"
        let mdp:String = BDConnection.sha512(string:"GE"+format.string(from:now)+"IF26")
        let name = String(NSDate().timeIntervalSince1970 * 1000)+".jpg"
        let strBase64 = data.base64EncodedString(options: .lineLength64Characters)
        let params = ["base64":strBase64,"mdp":mdp,"ImageName":name]
        
        var request = URLRequest(url: URL(string: "https://appliweb.000webhostapp.com/if26/postImageIOS.php")!)
        request.httpMethod = "POST"
        request.cachePolicy = URLRequest.CachePolicy.reloadIgnoringLocalCacheData
        request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        //request.httpBody = params.data(using: String.Encoding.utf8)
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")

        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            let httpResponse = response as! HTTPURLResponse
            print("response image code = \(httpResponse.statusCode)")
            
            guard error == nil else {
                print(error!)
                return
            }
        }
        
        task.resume()
        
        return name;
    }
}
