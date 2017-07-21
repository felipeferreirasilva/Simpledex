//
//  ViewController.swift
//  Simpledex
//
//  Created by Felipe Silva on 20/07/17.
//  Copyright © 2017 Felipe Silva. All rights reserved.
//

import UIKit

class MainVC: UIViewController {
    @IBOutlet weak var idLbl: UILabel!
    @IBOutlet weak var nomeLbl: UILabel!
    @IBOutlet weak var tipo1Lbl: UILabel!
    @IBOutlet weak var tipo2Lbl: UILabel!
    @IBOutlet weak var imagemNormal: UIImageView!
    @IBOutlet weak var imagemShiny: UIImageView!
    @IBOutlet weak var buscaTxtField: UITextField!
    @IBOutlet weak var buscarBtn: UIButton!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    var pokemon = Pokemon()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        pokemon.buscarPokemon("1"){
            self.carregaDadosPokemon()
            self.loading.stopAnimating()
        }
    }
    
    @IBAction func returnKeyKeyboardPressed(_ sender: Any) {
        buscarBtnPressed(sender)
    }
    
    @IBAction func buscarBtnPressed(_ sender: Any) {
        let pkm = buscaTxtField.text?.lowercased()
        if !pkm!.isEmpty{
            loading.startAnimating()
            pokemon.buscarPokemon(pkm!){
                self.carregaDadosPokemon()
                self.loading.stopAnimating()
            }
        }
        dismissKeyboard()
    }
    
    @IBAction func proximoBtnPressed(_ sender: Any) {
        loading.startAnimating()
        let nextPokemon = (pokemon.pokemonAtual + 1)
        pokemon.buscarPokemon(String(nextPokemon)){
            self.carregaDadosPokemon()
            self.loading.stopAnimating()
        }
    }
    
    @IBAction func anteriorBtnPressed(_ sender: Any) {
        loading.startAnimating()
        let previousPokemon = (pokemon.pokemonAtual - 1)
        pokemon.buscarPokemon(String(previousPokemon)){
            self.carregaDadosPokemon()
            self.loading.stopAnimating()
        }
    }
    
    @objc func carregaDadosPokemon(){
        nomeLbl.text = pokemon.nome.uppercased()
        idLbl.text = String(pokemon.id)
        tipo1Lbl.text = pokemon.tipo1
        tipo2Lbl.text = pokemon.tipo2
        imagemNormal.image = pokemon.imagemNormal
        imagemShiny.image = pokemon.imagemShiny
    }
}

