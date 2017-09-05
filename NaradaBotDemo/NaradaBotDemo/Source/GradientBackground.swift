//
//  GradientBackground.swift
//  NaradaBotDemo
//
//  Created by Margareta Kusan on 01/09/2017.
//  Copyright © 2017 Margareta Kusan. All rights reserved.
//

import UIKit

class GradientBackground: UIView {
    
    var gl: CAGradientLayer!
    var colorTop: CGColor!
    var colorBottom: CGColor!
    
    init(colorTop: CGColor, colorBottom: CGColor) {
        self.gl = CAGradientLayer()
        super.init(frame: .zero)
        
        self.colorTop = colorTop
        self.colorBottom = colorBottom
        self.gl.colors = [colorTop, colorBottom]
        self.gl.locations = [0.0, 0.7]
        self.gl.opacity = 1.0
        self.layer.insertSublayer(self.gl, at: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.gl.frame = rect
    }
}
