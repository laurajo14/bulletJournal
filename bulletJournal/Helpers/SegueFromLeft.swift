//
//  SegueFromLeft.swift
//  bulletJournal
//
//  Created by Laura O'Brien on 12/7/17.
//  Copyright © 2017 Laura O'Brien. All rights reserved.
//

import Foundation
import UIKit

class SegueFromLeft: UIStoryboardSegue {
    override func perform() {
        let src = self.source
        let dst = self.destination
        
        src.view.superview?.insertSubview(dst.view, aboveSubview: src.view)
        dst.view.transform = CGAffineTransform(translationX: src.view.frame.size.width, y: 0)
        //Make it segue from the right by taking out the    "-" here
        
        UIView.animate(withDuration: 0.4, delay: 0.0, options: .curveEaseOut, animations: {
            dst.view.transform = CGAffineTransform(translationX: 0, y: 0)
        }, completion: {
            finished in src.present(dst, animated: false, completion: nil)
        })
    }
}
