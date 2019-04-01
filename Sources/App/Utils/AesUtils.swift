//
//  AesUtils.swift
//  App
//
//  Created by Paweł Szenk on 01/04/2019.
//

import Foundation
import Crypto

public class AesUtils {
    
    public class func decode(_ text: String, key: Data) throws -> String?
    {
        guard text.lengthOfBytes(using: .utf8) > 0,
            let pwdData = text.hexadecimalToData,
            pwdData.count > 16,
            key.count == 32 else {
                return nil
        }
        
        let end = pwdData.count
        let iv: Data = pwdData.subdata(in: Range(0..<16))
        let pass: Data = pwdData.subdata(in: Range(16..<end))
        
        let password = try AES256CBC.decrypt(pass, key: key, iv: iv)
        return String(data: password, encoding: .utf8)
    }
    
}
