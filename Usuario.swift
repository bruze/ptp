//
//  Usuario.swift
//  TuSerenata
//
//  Created by Bruno Garelli on 9/19/16.
//  Copyright © 2016 Bruno Garelli. All rights reserved.
//
//import JSQMessagesViewController
import FirebaseDatabase

@objc class Usuario: NSObject {
    let key: String!
    var nombre: String
    var puntos: Int
    //var ciudad: String
    //var sexo: String
    let ref: FIRDatabaseReference?
    
    // Initialize from arbitrary data
    init(nombre: String, ciudad: String, sexo: String, completed: Bool, key: String = "", puntos: Int = 0) {
        self.key = key
        self.nombre = nombre
        //self.ciudad = ciudad
        //self.sexo = sexo
        self.puntos = puntos
        //self.completed = completed
        self.ref = nil
        super.init()
    }

    init(snapshot: FIRDataSnapshot) {
         key    = snapshot.key
        nombre  = anytool.dicstrany(any: snapshot.value!)["nombre"] as! String
        //ciudad  = anytool.dicstrany(any: snapshot.value!)["ciudad"] as! String
        puntos = 0
        if snapshot.hasChild("points") {
            puntos  = anytool.dicstrany(any: snapshot.value!)["points"] as! Int
        }
        //sexo = ""
        /*if snapshot.hasChild("sexo") {
            sexo   = anytool.dicstrany(any: snapshot.value!)["sexo"] as! String
        }*/
        ref = snapshot.ref
        super.init()
    }
    
    func toAnyObject() -> AnyObject {
        return ([
            "nombre": nombre,
            "puntos": puntos
            //"ciudad": ciudad,
            //"sexo": sexo,
            //"musico": 0
            //"genero": genero,
            //"completed": completed
        ] as AnyObject)
    }
}
