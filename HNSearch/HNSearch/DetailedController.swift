//===----------------------------------------------------------------------===//
//
//  DetailedController.swift
//  HNSearch
//
//  Created by Girish Kolari on 12/18/15.
//  Copyright © 2015 Girish Kolari. All rights reserved.
//
//===----------------------------------------------------------------------===//
//
//      DetailedController.swift - Detailed item controller
//
//===----------------------------------------------------------------------===//

import UIKit

class DetailedController: UIViewController {
    @IBOutlet weak var storyTitle: UILabel!

    @IBOutlet weak var details: UITextView!
    
    var hnItem: HNItem?
    
    
    override func viewWillAppear(animated: Bool) {
        
        if let hnItem = hnItem {
            storyTitle.text = hnItem.title ?? hnItem.story_title
            
            details.text = hnItem.comment_text ?? ""

        }

    }
}
