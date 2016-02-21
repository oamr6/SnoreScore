//
//  InterfaceController.swift
//  SnoreScore WatchKit Extension
//
//  Created by Corey Matzat on 2/19/16.
//  Copyright © 2016 Corey Matzat. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

class InterfaceController: WKInterfaceController, WCSessionDelegate  {

    var timer: NSTimer!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }

    @IBOutlet var testButton: WKInterfaceButton!
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        print("LOLOLOL")
        if WCSession.isSupported() {
            let session = WCSession.defaultSession()
            session.delegate = self
            session.activateSession()
        }
    }

    @IBAction func LastHapticFeedback() {
        print("LHF")
        timer = NSTimer(timeInterval: 10, target: self, selector: "actuallyPlayHapticYoLol", userInfo: nil, repeats: true)
        NSRunLoop.mainRunLoop().addTimer(timer, forMode: NSRunLoopCommonModes)
    }
    
    func actuallyPlayHapticYoLol() {
        print("PLAYING HAPTIC")
        WKInterfaceDevice.currentDevice().playHaptic(.Failure)
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    func session(session: WCSession, didReceiveMessage message: [String : AnyObject]) {
        print("lollololololololo")
        if ((message.keys.indexOf("vibrate")) != nil) {
            testButton.setTitle("This works")
            self.LastHapticFeedback()
        }
    }

}
