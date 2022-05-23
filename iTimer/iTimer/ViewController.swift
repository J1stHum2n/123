//
//  ViewController.swift
//  iTimer
//
//  Created by Student on 23.03.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var TimerLabel: UILabel!
    @IBOutlet weak var startStopButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    
    var timer:Timer = Timer ()
    var count:Int = 0
    var timerCounting:Bool = false
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
 
    
    @IBAction func resetTapped(_ sender: Any)
    {
        let alert = UIAlertController(title: "Сбросить таймер?", message: "Вы уверены?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: { (_) in
        }))
        
        alert.addAction(UIAlertAction(title: "Да", style: .default, handler: { (_) in
            self.count = 0
            self.timer.invalidate()
            self.TimerLabel.text = self.makeTimeString(minutes: 0, seconds: 0)
            self.startStopButton.setTitle("  Start", for: .normal)
        }))
        
        self.present (alert, animated: true, completion: nil)
                                      
    }
    
    @IBAction func startStopTapped(_ sender: Any)
    {
        if(timerCounting)
        {
            timerCounting = false
            timer.invalidate()
            startStopButton.setTitle("  Start", for: .normal)
        }
        else
        {
            timerCounting = true
            startStopButton.setTitle("  Stop", for: .normal)
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

