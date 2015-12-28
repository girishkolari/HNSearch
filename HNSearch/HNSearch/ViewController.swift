//
//  ViewController.swift
//  HNSearch
//
//  Created by Girish Kolari on 12/10/15.
//  Copyright © 2015 Girish Kolari. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
/*
    {
    "num_comments" : 431,
    "created_at" : "2015-12-03T15:05:37.000Z",
    "title" : "Swift is Open Source",
    "story_title" : null,
    "objectID" : "10669891",
    "parent_id" : null,
    "created_at_i" : 1449155137,
    "story_id" : null,
    "story_url" : null,
    "author" : "psuter",
    "_highlightResult" : {
    "title" : {
    "value" : "<em>Swift<\/em> is Open Source",
    "matchedWords" : [
    "swift"
    ],
    "matchLevel" : "full"
    },
    "url" : {
    "value" : "https:\/\/<em>swift<\/em>.org\/",
    "matchedWords" : [
    "swift"
    ],
    "matchLevel" : "full"
    },
    "author" : {
    "value" : "psuter",
    "matchedWords" : [
    ],
    "matchLevel" : "none"
    }
    },
    "comment_text" : null,
    "points" : 1824,
    "story_text" : null,
    "_tags" : [
    "story",
    "author_psuter",
    "story_10669891"
    ],
    "url" : "https:\/\/swift.org\/"
    }
*/

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

/*
Plan for 18-12-2015
1. Group items based on paret item ID
2. Introduce Search Controle in UI - Integrate to search
3. Add Filter with 3 options All <-> Story <-> Comment - Integrate to search
4. Have segway to show gruoper items

If time permits
5. Detail page to display content

- Think of drawer UI (Ray has video in Scrole + staic table)
- Give all search filed in API
- Search for multiple pages
- Gesure to say done and save
- Identify new search items from last search
- Persist search result in DB for future referance (just a thought)

*/


/*
Task for 11-12-2015
1. Define class/struct to represent search result
2. Parse JSON object in to struct/class
3. Show it in table view

Task for 12-12-2015
1. Study open source to see how I can define options for search api
2. give option to take seach configuration
3. Show with seach options
*/
