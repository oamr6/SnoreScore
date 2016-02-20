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
    
    
    
    var count = 0
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
        buttonState.setTitle("Start Recording", forState: .Normal)
        buttonState.titleLabel?.text = "Start Recording"
        state.text = "Press Start Recording"
        // Do any additional setup after loading the view.
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
        }
        else
        {
            flipState = true
        }
        if(flipState == true)
        {
            //buttonState.titleLabel!.text = "Recording"
            buttonState.setTitle("Stop Recording", forState: .Normal)
            state.text = "Currently Recording"
        }
        if(flipState == false)
        {
            //buttonState.titleLabel?.text = "Start Recording"
            buttonState.setTitle("Start Recording", forState: .Normal)
            state.text = "Currently Not Recording"
        }
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if flipState == false
        {
            if let viewController = segue.destinationViewController as? DoneViewController
            {
                print(count.description)
                viewController.snoreCount = count.description
            }
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

