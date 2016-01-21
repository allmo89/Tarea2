//
//  ViewController.swift
//  Tarea 2
//
//  Created by Allan Mora Brenes on 1/21/16.
//  Copyright (c) 2016 Allan Mora Brenes. All rights reserved.
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
        let urls = "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:\(code)"
        let url = NSURL(string:urls)
        let datos:NSData? = NSData(contentsOfURL: url!)
        if datos != nil{
         
            ProcessResult(datos!)
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
    
    func ProcessResult(result: NSData)
    {
    var ParseError: NSError
     if result.length > 0
     {
     ResultBook.title = txtISBN.text

        
     }
        else
     {
     ResultBook.title = "No se encontraron datos"
        
        }
     
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
        var result : ViewResult = segue.destinationViewController as! ViewResult
        result.BookData = ResultBook
    }
}

