//
//  ViewResult.swift
//  Tarea 2
//
//  Created by Allan Mora Brenes on 1/21/16.
//  Copyright (c) 2016 Allan Mora Brenes. All rights reserved.
//

import Foundation
import UIKit

class ViewResult: UIViewController{

    @IBOutlet weak var txtResult: UITextView!
    
    @IBOutlet weak var PicCover: UIImageView!
    
    var BookData = clsBook()
    
    override func  viewDidLoad() {
        txtResult.text = BookData.title
    }
}