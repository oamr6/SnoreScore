//
//  DoneViewController.swift
//  SnoreScore
//
//  Created by MU IT Program on 2/20/16.
//  Copyright © 2016 Corey Matzat. All rights reserved.
//

import UIKit

class DoneViewController: UIViewController {

    @IBOutlet weak var snoreCountLabel: UILabel!
    @IBOutlet weak var previousSnore: UILabel!
    var snoreCount: String?
    var snoreCountInt: Int?
    var box: Int?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        snoreCountLabel.text = snoreCount
        navigationController?.navigationBarHidden = true
        navigationController?.navigationItem.backBarButtonItem?.enabled = false
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goBackToStart(sender: AnyObject) {
        navigationController?.navigationBarHidden = false
        navigationController?.popToRootViewControllerAnimated(true)
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
