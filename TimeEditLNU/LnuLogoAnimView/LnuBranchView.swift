//
//  LnuBranch.swift
//  TimeEditLNU
//
//  Created by Alper Gündogdu on 2/6/17.
//  Copyright © 2017 Alper Gündogdu. All rights reserved.
//

import UIKit


class LnuBranchView: UIView {
    
    override func draw(_ rect: CGRect) {
        BranchO.drawBranchOnly()
        self.clipsToBounds = true
        self.backgroundColor = UIColor.yellow
    }
    
}
