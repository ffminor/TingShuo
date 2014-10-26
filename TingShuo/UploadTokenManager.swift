//
//  UploadTokenManager.swift
//  TingShuo
//
//  Created by fminor on 10/15/14.
//
//

import UIKit

class UploadPolicy: NSObject {
    
    var scope:String = ""
    var deadline:Int = 0
    var secretKey:NSString = "MY_SECRET_KEY"
    
    var jsonString:String {
        get {
            var _result = "{";
            _result += "\"scope\":\"" + self.scope + "\"";
            _result += ",";
            _result += "\"deadline\":" + self.deadline.description;
            _result += ",";
            _result += "\"returnBody\":\"{\\\"name\\\":$(fname),\\\"size\\\":$(fsize),\\\"w\\\":$(imageInfo.width),\\\"h\\\":$(imageInfo.height),\\\"hash\\\":$(etag)}\"}";
            return _result;
        }
    }
    
    func sha1(key: NSString) -> String {
        var _result = ""
        return _result
    }
    
    /*
    func jsonString() -> String {
        var _result = "{";
        _result += "\"scope\":\"" + self.scope + "\"";
        _result += ",";
        _result += "\"deadline\":" + self.deadline.description;
        _result += ",";
        _result += "\"returnBody\":\"{\\\"name\\\":$(fname),\\\"size\\\":$(fsize),\\\"w\\\":$(imageInfo.width),\\\"h\\\":$(imageInfo.height),\\\"hash\\\":$(etag)}\"}";
        return _result;
    }
    */
}

class UploadTokenManager: NSObject {
    
    var uploadPolicy: UploadPolicy = UploadPolicy()
    
    var message: NSString? = ""
    var encodeSign: NSString? = ""
    var secretKey: NSString = "MY_SECRET_KEY"
    
    var uploadToken: NSString {
        get {
            var _token:NSString = "\(self.secretKey):\(self.encodeSign!):\(self.message!)"
            return _token
        }
    }
    
    override init() {
        super.init();
        self.uploadPolicy.deadline = 1451491200
        self.uploadPolicy.scope = "my-bucket:sunflower.jpg"
        
        let _jsonStr = self.uploadPolicy.jsonString
        NSLog(_jsonStr)
        
        let _base64 = self.base64(_jsonStr)
        println(_base64)
        
        self.message = _base64
        let _encode: NSData = TSKeySignature.hmacSha1(self.uploadPolicy.secretKey, text: self.message!)
        println("Encode:")
        println(_encode)
        self.encodeSign = _encode.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.allZeros)
        println("EncodeSign:")
        println(self.encodeSign)
        
        println("Token: \(self.uploadToken)")
    }
    
    func base64(message:String) -> String? {
        var _data:NSData? = message.dataUsingEncoding(NSASCIIStringEncoding, allowLossyConversion: true)
        return _data?.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.allZeros)
    }
    
}
