//
//  MessagesTableView.swift
//  Shamp
//
//  Created by Sergio David Bravo Talero on 5/22/17.
//  Copyright © 2017 Koombea. All rights reserved.
//

import Foundation
import DZNEmptyDataSet

extension MessagesViewController: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let attributes = [NSFontAttributeName: UIFont(name: "HelveticaNeue-Bold", size: 19)!, NSForegroundColorAttributeName: UIColor.signatureGray()]
        return NSAttributedString(string: "No messages to show", attributes: attributes)
    }
    
    func emptyDataSetShouldAllowScroll(_ scrollView: UIScrollView!) -> Bool {
        return true
    }
}
