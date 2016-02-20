//
//  CalibratingViewController.swift
//  SnoreScore
//
//  Created by MU IT Program on 2/19/16.
//  Copyright © 2016 Corey Matzat. All rights reserved.
//

import UIKit

class CalibratingViewController: UIViewController {
    
    var monitor: AudioMonitor
    
    required init?(coder aDecoder: NSCoder) {
        monitor = AudioMonitor()
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        monitor.startMonitor()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        //monitor.stopMonitor()
    }
    

}
