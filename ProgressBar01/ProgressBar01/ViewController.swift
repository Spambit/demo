//
//  ViewController.swift
//  ProgressBar01
//
//  Created by sambit sarkar on 19/12/17.
//  Copyright © 2017 sambit sarkar. All rights reserved.
//

import UIKit

class ViewController: UIViewController , AwesomeProgressBarDelegate{
    private var timer:Timer?
    private var progressBar:AwesomeProgressBar?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func anyButtonPressed(_ sender: UIButton) {
        self.progressBar = AwesomeProgressBar.show(in: (self.navigationController?.view!)!)
        self.progressBar?.delegate = self;
        self.timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { (timer) in
            self.progressBar?.progress += 0.3
        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func progressBar(didDismiss progressBar: AwesomeProgressBar) {
        self.timer?.invalidate()
        self.timer = nil
    }
}

