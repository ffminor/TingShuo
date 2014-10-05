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
    
    // open data base
    func openDataBase(fileName: String) {
        
        _filePath = self._dataFilePath(fileName);
        let _result:CInt = sqlite3_open(_filePath, &_dbHandle);
        
        // open database failed
        if _result != SQLITE_OK {
            sqlite3_close(_dbHandle);
            println("open/create database failed!");
        }
        
        println("open/create database success!");
    }
    
    // create a table
    func createTable(tableName: String) {
        var _createSQL:String = "CREATE TABLE IF NOT EXISTS " + tableName + "(identity TEXT PRIMARY KEY, value TEXT)";
        var _error:CInt;
        _error = sqlite3_exec(_dbHandle, _createSQL, nil, nil, nil);
        if  _error != SQLITE_OK {
            sqlite3_close(_dbHandle);
            println("create table failed!");
        }
        println("create table success!");
    }
    
    // utilities
    func _dataFilePath(fileName: String) -> String {
        let _paths:Array = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory,
            NSSearchPathDomainMask.UserDomainMask, true);
        let _documentPath:String = _paths[0] as String;
        return _documentPath.stringByAppendingPathComponent(fileName);
    }
}
