//
//  Image.swift
//  UbUTT
//
//  Created by if26-grp1 on 26/11/2019.
//  Copyright © 2019 BourdelatPieret. All rights reserved.
//

import Foundation
import UIKit

/**
 * Classe contenant l'url d'une image
 */
public class Image:Entity {
    private var id_image:Int
    private var image_url:String
    private var image:UIImage?
    
    required init(){
        self.id_image=0
        self.image_url=""
        super.init()
    }
    
    required init( dictionary: [String : Any]){
        self.id_image=Int(dictionary["id_image"] as? String ?? "0")!
        self.image_url=dictionary["image_url"] as? String ?? ""
        super.init(dictionary: dictionary)
    }
    
    public func getId_image() -> Int{
        return id_image
    }
    
    public func getImage_url() -> String{
        return image_url
    }
    
    public func setId_image(id_image:Int) -> Void{
        self.id_image = id_image
    }
    
    public func setImage_url(image_url:String) -> Void{
        self.image_url = image_url
    }
    
    private func getImageFromURL(){
            DispatchQueue.global().sync { [weak self] in
                if let data = try? Data(contentsOf: URL(string: self!.image_url)!) {
                    if let image = UIImage(data: data) {
                        self?.image = image
                    }
                }
            }
    }
    
    public func getImage() -> UIImage?{
        if(self.image == nil){
            getImageFromURL()
        }
        return self.image
    }
    
    
    public func setImage(image:UIImage){
        self.image=image
    }
    
    public func upload() -> Void{
        if(image != nil){
            let data:NSData = self.image!.jpegData(compressionQuality: 0.5)! as NSData
            let imageUpload:ImageUpload = ImageUpload(data: data)
            self.image_url = "https://appliweb.000webhostapp.com/if26/images/"+imageUpload.upload()
            
            let req:SQLRequest  = SQLRequest()
            req.prepare(requete: "INSERT INTO IMAGE(IMAGE_URL) VALUES (?)")
            req.addParametres(parametre: [self.image_url])
            req.executerNoResult()
            
            let req2:SQLRequest<Image> = SQLRequest()
            req2.prepare(requete: "SELECT * FROM IMAGE WHERE IMAGE_URL LIKE ?")
            req2.addParametres(parametre: [self.image_url])
            self.id_image = req2.executerOneResult()!.getId_image()
        }
    }
}
