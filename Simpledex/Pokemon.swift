//
//  Pokemon.swift
//  Pokedex
//
//  Created by Felipe Silva on 30/05/17.
//  Copyright © 2017 Felipe Silva. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon{
    private var _nome: String!
    private var _id: Int!
    private var _imagemNormal: UIImage!
    private var _imagemShiny: UIImage!
    private var _tipo1: String!
    private var _tipo2: String!
    private var _pokemonAtual: Int = 1

    var nome: String{
        get{
            return _nome
        }set{
            _nome = newValue
        }
    }
    
    var id: Int{
        get{
            return _id
        }set{
            _id = newValue
        }
    }
    
    var imagemNormal: UIImage{
        get{
            return _imagemNormal!
        }set{
            _imagemNormal = newValue
        }
    }
    
    var imagemShiny: UIImage{
        get{
            return _imagemShiny!
        }set{
            _imagemShiny = newValue
        }
    }
    
    var tipo1: String{
        get{
            return _tipo1
        }set{
            _tipo1 = newValue
        }
    }
    
    var tipo2: String{
        get{
            return _tipo2
        }set{
            _tipo2 = newValue
        }
    }
    
    var pokemonAtual: Int{
        get{
            return _pokemonAtual
        }set{
            _pokemonAtual = newValue
        }
    }

    func buscarPokemon(_ pokemon: String, completed: @escaping CompletedDownload){
        Alamofire.request(URLSERVICE + pokemon).responseJSON { response in
            if let JSON = response.result.value as? [String: Any] {
                // VERIFICA SE O JSON ENCONTROU RESULTADO
                if (JSON.count) > 1 {
                    
                    // NOME
                    if let nome = JSON["name"]{
                        self.nome = nome as! String
                    }
                    
                    // ID
                    
                    if let id = JSON["id"]{
                        self._id = id as! Int
                    }
                    
                    // SPRITES
                    let sprites = JSON["sprites"] as! [String: Any]
                    
                    // FOTO FRONTAL NORMAL
                    let urlSpriteFrontal = sprites["front_default"] as? String
                    if (urlSpriteFrontal != nil){
                        let imageNormal = try? Data(contentsOf: (urlSpriteFrontal?.asURL())!)
                        self.imagemNormal = UIImage(data: imageNormal!)!
                    }else{
                        self.imagemNormal = #imageLiteral(resourceName: "blank")
                    }
                    
                    // FOTO FRONTAL SHINY
                    let urlSpriteFrontalShiny = sprites["front_shiny"] as? String
                    if (urlSpriteFrontalShiny != nil){
                        let imageShiny = try? Data(contentsOf: (urlSpriteFrontalShiny?.asURL())!)
                        self.imagemShiny = UIImage(data: imageShiny!)!
                    }else{
                        self.imagemShiny = #imageLiteral(resourceName: "blank")
                    }
                    
                    // CAPTURA TIPOS DO POKEMON DO JSON
                    let tiposArray = JSON["types"] as! NSArray
                    var tipos = [[String: Any]]()
                    for i in 0..<tiposArray.count{
                        tipos.append(tiposArray[i] as! [String: Any])
                    }
                    
                    var tipo = [[String: String]]()
                    for i in 0..<tipos.count{
                        tipo.append(tipos[i]["type"] as! [String: String])
                    }
                    
                    if tipo.count == 2{
                        self.tipo1 = tipo[0]["name"]!.uppercased()
                        self.tipo2 = tipo[1]["name"]!.uppercased()
                    }else if tipo.count == 1{
                        self.tipo1 = tipo[0]["name"]!.uppercased()
                    }
                    
                    // ATUALIZA POKEMON ATUAL
                    self.pokemonAtual = self.id
                }
                completed()
            }
        }
    }
}









