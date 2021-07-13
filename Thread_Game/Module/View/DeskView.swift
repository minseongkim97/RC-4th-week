//
//  DeskView.swift
//  Thread_Game
//
//  Created by MIN SEONG KIM on 2021/07/13.
//

import UIKit

extension CALayer {
    func addBorder(_ arr_edge: [UIRectEdge], color: UIColor, width: CGFloat) {
        for edge in arr_edge {
            let border = CALayer()
            switch edge {
            case UIRectEdge.top:
                border.frame = CGRect.init(x: 0, y: 0, width: frame.width, height: width)
                break
            case UIRectEdge.bottom:
                border.frame = CGRect.init(x: 0, y: frame.height - width, width: frame.width, height: width)
                break
            case UIRectEdge.left:
                border.frame = CGRect.init(x: 0, y: 0, width: width, height: frame.height)
                break
            case UIRectEdge.right:
                border.frame = CGRect.init(x: frame.width - width, y: 0, width: width, height: frame.height)
                break
            default:
                break
            }
            border.backgroundColor = color.cgColor;
            self.addSublayer(border)
        }
    }
}


class DeskView: UIView {
    override func draw(_ rect: CGRect) {
        self.layer.addBorder([.left, .right, .bottom], color: UIColor.black, width: 3.0)
    }
}

class SourceDeskView: UIView {
    override func draw(_ rect: CGRect) {
        self.layer.addBorder([.top, .left, .right, .bottom], color: UIColor.black, width: 3.0)
    }
}

