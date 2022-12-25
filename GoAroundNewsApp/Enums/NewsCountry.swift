//
//  NewsCountry.swift
//  GoAroundNewsApp
//
//  Created by Dyana Varghese on 21/12/22.
//

import Foundation


enum NewsCountry: String, CaseIterable, Codable {
    var name: String {
        get { return String(describing: self) }
    }
    
    case UAE = "ae"
    case Argentina = "ar"
    case Austria = "at"
    case Australia = "au"
    case Belgium = "be"
    case Bulgaria = "bg"
    case Brazil = "br"
    case Canada = "ca"
    case Switzerland = "ch"
    case China = "cn"
    case Colombia = "co"
    case Cuba = "cu"
    case Czechia = "cz"
    case Germany = "de"
    case Egypt = "eg"
    case France = "fr"
    case UK = "gb"
    case Greece = "gr"
    case HongKong = "hk"
    case Hungary = "hu"
    case Indonesia = "id"
    case Ireland = "ie"
    case Israel = "il"
    case India = "in"
    case Italy = "it"
    case Japan = "jp"
    case Korea = "kr"
    case Lithuania = "lt"
    case Latvia = "lv"
    case Morocco = "ma"
    case Mexico = "mx"
    case Malaysia = "my"
    case Nigeria = "ng"
    case Netherlands = "nl"
    case Norway = "no"
    case NewZealand = "nz"
    case Philipines = "ph"
    case Poland = "pl"
    case Portugal = "pt"
    case Romania = "ro"
    case Serbia = "rs"
    case Russia = "ru"
    case SaudiArabia = "sa"
    case Sweden = "se"
    case Singapore = "sg"
    case Slovenia = "si"
    case Slovakia = "sk"
    case Thailand = "th"
    case Turkey = "tr"
    case Taiwan = "tw"
    case Ukraine = "ua"
    case USA = "us"
    case Venezuela = "ve"
    case SouthAfrica = "za"
}
