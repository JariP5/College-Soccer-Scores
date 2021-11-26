//
//  ChampionshipViewModel.swift
//  College Soccer Scores
//
//  Created by Jari Polm on 20.11.21.
//

import Foundation

class FavoritesModel: ObservableObject {
    @Published var d1Men: [Conference]
    @Published var d2Men: [Conference]
    @Published var d3Men: [Conference]
    @Published var d1Women: [Conference]
    @Published var d2Women: [Conference]
    @Published var d3Women: [Conference]
    
    init(_ d1Men: [Conference], _ d2Men: [Conference], _ d3Men: [Conference], _ d1Women: [Conference], _ d2Women: [Conference], _ d3Women: [Conference]) {
        self.d1Men = d1Men
        self.d2Men = d2Men
        self.d3Men = d3Men
        self.d1Women = d1Women
        self.d2Women = d2Women
        self.d3Women = d3Women
    }
    
    func remove(conf: Conference) {
        if (conf.gender == .men) {
            if conf.division == .DI {
                if let index = d1Men.firstIndex(of: conf) {
                    d1Men.remove(at: index)
                    save(d1Men, conf.gender.rawValue + conf.division.rawValue)
                }
            } else if conf.division == .DII {
                if let index = d2Men.firstIndex(of: conf) {
                    d2Men.remove(at: index)
                    save(d2Men, conf.gender.rawValue + conf.division.rawValue)
                }
            } else {
                if let index = d3Men.firstIndex(of: conf) {
                    d3Men.remove(at: index)
                    save(d3Men, conf.gender.rawValue + conf.division.rawValue)
                }
            }
        } else if (conf.gender == .women) {
            if conf.division == .DI {
                if let index = d1Women.firstIndex(of: conf) {
                    d1Women.remove(at: index)
                    save(d1Women, conf.gender.rawValue + conf.division.rawValue)
                }
            } else if conf.division == .DII {
                if let index = d2Women.firstIndex(of: conf) {
                    d2Women.remove(at: index)
                    save(d2Women, conf.gender.rawValue + conf.division.rawValue)
                }
            } else {
                if let index = d3Women.firstIndex(of: conf) {
                    d3Women.remove(at: index)
                    save(d3Women, conf.gender.rawValue + conf.division.rawValue)
                }
            }
        }
    }
    
    func append(conf: Conference) {
        if (conf.gender == .men) {
            if conf.division == .DI {
                d1Men.append(conf)
                save(d1Men, conf.gender.rawValue + conf.division.rawValue)
            } else if conf.division == .DII {
                d2Men.append(conf)
                save(d2Men, conf.gender.rawValue + conf.division.rawValue)
            } else {
                d3Men.append(conf)
                save(d3Men, conf.gender.rawValue + conf.division.rawValue)
            }
        } else if (conf.gender == .women) {
            if conf.division == .DI {
                d1Women.append(conf)
                save(d1Women, conf.gender.rawValue + conf.division.rawValue)
            } else if conf.division == .DII {
                d2Women.append(conf)
                save(d2Women, conf.gender.rawValue + conf.division.rawValue)
            } else {
                d3Women.append(conf)
                save(d3Women, conf.gender.rawValue + conf.division.rawValue)
            }
        }
    }
    
    func isFavorized(conf: Conference) -> Bool{
        if d1Men.contains(conf) {return true}
        if d2Men.contains(conf) {return true}
        if d3Men.contains(conf) {return true}
        if d1Women.contains(conf) {return true}
        if d2Women.contains(conf) {return true}
        if d3Women.contains(conf) {return true}
        return false
    }
    
    
}
