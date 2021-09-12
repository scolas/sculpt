//
//  Extensions.swift
//  Insta
//
//  Created by Scott Colas on 3/29/21.
//

import Foundation
import UIKit


extension UIView{
    var top: CGFloat{
        frame.origin.y
    }
    
    var bottom: CGFloat{
        frame.origin.y+height
    }
    var left: CGFloat{
        frame.origin.x
    }
    var right: CGFloat{
        frame.origin.x+width
    }
    var width: CGFloat{
        frame.size.width
    }
    var height: CGFloat{
        frame.size.height
    }
    
}

// self.self is whatever object that conforms to codable
extension Decodable {
    init?(with dictionary: [String: Any]){
        guard let data = try? JSONSerialization.data(
                withJSONObject: dictionary,
                options: .prettyPrinted
        ) else{
            return nil
        }
        guard let result = try? JSONDecoder().decode(
                Self.self,
                from: data
        ) else {
            return nil
        }
        self = result
    }
}

//alows us to convert models to dictionaries 
extension Encodable{
    func asDictionary() -> [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else{
            return nil
        }
        let json = try? JSONSerialization.jsonObject(
            with: data,
            options: .allowFragments
        ) as? [String: Any]
        return json
    }
}


//home feed pod video 4 min 14

extension DateFormatter{
    static let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle  = .medium
        formatter.timeStyle = .short
        return formatter
    }()
}

extension String{
    static func date(from date: Date) -> String? {
        let formatter = DateFormatter.formatter
        let string = formatter.string(from: date)
        return string
    }
}

extension Notification.Name {
    /// Notification to inform of new post
    static let didPostNotification = Notification.Name("didPostNotification")
}

