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
import AVFoundation

class SnoreRecorderViewController: UIViewController, WCSessionDelegate {
    var audioPlayer:AVAudioPlayer!
    var session: WCSession?
    @IBOutlet weak var buttonState: UIButton!
    
    var recorder: AVAudioRecorder!
    var recordingTimer = NSTimer()
    var periodTimer = NSTimer()
    var delayTimer = NSTimer()
    
    let longDelay = 30.0 * 60.0
    let shortDelay = 120.0
    
    var consecutiveSnores = 0
    
    var count = 0
    var flipState: Bool = false
    var baseLine: Double?
    var speakingThreshold : Double?
    var decibels = 0.0
    var loud = 0.0
    var trials = 0.0
    var frequency : Float?
    var vibration: Bool?
    var alert: Bool?

    
    let thresholdPercent = 0.5
    let thresholdNumber = 0.3
    
    override func viewDidLoad() {
        super.viewDidLoad()
                self.title = "Sleep"
        
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
        
        self.navigationItem.setHidesBackButton(true, animated:true);
        
        startAudio()
        
        // Do any additional setup after loading the view.
        NSUserDefaults.standardUserDefaults().setInteger(count, forKey: "numberTimes")
    }

  
    @IBAction func Vibrate(sender: AnyObject) {
        

        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func changeStatus(sender: AnyObject) {
        
        recordingTimer.invalidate()
        periodTimer.invalidate()
        delayTimer.invalidate()
        if(flipState == true)
        {
            flipState = false
            buttonState.setTitle("Done Recording", forState: .Normal)
        }
    }
    
    //override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //if let viewController = segue.destinationViewController as? DoneViewController {
             //   viewController.snoreCount = 
            
            //    NSUserDefaults.standardUserDefaults().integerForKey("numberTimes").description
                //viewController.snoreCountInt = //NSUserDefaults.standardUserDefaults().integerForKey("numberTimes")
      //  }
   // }
    
    func startAudio() {
        baseLine = NSUserDefaults.standardUserDefaults().doubleForKey("baseLineRecord")
        speakingThreshold = NSUserDefaults.standardUserDefaults().doubleForKey("speakingThresholdRecord")
        //frequency = NSUserDefaults.standardUserDefaults().floatForKey("FrequencySlider")
        vibration = NSUserDefaults.standardUserDefaults().boolForKey("WatchAlertPreference")
        alert = NSUserDefaults.standardUserDefaults().boolForKey("SnoringAlertPreference")
        //print(alert)
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
        
        recordingTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("recordSound"), userInfo: nil, repeats: true)
        periodTimer = NSTimer.scheduledTimerWithTimeInterval(10, target: self, selector: Selector("analyzeInterval"), userInfo: nil, repeats: true)
        
        
    }
    
    func recordSound() {
        //we have to update meters before we can get the metering values
        recorder.updateMeters()
        //print(recorder.averagePowerForChannel(0))
        
        if (Double(recorder.averagePowerForChannel(0)) > thresholdNumber * (speakingThreshold! - baseLine!) + baseLine!)
        {
            print("Loud!")
            loud++
        }
        trials++
    }
    
    func analyzeInterval() {
        
        
        if (loud / trials >= thresholdPercent) {
            count++
            NSUserDefaults.standardUserDefaults().setInteger(count, forKey: "countSnores")
            
            let audioFilePath = NSBundle.mainBundle().pathForResource("avicii", ofType: "mp3")
            
            if audioFilePath != nil {
                
                let audioFileUrl = NSURL.fileURLWithPath(audioFilePath!)
                
                audioPlayer = try? AVAudioPlayer(contentsOfURL: audioFileUrl)
                audioPlayer.play()
                audioPlayer.volume = 0.1
                
                
                
            } else {
                print("audio file is not found")
            }
            

            print("SNORE!")
                        session?.sendMessage(["vibrate": true], replyHandler: { (reply) -> Void in
                // do something
                }) { (error) -> Void in
                    //
                    //                print("SOMETHING HAPPENED \(error)")
            }
            playCalmingMusic()
            
            if (consecutiveSnores != 0) {
                audioPlayer.volume = audioPlayer.volume*1.3
            }
            
            

            print("SNORE!")
            
            
            recordingTimer.invalidate()
            periodTimer.invalidate()
            consecutiveSnores++
            delayTimer = NSTimer.scheduledTimerWithTimeInterval(consecutiveSnores > 8 ? longDelay : shortDelay, target: self, selector: Selector("delayBetweenNoises"), userInfo: nil, repeats: false)
        } else if (consecutiveSnores > 0) {
            consecutiveSnores = 0
        }

        loud = 0
        trials = 0
    }
    
    func delayBetweenNoises() {
        recordingTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("recordSound"), userInfo: nil, repeats: true)
        periodTimer = NSTimer.scheduledTimerWithTimeInterval(10, target: self, selector: Selector("analyzeInterval"), userInfo: nil, repeats: true)
    }
    
    
        func playCalmingMusic(){
            let audioFilePath = NSBundle.mainBundle().pathForResource("avicii", ofType: "mp3")
            
            if audioFilePath != nil {
                
                let audioFileUrl = NSURL.fileURLWithPath(audioFilePath!)
                
                audioPlayer = try? AVAudioPlayer(contentsOfURL: audioFileUrl)
                
                audioPlayer.play()
                audioPlayer.volume = 1.0
                
                
                
            } else {
                print("audio file is not found")
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

