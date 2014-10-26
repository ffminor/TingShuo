//
//  TSApiManager.swift
//  TingShuo
//
//  Created by fminor on 10/7/14.
//
//

import UIKit

var _gApiManager:TSApiManager? = TSApiManager();

class TSApiManager: NSObject
{
    // api addresses
    var _apiAddrs:Array<String>? = ["42.121.144.167"];
    
    // singleton
    func sharedManager() -> TSApiManager {
        if _gApiManager == nil {
            _gApiManager = TSApiManager()
        }
        return _gApiManager!;
    }
    
    func _getCompleteApiPathsWithAddress(address:String, parameters: Dictionary<String, String>?) -> String {
        var _finalStr = "http://" + address;
        if parameters == nil {
            return _finalStr;
        }
        
        var _isFirstParam = true;
        for (key, value) in parameters! {
            _finalStr += _isFirstParam ? "/?" : "&";
            _finalStr += key + "=" + value;
            _isFirstParam = false;
        }
        
        return _finalStr;
    }
}
