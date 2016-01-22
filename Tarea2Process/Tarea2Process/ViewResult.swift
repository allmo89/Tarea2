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
        txtResult.text = BookData.title
    }
}