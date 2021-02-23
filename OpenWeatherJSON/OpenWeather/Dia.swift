//
//  Dia.swift
//  OpenWeather
//
//  Created by Sara Gil González on 16/2/21.
//  Copyright © 2021 Sara Gil González. All rights reserved.
//

import UIKit

class Dia: NSObject {
    var fecha:String = ""
    var icon:String = ""
    var max:String = ""
    var min:String = ""
    var preci:String = ""
    var prono:String = ""
    func toString() -> String {
        return "fecha:\(fecha), icon:\(icon), max: \(max), min: \(min), preci: \(preci), prono: \(prono)"
    }
}

