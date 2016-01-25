//
//  ViewResult.swift
//  Tarea2Process
//
//  Created by Allan Mora Brenes on 1/22/16.
//  Copyright © 2016 Allan Mora Brenes. All rights reserved.
//

import Foundation
import UIKit

class ViewResult: UIViewController{
    
    var BookData = clsBook()
    
    @IBOutlet weak var txtResult: UITextView!
    @IBOutlet weak var IVCover: UIImageView!
    override func  viewDidLoad() {
      
        if(!BookData.UrlCover.isEmpty)
        {
        if let checkedUrl = NSURL(string:BookData.UrlCover)
        {
            IVCover.contentMode = .ScaleAspectFit
            downloadImage(checkedUrl)
        }

        }
        else
        {
            IVCover.image = UIImage(named: "NoDisponible")
            
        }
        var Resultado = String()
        Resultado += "Titulo:\n"
        Resultado += BookData.title + "\n"
        Resultado += "Autores:\n"
        Resultado += BookData.autors
        txtResult.text = Resultado
    
    }
    
    func getDataFromUrl(url:NSURL, completion: ((data: NSData?, response: NSURLResponse?, error: NSError? ) -> Void)) {
        NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
            completion(data: data, response: response, error: error)
            }.resume()
    }
    func downloadImage(url: NSURL){
        print("Download Started")
        print("lastPathComponent: " + (url.lastPathComponent ?? ""))
        getDataFromUrl(url) { (data, response, error)  in
            dispatch_async(dispatch_get_main_queue()) { () -> Void in
                guard let data = data where error == nil else { return }
                print(response?.suggestedFilename ?? "")
                print("Download Finished")
                self.IVCover.image = UIImage(data: data)
            }
        }
    }
}