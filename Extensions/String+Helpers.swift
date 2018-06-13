//
//  String+Helpers.swift
//  Xapo
//
//  Created by Cristian Florin Ghinea on 13/06/2018.
//  Copyright © 2018 Cristian Florin Ghinea. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    var isStringLink: Bool {
        
        let types: NSTextCheckingResult.CheckingType = [.link]
        let detector = try? NSDataDetector(types: types.rawValue)
        guard (detector != nil && self.count > 0) else { return false }
        if detector!.numberOfMatches(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count)) > 0 {
            return true
        }
        return false
    }
    
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect,
                                            options: .usesLineFragmentOrigin,
                                            attributes: [NSAttributedStringKey.font: font], context: nil)
        
        return boundingBox.height
    }
    
    func width(withConstraintedHeight height: CGFloat, font: UIFont) -> CGFloat {
        
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect,
                                            options: .usesLineFragmentOrigin,
                                            attributes: [NSAttributedStringKey.font: font],
                                            context: nil)
        
        return boundingBox.width
    }
}

extension String
{
    typealias SimpleToFromRepalceList = [(fromSubString:String,toSubString:String)]
    
    // See http://stackoverflow.com/questions/24200888/any-way-to-replace-characters-on-swift-string
    //
    func simpleReplace( mapList:SimpleToFromRepalceList ) -> String
    {
        var string = self
        
        for (fromStr, toStr) in mapList {
            let separatedList = string.components(separatedBy: fromStr) //string.componentsSeparatedByString(fromStr)
            if separatedList.count > 1 {
                string = separatedList.joined(separator: toStr)
            }
        }
        
        return string
    }
    
    func xmlSimpleUnescape() -> String
    {
        let mapList : SimpleToFromRepalceList = [
            ("&amp;",  "&"),
            ("&quot;", "\""),
            ("&#x27;", "'"),
            ("&#39;",  "'"),
            ("&#x92;", "'"),
            ("&#x96;", "-"),
            ("&gt;",   ">"),
            ("&lt;",   "<")]
        
        return self.simpleReplace(mapList: mapList)
    }
    
    func xmlSimpleEscape() -> String
    {
        let mapList : SimpleToFromRepalceList = [
            ("&",  "&amp;"),
            ("\"", "&quot;"),
            ("'",  "&#x27;"),
            (">",  "&gt;"),
            ("<",  "&lt;")]
        
        return self.simpleReplace(mapList: mapList)
    }
}

