//
//  Manager.swift
//  ptplayer
//
//  Created by Bruno Garelli on 2/23/17.
//
//
import FirebaseDatabase
//import Foundation
@objc class Manager: NSObject {
    var currentUser: Usuario?
    let users: FIRDatabaseReference = FirebaseRef.child("users")
    static let sharedManager = Manager()
    private override init() {
        super.init()
    }
    func obtenerUsuario(_ uid: String, finalizar: @escaping (Usuario?) -> ()) {
        users.keepSynced(true)
        users.observe(.value, with: { (captura) in
            if captura.hasChild(uid) {
                let capturaUsuario = captura.childSnapshot(forPath: uid)
                if capturaUsuario.hasChild("musico") {
                    if (capturaUsuario.childSnapshot(forPath: "musico").value! as? Int)! == 0 {
                        if capturaUsuario.hasChild("ciudad") {
                            finalizar(Usuario(snapshot: capturaUsuario))
                        }
                    } else {
                        /*if capturaUsuario.hasChilds("genero", "ciudad", "estrellas") && capturaUsuario.hasChild("voces") {
                        } else {
                            return // esperar otro update del server
                        }*/
                        finalizar(Usuario(snapshot: capturaUsuario))
                    }
                } else {
                    return // esperar otro update del server
                }
            }
        })
    }
}
