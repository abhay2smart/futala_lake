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
    
    static func getDateStringFromDate(date: Date, outputFormat: String = "dd-MM-yyyy")->String? {
        // Create Date Formatter
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        // Set Date Format
        dateFormatter.dateFormat =  outputFormat
        // Convert Date to String
        let dateStr = dateFormatter.string(from: date)
        return dateStr
    }
    
    
    static func getDateTimeStringFromDate(date: Date, outputFormat: String = "dd-MM-yyyy HH:mm:ss")->String? {
        // Create Date Formatter
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        // Set Date Format
        dateFormatter.dateFormat =  outputFormat
        // Convert Date to String
        let dateStr = dateFormatter.string(from: date)
        return dateStr
    }
    
    
    static func getCurrentStrTime() -> String? {
        let date = Date()
        let calender = Calendar.current
        let components = calender.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date)
        let hour = components.hour
        let minute = components.minute
        let second = components.second

        let todayString = String(hour!)  + ":" + String(minute!) + ":" +  String(second!)
        
        return todayString
        //return today_string
    }
    
    static func getTimeDiff(currentTimeStr: String, endTimeStr: String)->Double {
        
        print("currentTimeStr: \(currentTimeStr) endTimeStr: \(endTimeStr)")
        
        let textDate1 = currentTimeStr
        let textDate2 = endTimeStr

        let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm:ss"
            formatter.timeZone = TimeZone.current
            return formatter
        } ()

        // Dates used for the comparison
        let date1 = dateFormatter.date(from: textDate1)
        let date2 = dateFormatter.date(from: textDate2)
        
        var diff = 0.0
        if let date1 = date1, let date2 = date2 {
            diff = date1.timeOfDayInterval(toDate: date2)
            if diff > 0 {
                    print("Time of the day in the second date is greater")
                } else if diff < 0 {
                    print("Time of the day in the first date is greater")
                } else {
                    print("Times of the day in both dates are equal")
                }        }
        
        
        print("currentTimeStr: \(currentTimeStr) endTimeStr: \(endTimeStr) diff: \(diff)")
        
        return diff
    }
    
    
    static func getDateFromDateString(date: String, inputFormat: String = "yyyy-MM-dd") -> Date {
          let dateFormatter = DateFormatter()
          dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
          dateFormatter.dateFormat =  inputFormat //"yyyy-MM-dd'T'HH:mm:ssZ"
          let date = dateFormatter.date(from:date) ?? Date()
        return date
    }
    
    static func todayDate() -> Date{
        let currentDate = Date()
        let calendar = Calendar.current

        let year = calendar.component(.year, from: currentDate)
        let month = calendar.component(.month, from: currentDate)
        let day = calendar.component(.day, from: currentDate)

        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day

        let date = calendar.date(from: dateComponents)!
        return date
    }
    
    static func excludeTimeFromDateDate(date: Date) -> Date{
        let currentDate = date
        let calendar = Calendar.current

        let year = calendar.component(.year, from: currentDate)
        let month = calendar.component(.month, from: currentDate)
        let day = calendar.component(.day, from: currentDate)

        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day

        let date = calendar.date(from: dateComponents)!
        return date
    }
    



    
}
