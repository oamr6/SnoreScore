//
//  SnoreRecorderViewController.swift
//  SnoreScore
//
//  Created by MU IT Program on 2/20/16.
//  Copyright © 2016 Corey Matzat. All rights reserved.
//

import UIKit
import WatchConnectivity

class SnoreRecorderViewController: UIViewController, WCSessionDelegate {

    var session: WCSession?
    @IBOutlet weak var state: UILabel!
    @IBOutlet weak var buttonState: UIButton!
    
    
    
    var count = 5
    var flipState: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print(NSUserDefaults.standardUserDefaults().integerForKey("numberTimes"))
        // Do any additional setup after loading the view, typically from a nib.
        if WCSession.isSupported() {
            session = WCSession.defaultSession()
            guard let session = session else {
                return
            }
            session.delegate = self
            session.activateSession()
        }
        buttonState.enabled = true
        buttonState.setTitle("Stop Recording", forState: .Normal)
        state.text = "Currently Recording"
        // Do any additional setup after loading the view.
        NSUserDefaults.standardUserDefaults().setInteger(count, forKey: "numberTimes")
    }

  
    @IBAction func Vibrate(sender: AnyObject) {
        session!.sendMessage(["vibrate": true], replyHandler: { (reply) -> Void in
            // do something
            }) { (error) -> Void in
                //
                print("SOMETHING HAPPENEF \(error)")
        }

        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func changeStatus(sender: AnyObject) {
        if(flipState == true)
        {
            flipState = false
            buttonState.setTitle("Done Recording", forState: .Normal)
            state.text = "Displaying Recording Recording"
        }
    }
        override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
                if let viewController = segue.destinationViewController as? DoneViewController
                    {
                        viewController.snoreCount = NSUserDefaults.standardUserDefaults().integerForKey("numberTimes").description
                        viewController.snoreCountInt = NSUserDefaults.standardUserDefaults().integerForKey("numberTimes")
                    }
                }
}


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

