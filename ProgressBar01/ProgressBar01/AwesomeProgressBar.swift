//
//  AwesomeProgressBar.swift
//  ProgressBar01
//
//  Created by sambit sarkar on 19/12/17.
//  Copyright © 2017 sambit sarkar. All rights reserved.
//

import UIKit

public protocol AwesomeProgressBarDelegate : class{
    func progressBar(didDismiss progressBar:AwesomeProgressBar)
}

public class AwesomeProgressBar: UIView {

    @IBOutlet weak var percentageLabel: UILabel!
    @IBOutlet weak var indicatorView: AwesomeIndicatorView!
    
    @IBOutlet weak var actionLabel: UILabel!
    
    @IBAction func cancel(_ sender: UIButton) {
        self.dismiss()
    }
    
    weak public var delegate:AwesomeProgressBarDelegate?
    
    public private(set) var dismissed:Bool = false
    
    @IBOutlet weak var cancelButton: UIButton!
    override public func layoutSubviews() {
        self.cancelButton.layer.cornerRadius = self.cancelButton.bounds.size.width/2
        self.cancelButton.contentEdgeInsets = UIEdgeInsetsMake(4, 4, 4, 4)
        self.cancelButton.layer.borderColor = UIColor.white.cgColor
        self.cancelButton.layer.borderWidth = 0.8
        self.cancelButton.layer.masksToBounds = true
    }
    
    public func dismiss(){
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 0.0
        }) { (finished) in
            if finished {
                self.progress = 0
                if let delegate = self.delegate {
                    delegate.progressBar(didDismiss: self)
                }
                self.dismissed = true
            }
        }
    }
    
    public static func show(in parent:UIView)->(AwesomeProgressBar?){
        let progressView = Bundle.main.loadNibNamed("AwesomeProgressBar", owner: nil, options: nil)?.first as! AwesomeProgressBar
        parent.addSubview(progressView)
        parent.bringSubview(toFront: progressView)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.alpha = 0.0; //to fade-in the appearance
        NSLayoutConstraint(item: progressView, attribute: .top, relatedBy: NSLayoutRelation.equal, toItem: parent, attribute: .top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: progressView, attribute: .left, relatedBy: NSLayoutRelation.equal, toItem: parent, attribute: .left, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: progressView, attribute: .right, relatedBy: NSLayoutRelation.equal, toItem: parent, attribute: .right, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: progressView, attribute: .bottom, relatedBy: NSLayoutRelation.equal, toItem: parent, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        
        progressView.layer.masksToBounds = true
        UIView.animate(withDuration: 0.3) {
            progressView.alpha = 1.0
        }
        return progressView
    }
    
    internal func showPercentage(forProgress progress:Float)
    {
        let title = String.localizedStringWithFormat("%0.f %%", progress)
        let attributedTitle = NSMutableAttributedString(string: title)
        let startRange = NSMakeRange(0,title.count-2)
        let endRange = NSMakeRange(title.count-1,1)
        attributedTitle.addAttribute(NSAttributedStringKey.font, value: UIFont.systemFont(ofSize: 18), range: startRange)
        attributedTitle.addAttribute(NSAttributedStringKey.font, value: UIFont.systemFont(ofSize: 12), range: endRange)
        self.percentageLabel!.attributedText = attributedTitle
    }
    
    public var progress:Float = 0{
        willSet (newValue) {
            if newValue >= 0 && newValue <= 100{
                DispatchQueue.main.async {
                    self.indicatorView.progress = newValue
                    self.indicatorView.setNeedsDisplay()
                    self.showPercentage(forProgress: newValue)
                }
            }else {
                self.dismiss()
            }
        }
    }
}
