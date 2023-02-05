//
//  NumberOfViews.swift
//  NewsList
//
//  Created by Данила on 05.02.2023.
//

import Foundation

class Views {
    let userDefaults = UserDefaults.standard
    func setNumberOfViews(_ dict: [String:Int], strs: [String]) -> [String:Int]  {
        var dictHelp = dict
        for c in strs {
            if dictHelp[c] == nil {
                dictHelp[c] = 0
            }
        }
        setDict(dict: dictHelp)
        return dictHelp
    }
    
    func setDict(dict: [String: Int]) {
        userDefaults.set(dict, forKey: "dict")
        userDefaults.synchronize()
    }
    
    func getDict() -> [String: Int]? {
        return userDefaults.object(forKey: "dict") as? [String:Int]
    }
    
    func increaseDict(str: String) {
        var dict = getDict()
        dict![str]! += 1
        setDict(dict: dict!)
    }
    
}
