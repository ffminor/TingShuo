//
//  TSDataBaseAction.swift
//  TingShuo
//
//  Created by fminor on 10/3/14.
//
//
import Foundation

class TSDataBaseAction: NSObject {
    
    // data base file name
    var _fileName:String = "";
    
    // data base complete file path
    var _filePath:String = "";

    // data base handler
    var _dbHandle:COpaquePointer = nil;
    
    func openDB(fileName: String) {
        
        let _result:CInt = sqlite3_open(fileName, &_dbHandle);
        
        // open database failed
        if _result != SQLITE_OK {
            sqlite3_close(_dbHandle);
        }
    }
    
    func _dataFilePath(fileName: String) -> String {
        let _paths:Array = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory,
            NSSearchPathDomainMask.UserDomainMask, true);
        let _documentPath:String = _paths[0] as String;
        return _documentPath.stringByAppendingString(fileName);
    }
}
