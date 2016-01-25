//
//  ViewController.swift
//  Tarea2Process
//
//  Created by Allan Mora Brenes on 1/22/16.
//  Copyright © 2016 Allan Mora Brenes. All rights reserved.
//

import UIKit


class ViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var txtISBN: UITextField!
    var ResultBook = clsBook()
    override func viewWillAppear(animated: Bool) {
        txtISBN.text=""
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        let code = textField.text
        let urls = "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:" + code!
        let url = NSURL(string:urls)
        let datos:NSData? = NSData(contentsOfURL: url!)
        if datos != nil{
            
            ProcessResult(datos!,ISBN:String(code!))
        }
        else
        {
            alertaDeError()
        }
        textField.resignFirstResponder()
        return true
    }
    func alertaDeError(){
        let alerta = UIAlertController(title: "Error de conexión", message: "Verifique su conexion a internet", preferredStyle: UIAlertControllerStyle.Alert)
        alerta.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
            alerta.dismissViewControllerAnimated(true, completion: nil)
        }))
        presentViewController(alerta, animated: true, completion: nil)
    }
    
    func ProcessResult(result: NSData,ISBN : String)
    {

        if result.length > 0
        {
            
            do {
                let json = try NSJSONSerialization.JSONObjectWithData(result, options: NSJSONReadingOptions.MutableLeaves)
                let jSONData = json as! NSDictionary
                if let BookData = jSONData["ISBN:"+ISBN] as? NSDictionary
                {
                    if let title = BookData["title"] as? String
                    {
                        ResultBook.title=title
                    }
                    
                    if let covers = BookData["cover"] as? NSDictionary
                    {
                    ResultBook.UrlCover=covers["medium"] as! String
                    }
                    if let authors = BookData["authors"] as? NSDictionary
                    {
                        if let aut_names = authors["name"] as? [[String: AnyObject]] {
                            for name in aut_names {
                                if let name = name["name"] as? String {
                                    ResultBook.autors += name+"\n"
                                }
                            }
                        }
                    }
                    
                }
            } catch {
                print("error serializing JSON: \(error)")
            }
            
        }
        else
        {
            ResultBook.title = "No se encontraron datos"
            
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let result : ViewResult = segue.destinationViewController as! ViewResult
        result.BookData = ResultBook
    }
}


