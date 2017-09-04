//
//  GradientBackground.swift
//  NaradaBotDemo
//
//  Created by Margareta Kusan on 01/09/2017.
//  Copyright © 2017 Margareta Kusan. All rights reserved.
//

import UIKit

class GradientBackground: UIView {
    
    private enum Constants {
        static let colorTop = UIColor.black.cgColor
        static let colorBottom = UIColor.clear.cgColor
    }
    
    var gl: CAGradientLayer!
    
    init() {
        self.gl = CAGradientLayer()
        super.init(frame: .zero)
        
        self.gl.colors = [Constants.colorTop, Constants.colorBottom]
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
