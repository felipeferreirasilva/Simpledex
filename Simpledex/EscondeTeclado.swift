//
//  EscondeTeclado.swift
//  Pokedex
//
//  Created by Felipe Silva on 01/06/17.
//  Copyright © 2017 Felipe Silva. All rights reserved.
//

import UIKit

extension MainVC {
    @objc func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(MainVC.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
