//
//  RoundedImage.swift
//  Pokedex
//
//  Created by Felipe Silva on 30/05/17.
//  Copyright © 2017 Felipe Silva. All rights reserved.
//

import UIKit

class ImagemArredondada: UIImageView {
    
    override func awakeFromNib() {
        self.layer.cornerRadius = 10
    }
}
