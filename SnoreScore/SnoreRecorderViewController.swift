//
//  SnoreRecorderViewController.swift
//  SnoreScore
//
//  Created by MU IT Program on 2/20/16.
//  Copyright © 2016 Corey Matzat. All rights reserved.
//

import UIKit
import WatchConnectivity
import AVFoundation

class SnoreRecorderViewController: UIViewController, WCSessionDelegate {

    var session: WCSession?
    @IBOutlet weak var state: UILabel!
    @IBOutlet weak var buttonState: UIButton!
    
    var recorder: AVAudioRecorder!
    var baselineRecordingTimer = NSTimer()
    var baselineCalculationTimer = NSTimer()
    
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
        buttonState.setTitle("Stop Recording", forState: .Normal)
        state.text = "Currently Recording"
        
        startAudio()
        
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
        if let viewController = segue.destinationViewController as? DoneViewController {
                viewController.snoreCount = NSUserDefaults.standardUserDefaults().integerForKey("numberTimes").description
                viewController.snoreCountInt = NSUserDefaults.standardUserDefaults().integerForKey("numberTimes")
        }
    }
    
    func startAudio() {
        var baseLine: Double!
        var speakingThreshold : Double!
        var frequency : Float!
        var vibration: Bool!
        var alert: Bool!
        baseLine = NSUserDefaults.standardUserDefaults().doubleForKey("baseLineRecord")
        speakingThreshold = NSUserDefaults.standardUserDefaults().doubleForKey("speakingThresholdRecord")
        //frequency = NSUserDefaults.standardUserDefaults().floatForKey("FrequencySlider")
        //vibration = NSUserDefaults.standardUserDefaults().boolForKey("VibrationAlert")
        alert = NSUserDefaults.standardUserDefaults().boolForKey("SnoringAlertPreference")
        print(alert)
        //print(frequency)
        //print(vibration)
        // Make an AudioSession, set it to PlayAndRecord and make it active
        let audioSession:AVAudioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
            try audioSession.setActive(true)
        } catch {}
        
        // Set up the URL for the audio file
        let documents: AnyObject = NSSearchPathForDirectoriesInDomains( NSSearchPathDirectory.DocumentDirectory,  NSSearchPathDomainMask.UserDomainMask, true)[0]
        let str =  documents.stringByAppendingPathComponent("recording.m4a")
        let url = NSURL.fileURLWithPath(str as String)
        
        // make a dictionary to hold the recording settings so we can instantiate our AVAudioRecorder
        let recordSettings: [String : AnyObject] = [AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000.0,
            AVNumberOfChannelsKey: 1 as NSNumber,
            AVEncoderAudioQualityKey: AVAudioQuality.High.rawValue]
        
        //Instantiate an AVAudioRecorder
        do {
            try recorder = AVAudioRecorder(URL: url, settings: recordSettings)
        } catch {
        }
        recorder.prepareToRecord()
        recorder.meteringEnabled = true
        
        //start recording
        recorder.record()
        
        //instantiate a timer to be called with whatever frequency we want to grab metering values
        
        baselineRecordingTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("recordSound"), userInfo: nil, repeats: true)
        baselineCalculationTimer = NSTimer.scheduledTimerWithTimeInterval(8, target: self, selector: Selector("analyzeInterval"), userInfo: nil, repeats: false)
        
        
    }
    
    func recordSound() {
        
    }
    
    func analyzeInterval() {
        
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

