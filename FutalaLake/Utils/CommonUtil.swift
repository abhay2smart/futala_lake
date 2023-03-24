//
//  CommonUtil.swift
//  FutalaLake
//
//  Created by Abhayjeet Singh on 17/03/23.
//

import Foundation

import SwiftUI

class CommonUtil {
    static func convertTimeTwentyFourIntoTwelve(time: String)->String? {
        let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "H:mm:s"
        if let date12 = dateFormatter.date(from: time) {
            dateFormatter.dateFormat = "h:mm a"
            let date22 = dateFormatter.string(from: date12)
            return date22
        }
        return nil
    }
    
    static func getQRCodeData(dictionary: [String: String]) -> Data? {
        //guard let filter = CIFilter(name: "CIQRCodeGenerator") else { return nil }
        
        
        
    //    let data = text.data(using: .ascii, allowLossyConversion: false)
    //    filter.setValue(data, forKey: "inputMessage")
    //    guard let ciimage = filter.outputImage else { return nil }
    //    let transform = CGAffineTransform(scaleX: 10, y: 10)
    //    let scaledCIImage = ciimage.transformed(by: transform)
    //    let uiimage = UIImage(ciImage: scaledCIImage)
    //    return uiimage.pngData()!
        
        
        do {
                let data = try JSONEncoder().encode(dictionary)
                if let validData = String(data: data,encoding: .utf8){
                    print(validData)
                }

                if let filter = CIFilter(name: "CIQRCodeGenerator"){
                    filter.setValue(data, forKey: "inputMessage")
                    let transform = CGAffineTransform(scaleX: 10, y: 10)
                    if let output = filter.outputImage?.transformed(by: transform){
                        return  UIImage(ciImage: output).pngData()!
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        
        return nil
    }

}
