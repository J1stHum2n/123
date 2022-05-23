//
//  ViewController.swift
//  iTimer
//
//  Created by Student on 23.03.2022.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.taskArray.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = self.taskTable.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = self.taskArray.object(at: indexPath.row) as? String
        return cell
    }
    

    @IBOutlet weak var TimerLabel: UILabel!
    @IBOutlet weak var startStopButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    
    var timer:Timer = Timer ()
    var count:Int = 0
    var timerCounting:Bool = false
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        startStopButton.setTitleColor(UIColor.green, for: .normal)
        self.taskTable.delegate = self
        self.taskTable.dataSource = self
        print("application finished loading")
    }
 
    
    @IBAction func resetTapped(_ sender: Any)
    {
        
        
        
        //let alert = UIAlertController(title: "Reset Timer?", message: "Are you sure you would like to reset the Timer?", preferredStyle: .alert)
        //alert.addAction(UIAlertAction(title: "CANCEL", style: .cancel, handler: { (_) in
        //}))
        
        //alert.addAction(UIAlertAction(title: "YES", style: .default, handler: { (_) in
         //   self.count = 0
         //   self.timer.invalidate()
         //   self.TimerLabel.text = self.makeTimeString(minutes: 0, seconds: 0)
         //   self.startStopButton.setTitle("START", for: .normal)
         //   self.startStopButton.setTitleColor(UIColor.green, for: .normal)
        //}))
        
      //  self.present (alert, animated: true, completion: nil)
                                      
    }
    
    @IBAction func startStopTapped(_ sender: Any)
    {
        if(timerCounting)
        {
            timerCounting = false
            timer.invalidate()
            startStopButton.setTitle("START", for: .normal)
            startStopButton.setTitleColor(UIColor.green, for: .normal)
        }
        else
        {
            timerCounting = true
            startStopButton.setTitle("STOP", for: .normal)
            startStopButton.setTitleColor(UIColor.red, for: .normal)
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
        }
    }
    @objc func timerCounter() -> Void
    {
        count = count + 1
        let time = secondsToMinutesSeconds(seconds: count)
        let timeString = makeTimeString(minutes: time.0, seconds: time.1)
        TimerLabel.text = timeString
    }
    func secondsToMinutesSeconds(seconds: Int) -> (Int, Int)
    {
        return  ((seconds % 3600 / 60),((seconds % 3600) % 60))
    }
    func makeTimeString(minutes: Int, seconds: Int) -> String
    {
        var timeString = ""
        timeString += String(format: "%02d", minutes)
        timeString += " : "
        timeString += String(format: "%02d", seconds)
        return timeString
    }
    
    @IBOutlet var taskTable: UITableView!
    var taskArray : NSMutableArray! = NSMutableArray() //Could be a non-NS as well

    @IBAction func addTask(sender: AnyObject) {
        //Print to alert we entered method
        print("task submitted")
        //Get input from text field
        let input = TimerLabel.text
        //Add object to array, reload table
        self.taskArray.add(input!)
        self.taskTable.reloadData()
    }//addTask

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

