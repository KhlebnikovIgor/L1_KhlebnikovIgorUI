//
//  LikedControl.swift
//  L1_KhlebnikovIgorUI
//
//  Created by Igor on 9/16/19.
//  Copyright © 2019 Igor. All rights reserved.
//

import UIKit

class LikedControl: UIControl{
    
    @IBInspectable var strokeWidth: CGFloat = 4.0
    @IBInspectable var strokeColor: UIColor? = .gray
//    let countLabel =  UILabel()
//    private var stackView : UIStackView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.backgroundColor = .clear
//        countLabel.text = "sdfdsf"
//        let views: [UIView] = [self, countLabel]
//        stackView = UIStackView(arrangedSubviews: views)
//        self.addSubview(stackView)
//        stackView.spacing = 0
//        stackView.axis = .horizontal
//        stackView.alignment = .center
//        stackView.distribution = .fillEqually
    }
    
    @IBInspectable var isLiked = false
        {
        didSet {
            if oldValue != isLiked{
                setNeedsDisplay(bounds)
            }
        }
    }
    
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        print("beginTracking")
        return true
    }
    
    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        print("continueTracking")
        return false
    }
    
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        print("endTracking")
        self.isLiked = !self.isLiked
    }
    
    override func cancelTracking(with event: UIEvent?) {
        print("cancelTracking")
    }
    
    
    override func draw(_ rect: CGRect) {
        let bezierPath = UIBezierPath(heartIn: self.bounds)
        
        self.strokeColor!.setStroke()
        
        bezierPath.lineWidth = self.strokeWidth
        bezierPath.stroke()
        
        if self.isLiked {
            self.tintColor = .red
        }else { self.tintColor = .white}
        
        self.tintColor.setFill()
        
        bezierPath.fill()
        
    }
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        //guard let aa = bounds else {return}
//        stackView.frame = bounds
//    }
    
}

extension UIBezierPath {
    convenience init(heartIn rect: CGRect) {
        self.init()
        
        //Рассчитываем радиус дуг
        let sideOne = rect.width * 0.4
        let sideTwo = rect.height * 0.3
        let arcRadius = sqrt(sideOne*sideOne + sideTwo*sideTwo)/2
        
        //Кривая с левой стороны
        self.addArc(withCenter: CGPoint(x: rect.width * 0.3, y: rect.height * 0.35), radius: arcRadius, startAngle: 135.degreesToRadians, endAngle: 315.degreesToRadians, clockwise: true)
        
        //Кривая с правой стороны
        self.addArc(withCenter: CGPoint(x: rect.width * 0.7, y: rect.height * 0.35), radius: arcRadius, startAngle: 225.degreesToRadians, endAngle: 45.degreesToRadians, clockwise: true)
        
        //Правая линия от дуги к нижней центральной точке
        self.addLine(to: CGPoint(x: rect.width * 0.5, y: rect.height * 0.95))
        
        //        Замыкаем контур сердца, левая линия от нижней центральной точки к дуге
        self.close()
    }
    
}
extension Int {
    var degreesToRadians: CGFloat { return CGFloat(self) * .pi / 180 }
}
