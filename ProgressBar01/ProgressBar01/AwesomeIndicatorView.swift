//
//  AwesomeIndicatorView.swift
//  ProgressBar01
//
//  Created by sambit sarkar on 19/12/17.
//  Copyright © 2017 sambit sarkar. All rights reserved.
//

import UIKit

@IBDesignable class AwesomeIndicatorView: UIView {
    open static let progressBackgroundLineWidth = 7.0
    open static let progressCircleLineWidth = 3.0
    open static let startAngleOfTheTrack = -90.0
    open static let endAngleOfTheTrack = 270.0
    
    private func degreeToRadian(degree:Float)->Float {
        return ((degree * Float.pi) / 180)
    }
    
    @IBInspectable public var progress:Float = 0.0
    
    private var progressCircleLineSeparator:Float {
        get {
            return Float((AwesomeIndicatorView.progressBackgroundLineWidth - AwesomeIndicatorView.progressCircleLineWidth)/2)
        }
    }
    
    @IBInspectable var backgroundTrackColor:UIColor = UIColor.init(white: 0.1, alpha: 0.8)
    @IBInspectable var progressTrackColor : UIColor = UIColor.init(white: 0.8, alpha: 1.0)
    
    private func drawBackgroundTrack() -> Void {
        let frame = self.bounds
        let track = UIBezierPath()
        track.lineWidth = CGFloat(AwesomeIndicatorView.progressBackgroundLineWidth)
        track.lineCapStyle = .butt
        
        let center = CGPoint(x: frame.midX, y: frame.midY)
        let radius = (Float(frame.size.width) - Float(AwesomeIndicatorView.progressBackgroundLineWidth))/2
        
        track.addArc(withCenter: center, radius: CGFloat(radius), startAngle: CGFloat(self.degreeToRadian(degree: Float(AwesomeIndicatorView.startAngleOfTheTrack))), endAngle: CGFloat(self.degreeToRadian(degree: Float(AwesomeIndicatorView.endAngleOfTheTrack))), clockwise: true)
        
        self.backgroundTrackColor.set()
        track.stroke()
    }
    
    private func drawProgressCircle() -> Void {
        let frame = self.bounds
        let track = UIBezierPath()
        track.lineWidth = CGFloat(AwesomeIndicatorView.progressCircleLineWidth)
        track.lineCapStyle = .round
        
        let center = CGPoint(x: frame.midX, y: frame.midY)
        let radius = Float(frame.size.width/2) - Float(self.progressCircleLineSeparator) - Float(AwesomeIndicatorView.progressCircleLineWidth/2)
        
        let endAngle = (Float.pi * ( self.progress - 25)) / 50;
        
        track.addArc(withCenter: center, radius: CGFloat(radius), startAngle: CGFloat(self.degreeToRadian(degree: Float(AwesomeIndicatorView.startAngleOfTheTrack))), endAngle: CGFloat(endAngle), clockwise: true)
        
        self.progressTrackColor.set()
        track.stroke()
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        self.drawBackgroundTrack()
        self.drawProgressCircle()
    }

}
