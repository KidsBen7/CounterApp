//
//  Extensions.swift
//  CounterApp
//
//  Created by Chanh Dat Ng on 10/17/19.
//  Copyright © 2019 Chanh Dat Ng. All rights reserved.
//

import Foundation
import UIKit


extension UIView {
    
    //    @IBInspectable
    //    var cornerRadius: CGFloat {
    //        get {
    //            return layer.cornerRadius
    //        }
    //        set {
    //            layer.cornerRadius = newValue
    //        }
    //    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
    
    enum ViewSide {
        case Left, Right, Top, Bottom
    }
    
    // MARK: - BORDER
//    func addBorder(toSide side: ViewSide, withColor color: CGColor, andThickness thickness: CGFloat) {
//
//        let border = CALayer()
//        border.backgroundColor = color
//
//        switch side {
//        case .Left:
//            border.frame = CGRect(x: frame.minX, y: frame.minY, width: thickness, height: frame.height)
//        case .Right:
//            border.frame = CGRect(x: frame.maxX, y: frame.minY, width: thickness, height: frame.height)
//        case .Top:
//            border.frame = CGRect(x: frame.minX, y: frame.minY, width: frame.width, height: thickness)
//        case .Bottom:
//            border.frame = CGRect(x: frame.minX, y: frame.maxY, width: frame.width, height: thickness)
//        }
//
//        layer.addSublayer(border)
//    }
}
    //MARK: - Date
extension Date {
    func currentLocale() -> Locale {
        
        let locale = Locale(identifier: "en_GB")
        //        if languageCode == "EN" {
        //            locale = Locale(identifier: "en_GB")
        //        }
        //
        //        if languageCode == "VT" {
        //            locale = Locale(identifier: "vi_VN")
        //        }
        //locale = Locale(identifier: "vi_VN")
        return locale
    }
    
    func getDaysInMonth() ->  Int{
        let calendar = Calendar.current
        //        calendar.locale = Locale(identifier: "vi_VN")
        let dateComponents = DateComponents(year: calendar.component(.year, from: self), month: calendar.component(.month, from: self))
        let date = calendar.date(from: dateComponents)!
        let range = calendar.range(of: .day, in: .month, for: date)!
        let numDays = range.count
        return numDays
    }
    
    func strDateNoYear() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM"
        dateFormatter.locale = self.currentLocale()
        return dateFormatter.string(from: self).capitalized
    }
    
    func dayOfWeek() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        dateFormatter.locale = self.currentLocale()
        return dateFormatter.string(from: self).capitalized
    }
    
    func nameMonth() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        dateFormatter.locale = self.currentLocale()
        return dateFormatter.string(from: self).capitalized
    }
    
    func nameYear() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        return dateFormatter.string(from: self).capitalized
    }
    
    func getMonth() -> Int {
        let calendar = Calendar.current
        let composents = calendar.dateComponents([.day, .month, .year], from: self)
        return composents.month!
    }
    func getYear() -> Int {
        let calendar = Calendar.current
        let composents = calendar.dateComponents([.day, .month, .year], from: self)
        return composents.year!
    }
    func getDay() -> Int {
        let calendar = Calendar.current
        let composents = calendar.dateComponents([.day, .month, .year], from: self)
        return composents.day!
    }
    
    func toStringWith(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = self.currentLocale()
        return dateFormatter.string(from: self).capitalized
    }
    
    func getFirstDayInMonth() -> Date {
        let month = self.getMonth()
        let year = self.getYear()
        let stringDate : String = String(format: "%.2d%.2d%d", 01, month, year)
        return stringDate.toDateWith(format: "ddMMyyyy")
    }
    
    func getLastDayInMonth() -> Date {
        let month = self.getMonth()
        let year = self.getYear()
        let lastDay = self.getDaysInMonth()
        let stringDate : String = String(format: "%.2d%.2d%d", lastDay, month, year)
        return stringDate.toDateWith(format: "ddMMyyyy")
    }
    
    func subNumberMinutes(_ minutes: Int) -> Date {
        var dateComponents = DateComponents()
        dateComponents.setValue(-minutes, for: .minute)
        return Calendar.current.date(byAdding: dateComponents, to: self)!
    }
}
extension String {
    func toDateWith(format: String) -> Date {
        let dataFormatter = DateFormatter()
        dataFormatter.dateFormat = format
        dataFormatter.locale = Locale(identifier: "en_GB")
        return dataFormatter.date(from: self) ?? Date()
    }
}
