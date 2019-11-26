//
//  Image.swift
//  UbUTT
//
//  Created by if26-grp1 on 26/11/2019.
//  Copyright © 2019 BourdelatPieret. All rights reserved.
//

import Foundation

/**
 * Classe contenant l'url d'une image
 */
public class Image { //extends AsyncTask<Void, Void, Bitmap>
    private var id_image:Int
    private var image_url:String
    private var image_bitmap:Bitmap
    
    init(){}
    
    /*@Override
    protected Bitmap doInBackground(Void... voids) {
        return getBitmapFromURL()
    }*/
    
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
    
    private func getBitmapFromURL() -> Bitmap{
        if(image_bitmap == NSNull) {
            try {
                URL url = new URL(image_url)
                URLConnection con = url.openConnection()
                con.connect()
                InputStream is = con.getInputStream()
                BufferedInputStream bis = new BufferedInputStream(is)
                self.image_bitmap = BitmapFactory.decodeStream(bis)
                bis.close()
                is.close()
            } catch (MalformedURLException e) {
                e.printStackTrace()
            } catch (IOException e) {
                e.printStackTrace()
            }
        }
        return image_bitmap
    }
    
    public func getImageBitmap() -> Bitmap{
        try {
            return self.execute().get()
        } catch (ExecutionException e) {
            e.printStackTrace()
        } catch (InterruptedException e) {
            e.printStackTrace()
        }
        return null
    }
    
    public func setImageBitmap(image:Bitmap) -> Void{
        self.image_bitmap=image
    }
    
    public func upload() -> Void{
        ByteArrayOutputStream bao = new ByteArrayOutputStream()
        self.image_bitmap.compress(Bitmap.CompressFormat.JPEG,90,bao)
        byte[] ba = bao.toByteArray()
        ImageUpload imageUpload = new ImageUpload(ba)
        try {
            self.image_url = "https://appliweb.000webhostapp.com/if26/images/"+imageUpload.execute().get()
    
            SQLRequest req = new SQLRequest()
            req.prepare("INSERT INTO IMAGE(IMAGE_URL) VALUES (?)")
            req.addParametres(new String[]{self.image_url})
            req.executerNoResult()
    
            SQLRequest<Image> req2= new SQLRequest<>(Image.class)
            req2.prepare("SELECT * FROM IMAGE WHERE IMAGE_URL LIKE ?")
            req2.addParametres(new String[]{self.image_url})
            self.id_image = req2.executerOneResult().getId_image()
    
        } catch (ExecutionException e) {
            e.printStackTrace()
        } catch (InterruptedException e) {
            e.printStackTrace()
        }
    }
}
