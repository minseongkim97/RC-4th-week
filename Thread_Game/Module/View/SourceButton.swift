//
//  SourceButton.swift
//  Thread_Game
//
//  Created by MIN SEONG KIM on 2021/07/13.
//

import UIKit

class SourceButton: UIButton {
    override func draw(_ rect: CGRect) {
        self.clipsToBounds = true
        self.layer.cornerRadius = 8
        self.layer.borderWidth = 2
        self.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
}

