//
//  SnoreRecorderViewController.swift
//  SnoreScore
//
//  Created by MU IT Program on 2/20/16.
//  Copyright © 2016 Corey Matzat. All rights reserved.
//

import UIKit

class SnoreRecorderViewController: UIViewController {

    @IBOutlet weak var state: UILabel!
    @IBOutlet weak var buttonState: UIButton!
    
    var flipState: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonState.enabled = true
        buttonState.setTitle("Start Recording", forState: .Normal)
        buttonState.titleLabel?.text = "Start Recording"
        state.text = "Press Start Recording"
        // Do any additional setup after loading the view.
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
