//
//  DateExtension.swift
//  LTY_Partner
//
//  Created by Chawtech on 03/05/23.
//

import Foundation

extension Date {
    static func getFormattedDate(string: String ) -> String{
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "yyyy-MM-dd"
        
        let date: Date? = dateFormatterGet.date(from: string)
       // print("Date",dateFormatterPrint.string(from: date!)) // Feb 01,2018
        return dateFormatterPrint.string(from: date!);
    }
}
