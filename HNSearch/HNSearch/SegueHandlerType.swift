//
//  SegueHandlerType.swift
//  HNSearch
//
//  Created by Girish Kolari on 12/22/15.
//  Copyright © 2015 Girish Kolari. All rights reserved.
//

import UIKit


protocol SegueHandlerType {
    typealias SegueIdentifier: RawRepresentable
}


extension SegueHandlerType where Self: UIViewController,
    SegueIdentifier.RawValue == String
{
    
    func performSegueWithIdentifier(segueIdentifier: SegueIdentifier,
        sender: AnyObject?) {
            
            performSegueWithIdentifier(segueIdentifier.rawValue, sender: sender)
    }
    
    func segueIdentifierForSegue(segue: UIStoryboardSegue) -> SegueIdentifier {
        
        // still have to use guard stuff here, but at least you're
        // extracting it this time
        guard let identifier = segue.identifier,
            segueIdentifier = SegueIdentifier(rawValue: identifier) else {
                fatalError("Invalid segue identifier \(segue.identifier).") }
        
        return segueIdentifier
    }
}


//http://natashatherobot.com/protocol-oriented-segue-identifiers-swift/?utm_campaign=This%2BWeek%2Bin%2BSwift&utm_medium=web&utm_source=This_Week_in_Swift_66