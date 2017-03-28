//
//  ShoppingCartEmptyDataState.swift
//  Shamp
//
//  Created by Sergio David Bravo Talero on 3/28/17.
//  Copyright © 2017 Koombea. All rights reserved.
//

import Foundation
import DZNEmptyDataSet

extension ShoppingCartViewController: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let attributes = [NSFontAttributeName: UIFont(name: "HelveticaNeue-Bold", size: 19)!, NSForegroundColorAttributeName: UIColor.signatureGray()]
        return NSAttributedString(string: "No Products Added", attributes: attributes)
    }
}
