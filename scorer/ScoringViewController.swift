//
//  ScoringViewController.swift
//  scorer
//
//  Created by Jacob Kohn on 11/30/15.
//  Copyright © 2015 Jacob Kohn. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class ScoringViewController: UIViewController {
    
    var game = Int()
    let NathanHale = ["Kateel Barnett","Sam Leach","Sam Nasralla","Malcolm Gulyard","Stieg Smith","Malik Johnson","Ishmael Simpson", "Luke Alkire", "TJ Williams","Dempsey Hope","Khepra Mims", "Niles Bateman","Phil Asmelash", "Carter Petro","Langston Barlow"]
    var lineup = [String]()
    var bench = [String]()
    var games = [NSManagedObject]()
    var players = [NSManagedObject]()
    var firstTime = false
    
    let subButton = UIButton()
    let homeButton = UIButton()
    
    let name1 = UILabel()
    let name2 = UILabel()
    let name3 = UILabel()
    let name4 = UILabel()
    let name5 = UILabel()
    
    let twopm1 = UIButton()
    let twopm2 = UIButton()
    let twopm3 = UIButton()
    let twopm4 = UIButton()
    let twopm5 = UIButton()
    
    let threepm1 = UIButton()
    let threepm2 = UIButton()
    let threepm3 = UIButton()
    let threepm4 = UIButton()
    let threepm5 = UIButton()
    
    let assist1 = UIButton()
    let assist2 = UIButton()
    let assist3 = UIButton()
    let assist4 = UIButton()
    let assist5 = UIButton()
    
    let rebound1 = UIButton()
    let rebound2 = UIButton()
    let rebound3 = UIButton()
    let rebound4 = UIButton()
    let rebound5 = UIButton()
    
    let ftm1 = UIButton()
    let ftm2 = UIButton()
    let ftm3 = UIButton()
    let ftm4 = UIButton()
    let ftm5 = UIButton()
    
    let missedTwo1 = UIButton()
    let missedTwo2 = UIButton()
    let missedTwo3 = UIButton()
    let missedTwo4 = UIButton()
    let missedTwo5 = UIButton()
    
    let missedThree1 = UIButton()
    let missedThree2 = UIButton()
    let missedThree3 = UIButton()
    let missedThree4 = UIButton()
    let missedThree5 = UIButton()
    
    let missFT1 = UIButton()
    let missFT2 = UIButton()
    let missFT3 = UIButton()
    let missFT4 = UIButton()
    let missFT5 = UIButton()
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName:"Game")
        let error: NSError?
        var fetchedResults = [NSManagedObject]()
        do {
            fetchedResults = try managedContext.executeFetchRequest(fetchRequest) as! [NSManagedObject]
        } catch let error as NSError {
            
            print("Fetch failed: \(error.localizedDescription)")
        }
        games = fetchedResults
        
        
        let fetchReq = NSFetchRequest(entityName:"Player")
        let err: NSError?
        var fetchedR = [NSManagedObject]()
        do {
            fetchedR = try managedContext.executeFetchRequest(fetchReq) as! [NSManagedObject]
        } catch let err as NSError {
            
            print("Fetch failed: \(err.localizedDescription)")
        }
        players = fetchedR
        
        addNameLabels()
        addFTMButtons()
        addTwoPMButtons()
        addThreePMButtons()
        addAssistButtons()
        addReboundButtons()
        addMissFTButtons()
        addMissedThreeButtons()
        addMissedThreeButtons()
        addMissed2Buttons()
        addSubButton()
        setNameLabels()
        
    }

    
    func addNameLabels() {
        name1.frame = CGRectMake(0,0,self.view.frame.size.width / 6 * 2, self.view.frame.size.height / 6)
        name1.textAlignment = NSTextAlignment.Center
        self.view.addSubview(name1)
        
        
        name2.frame = CGRectMake(0,self.view.frame.size.height / 6,self.view.frame.size.width / 6 * 2, self.view.frame.size.height / 6)
        name2.textAlignment = NSTextAlignment.Center
        self.view.addSubview(name2)
        
        name3.frame = CGRectMake(0,self.view.frame.size.height / 6 * 2,self.view.frame.size.width / 6 * 2, self.view.frame.size.height / 6)
        name3.textAlignment = NSTextAlignment.Center
        self.view.addSubview(name3)
        
        name4.frame = CGRectMake(0,self.view.frame.size.height / 6 * 3,self.view.frame.size.width / 6 * 2, self.view.frame.size.height / 6)
        name4.textAlignment = NSTextAlignment.Center
        self.view.addSubview(name4)
        
        name5.frame = CGRectMake(0,self.view.frame.size.height / 6 * 4,self.view.frame.size.width / 6 * 2, self.view.frame.size.height / 6)
        name5.textAlignment = NSTextAlignment.Center
        self.view.addSubview(name5)
    }
    
    func addFTMButtons() {
        
        ftm1.addTarget(self, action: "madeFT:", forControlEvents: UIControlEvents.TouchUpInside)
        ftm1.frame = CGRectMake(self.view.frame.size.width / 6 * 2, 0, (self.view.frame.size.width / 6) - 8, (self.view.frame.size.height / 12) - 4)
        ftm1.setTitle("FT", forState: UIControlState.Normal)
        ftm1.backgroundColor = UIColor.greenColor()
        ftm1.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        ftm1.tag = 0
        self.view.addSubview(ftm1)
        
        ftm2.addTarget(self, action: "madeFT:", forControlEvents: UIControlEvents.TouchUpInside)
        ftm2.frame = CGRectMake(self.view.frame.size.width / 6 * 2, self.view.frame.size.height / 6 + 4, (self.view.frame.size.width / 6) - 8, (self.view.frame.size.height / 12) - 4)
        ftm2.setTitle("FT", forState: UIControlState.Normal)
        ftm2.backgroundColor = UIColor.greenColor()
        ftm2.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        ftm2.tag = 1
        self.view.addSubview(ftm2)
        
        ftm3.addTarget(self, action: "madeFT:", forControlEvents: UIControlEvents.TouchUpInside)
        ftm3.frame = CGRectMake(self.view.frame.size.width / 6 * 2, self.view.frame.size.height / 6 * 2 + 8, (self.view.frame.size.width / 6) - 8, (self.view.frame.size.height / 12) - 4)
        ftm3.setTitle("FT", forState: UIControlState.Normal)
        ftm3.backgroundColor = UIColor.greenColor()
        ftm3.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        ftm3.tag = 2
        self.view.addSubview(ftm3)
        
        ftm4.addTarget(self, action: "madeFT:", forControlEvents: UIControlEvents.TouchUpInside)
        ftm4.frame = CGRectMake(self.view.frame.size.width / 6 * 2, self.view.frame.size.height / 6 * 3 + 12, (self.view.frame.size.width / 6) - 8, (self.view.frame.size.height / 12) - 4)
        ftm4.setTitle("FT", forState: UIControlState.Normal)
        ftm4.backgroundColor = UIColor.greenColor()
        ftm4.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        ftm4.tag = 3
        self.view.addSubview(ftm4)
        
        ftm5.addTarget(self, action: "madeFT:", forControlEvents: UIControlEvents.TouchUpInside)
        ftm5.frame = CGRectMake(self.view.frame.size.width / 6 * 2, self.view.frame.size.height / 6 * 4 + 16, (self.view.frame.size.width / 6) - 8, (self.view.frame.size.height / 12) - 4)
        ftm5.setTitle("FT", forState: UIControlState.Normal)
        ftm5.backgroundColor = UIColor.greenColor()
        ftm5.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        ftm5.tag = 4
        self.view.addSubview(ftm5)
    }
    
    
    func addTwoPMButtons() {
        
        let pink = UIColor(red:1.0, green:0.1, blue:0.65, alpha:1.0)
        
        twopm1.addTarget(self, action: "made2ptr:", forControlEvents: UIControlEvents.TouchUpInside)
        twopm1.frame = CGRectMake(self.view.frame.size.width / 6 * 3, 0, (self.view.frame.size.width / 6) - 8, (self.view.frame.size.height / 12) - 4)
        twopm1.setTitle("2PM", forState: UIControlState.Normal)
        twopm1.backgroundColor = pink
        twopm1.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        twopm1.tag = 0
        self.view.addSubview(twopm1)
        
        twopm2.addTarget(self, action: "made2ptr:", forControlEvents: UIControlEvents.TouchUpInside)
        twopm2.frame = CGRectMake(self.view.frame.size.width / 6 * 3, self.view.frame.size.height / 6 + 4, (self.view.frame.size.width / 6) - 8, (self.view.frame.size.height / 12) - 4)
        twopm2.setTitle("2PM", forState: UIControlState.Normal)
        twopm2.backgroundColor = pink
        twopm2.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        twopm2.tag = 1
        self.view.addSubview(twopm2)
        
        
        twopm3.addTarget(self, action: "made2ptr:", forControlEvents: UIControlEvents.TouchUpInside)
        twopm3.frame = CGRectMake(self.view.frame.size.width / 6 * 3, self.view.frame.size.height / 6 * 2 + 8, (self.view.frame.size.width / 6) - 8, (self.view.frame.size.height / 12) - 4)
        twopm3.setTitle("2PM", forState: UIControlState.Normal)
        twopm3.backgroundColor = pink
        twopm3.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        twopm3.tag = 2
        self.view.addSubview(twopm3)
        
        
        twopm4.addTarget(self, action: "made2ptr:", forControlEvents: UIControlEvents.TouchUpInside)
        twopm4.frame = CGRectMake(self.view.frame.size.width / 6 * 3, self.view.frame.size.height / 6 * 3 + 12, (self.view.frame.size.width / 6) - 8, (self.view.frame.size.height / 12) - 4)
        twopm4.setTitle("2PM", forState: UIControlState.Normal)
        twopm4.backgroundColor = pink
        twopm4.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        twopm4.tag = 3
        self.view.addSubview(twopm4)
        
        
        twopm5.addTarget(self, action: "made2ptr:", forControlEvents: UIControlEvents.TouchUpInside)
        twopm5.frame = CGRectMake(self.view.frame.size.width / 6 * 3, self.view.frame.size.height / 6 * 4 + 16, (self.view.frame.size.width / 6) - 8, (self.view.frame.size.height / 12) - 4)
        twopm5.setTitle("2PM", forState: UIControlState.Normal)
        twopm5.backgroundColor = pink
        twopm5.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        twopm5.tag = 4
        self.view.addSubview(twopm5)
    }
    
    
    
    func addThreePMButtons() {
        
        let blue = UIColor(red:0.12, green:0.54, blue:1.0, alpha:1.0)
        
        threepm1.addTarget(self, action: "madeThree:", forControlEvents: UIControlEvents.TouchUpInside)
        threepm1.frame = CGRectMake(self.view.frame.size.width / 6 * 4, 0, (self.view.frame.size.width / 6) - 8, (self.view.frame.size.height / 12) - 4)
        threepm1.setTitle("3PM", forState: UIControlState.Normal)
        threepm1.backgroundColor = blue
        threepm1.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        threepm1.tag = 0
        self.view.addSubview(threepm1)
        
        threepm2.addTarget(self, action: "madeThree:", forControlEvents: UIControlEvents.TouchUpInside)
        threepm2.frame = CGRectMake(self.view.frame.size.width / 6 * 4, self.view.frame.size.height / 6 + 4, (self.view.frame.size.width / 6) - 8, (self.view.frame.size.height / 12) - 4)
        threepm2.setTitle("3PM", forState: UIControlState.Normal)
        threepm2.backgroundColor = blue
        threepm2.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        threepm2.tag = 1
        self.view.addSubview(threepm2)
        
        threepm3.addTarget(self, action: "madeThree:", forControlEvents: UIControlEvents.TouchUpInside)
        threepm3.frame = CGRectMake(self.view.frame.size.width / 6 * 4, self.view.frame.size.height / 6 * 2 + 8, (self.view.frame.size.width / 6) - 8, (self.view.frame.size.height / 12) - 4)
        threepm3.setTitle("3PM", forState: UIControlState.Normal)
        threepm3.backgroundColor = blue
        threepm3.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        threepm3.tag = 2
        self.view.addSubview(threepm3)
        
        threepm4.addTarget(self, action: "madeThree:", forControlEvents: UIControlEvents.TouchUpInside)
        threepm4.frame = CGRectMake(self.view.frame.size.width / 6 * 4, self.view.frame.size.height / 6 * 3 + 12, (self.view.frame.size.width / 6) - 8, (self.view.frame.size.height / 12) - 4)
        threepm4.setTitle("3PM", forState: UIControlState.Normal)
        threepm4.backgroundColor = blue
        threepm4.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        threepm4.tag = 3
        self.view.addSubview(threepm4)
        
        threepm5.addTarget(self, action: "madeThree:", forControlEvents: UIControlEvents.TouchUpInside)
        threepm5.frame = CGRectMake(self.view.frame.size.width / 6 * 4, self.view.frame.size.height / 6 * 4 + 16, (self.view.frame.size.width / 6) - 8, (self.view.frame.size.height / 12) - 4)
        threepm5.setTitle("3PM", forState: UIControlState.Normal)
        threepm5.backgroundColor = blue
        threepm5.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        threepm5.tag = 4
        self.view.addSubview(threepm5)
    }
    
    func addReboundButtons() {
        
        let red = UIColor(red:0.74, green:0.0, blue:0.0, alpha:1.0)
        
        rebound1.addTarget(self, action: "madeRebound:", forControlEvents: UIControlEvents.TouchUpInside)
        rebound1.frame = CGRectMake(self.view.frame.size.width / 6 * 5,0, (self.view.frame.size.width / 6) - 8, (self.view.frame.size.height / 12) - 4)
        rebound1.setTitle("REBOUND", forState: UIControlState.Normal)
        rebound1.backgroundColor = red
        rebound1.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        rebound1.tag = 0
        self.view.addSubview(rebound1)
        
        rebound2.addTarget(self, action: "madeRebound:", forControlEvents: UIControlEvents.TouchUpInside)
        rebound2.frame = CGRectMake(self.view.frame.size.width / 6 * 5,self.view.frame.size.height / 6 + 4, (self.view.frame.size.width / 6) - 8, (self.view.frame.size.height / 12) - 4)
        rebound2.setTitle("REBOUND", forState: UIControlState.Normal)
        rebound2.backgroundColor = red
        rebound2.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        rebound2.tag = 1
        self.view.addSubview(rebound2)
        
        rebound3.addTarget(self, action: "madeRebound:", forControlEvents: UIControlEvents.TouchUpInside)
        rebound3.frame = CGRectMake(self.view.frame.size.width / 6 * 5,self.view.frame.size.height / 6 * 2 + 8, (self.view.frame.size.width / 6) - 8, (self.view.frame.size.height / 12) - 4)
        rebound3.setTitle("REBOUND", forState: UIControlState.Normal)
        rebound3.backgroundColor = red
        rebound3.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        rebound3.tag = 2
        self.view.addSubview(rebound3)
        
        rebound4.addTarget(self, action: "madeRebound:", forControlEvents: UIControlEvents.TouchUpInside)
        rebound4.frame = CGRectMake(self.view.frame.size.width / 6 * 5,self.view.frame.size.height / 6 * 3 + 12, (self.view.frame.size.width / 6) - 8, (self.view.frame.size.height / 12) - 4)
        rebound4.setTitle("REBOUND", forState: UIControlState.Normal)
        rebound4.backgroundColor = red
        rebound4.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        rebound4.tag = 3
        self.view.addSubview(rebound4)
        
        rebound5.addTarget(self, action: "madeRebound:", forControlEvents: UIControlEvents.TouchUpInside)
        rebound5.frame = CGRectMake(self.view.frame.size.width / 6 * 5,self.view.frame.size.height / 6 * 4 + 16, (self.view.frame.size.width / 6) - 8, (self.view.frame.size.height / 12) - 4)
        rebound5.setTitle("REBOUND", forState: UIControlState.Normal)
        rebound5.backgroundColor = red
        rebound5.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        rebound5.tag = 4
        self.view.addSubview(rebound5)
        
    }
    
    func addMissFTButtons() {
        
        let gray = UIColor(red:0.35, green:0.35, blue:0.35, alpha:1.0)
        
        missFT1.addTarget(self, action: "missFT:", forControlEvents: UIControlEvents.TouchUpInside)
        missFT1.frame = CGRectMake(self.view.frame.size.width / 6 * 2, self.view.frame.height / 12, (self.view.frame.size.width / 6) - 8, (self.view.frame.size.height / 12) - 4)
        missFT1.setTitle("MISS FT", forState: UIControlState.Normal)
        missFT1.backgroundColor = gray
        missFT1.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        missFT1.tag = 0
        self.view.addSubview(missFT1)
        
        missFT2.addTarget(self, action: "missFT:", forControlEvents: UIControlEvents.TouchUpInside)
        missFT2.frame = CGRectMake(self.view.frame.size.width / 6 * 2, self.view.frame.height / 12 * 3 + 4, (self.view.frame.size.width / 6) - 8, (self.view.frame.size.height / 12) - 4)
        missFT2.setTitle("MISS FT", forState: UIControlState.Normal)
        missFT2.backgroundColor = gray
        missFT2.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        missFT2.tag = 1
        self.view.addSubview(missFT2)
        
        missFT3.addTarget(self, action: "missFT:", forControlEvents: UIControlEvents.TouchUpInside)
        missFT3.frame = CGRectMake(self.view.frame.size.width / 6 * 2, self.view.frame.height / 12 * 5 + 8, (self.view.frame.size.width / 6) - 8, (self.view.frame.size.height / 12) - 4)
        missFT3.setTitle("MISS FT", forState: UIControlState.Normal)
        missFT3.backgroundColor = gray
        missFT3.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        missFT3.tag = 2
        self.view.addSubview(missFT3)
        
        missFT4.addTarget(self, action: "missFT:", forControlEvents: UIControlEvents.TouchUpInside)
        missFT4.frame = CGRectMake(self.view.frame.size.width / 6 * 2, self.view.frame.height / 12 * 7 + 12, (self.view.frame.size.width / 6) - 8, (self.view.frame.size.height / 12) - 4)
        missFT4.setTitle("MISS FT", forState: UIControlState.Normal)
        missFT4.backgroundColor = gray
        missFT4.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        missFT4.tag = 3
        self.view.addSubview(missFT4)
        
        missFT5.addTarget(self, action: "missFT:", forControlEvents: UIControlEvents.TouchUpInside)
        missFT5.frame = CGRectMake(self.view.frame.size.width / 6 * 2, self.view.frame.height / 12 * 9 + 16, (self.view.frame.size.width / 6) - 8, (self.view.frame.size.height / 12) - 4)
        missFT5.setTitle("MISS FT", forState: UIControlState.Normal)
        missFT5.backgroundColor = gray
        missFT5.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        missFT5.tag = 4
        self.view.addSubview(missFT5)
        
    }
    
    
    
    
    func addMissed2Buttons() {
        missedTwo1.addTarget(self, action: "missedTwo:", forControlEvents: UIControlEvents.TouchUpInside)
        missedTwo1.frame = CGRectMake(self.view.frame.size.width / 6 * 3, self.view.frame.height / 12, (self.view.frame.size.width / 6) - 8, (self.view.frame.size.height / 12) - 4)
        missedTwo1.setTitle("MISS 2PTR", forState: UIControlState.Normal)
        missedTwo1.backgroundColor = UIColor.purpleColor()
        missedTwo1.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        missedTwo1.tag = 0
        self.view.addSubview(missedTwo1)
        
        missedTwo2.addTarget(self, action: "missedTwo:", forControlEvents: UIControlEvents.TouchUpInside)
        missedTwo2.frame = CGRectMake(self.view.frame.size.width / 6 * 3, self.view.frame.height / 12 * 3 + 4, (self.view.frame.size.width / 6) - 8, (self.view.frame.size.height / 12) - 4)
        missedTwo2.setTitle("MISS 2PTR", forState: UIControlState.Normal)
        missedTwo2.backgroundColor = UIColor.purpleColor()
        missedTwo2.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        missedTwo2.tag = 1
        self.view.addSubview(missedTwo2)
        
        missedTwo3.addTarget(self, action: "missedTwo:", forControlEvents: UIControlEvents.TouchUpInside)
        missedTwo3.frame = CGRectMake(self.view.frame.size.width / 6 * 3, self.view.frame.height / 12 * 5 + 8, (self.view.frame.size.width / 6) - 8, (self.view.frame.size.height / 12) - 4)
        missedTwo3.setTitle("MISS 2PTR", forState: UIControlState.Normal)
        missedTwo3.backgroundColor = UIColor.purpleColor()
        missedTwo3.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        missedTwo3.tag = 2
        self.view.addSubview(missedTwo3)
        
        missedTwo4.addTarget(self, action: "missedTwo:", forControlEvents: UIControlEvents.TouchUpInside)
        missedTwo4.frame = CGRectMake(self.view.frame.size.width / 6 * 3, self.view.frame.height / 12 * 7 + 12, (self.view.frame.size.width / 6) - 8, (self.view.frame.size.height / 12) - 4)
        missedTwo4.setTitle("MISS 2PTR", forState: UIControlState.Normal)
        missedTwo4.backgroundColor = UIColor.purpleColor()
        missedTwo4.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        missedTwo4.tag = 3
        self.view.addSubview(missedTwo4)
        
        missedTwo5.addTarget(self, action: "missedTwo:", forControlEvents: UIControlEvents.TouchUpInside)
        missedTwo5.frame = CGRectMake(self.view.frame.size.width / 6 * 3, self.view.frame.height / 12 * 9 + 16, (self.view.frame.size.width / 6) - 8, (self.view.frame.size.height / 12) - 4)
        missedTwo5.setTitle("MISS 2PTR", forState: UIControlState.Normal)
        missedTwo5.backgroundColor = UIColor.purpleColor()
        missedTwo5.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        missedTwo5.tag = 4
        self.view.addSubview(missedTwo5)
        
    }
    
    
    func addMissedThreeButtons() {
        missedThree1.addTarget(self, action: "missedThree:", forControlEvents: UIControlEvents.TouchUpInside)
        missedThree1.frame = CGRectMake(self.view.frame.size.width / 6 * 4, self.view.frame.height / 12, (self.view.frame.size.width / 6) - 8, (self.view.frame.size.height / 12) - 4)
        missedThree1.setTitle("MISS 3PTR", forState: UIControlState.Normal)
        missedThree1.backgroundColor = UIColor.orangeColor()
        missedThree1.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        missedThree1.tag = 0
        self.view.addSubview(missedThree1)
        
        missedThree2.addTarget(self, action: "missedThree:", forControlEvents: UIControlEvents.TouchUpInside)
        missedThree2.frame = CGRectMake(self.view.frame.size.width / 6 * 4, self.view.frame.height / 12 * 3 + 4, (self.view.frame.size.width / 6) - 8, (self.view.frame.size.height / 12) - 4)
        missedThree2.setTitle("MISS 3PTR", forState: UIControlState.Normal)
        missedThree2.backgroundColor = UIColor.orangeColor()
        missedThree2.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        missedThree2.tag = 1
        self.view.addSubview(missedThree2)
        
        missedThree3.addTarget(self, action: "missedThree:", forControlEvents: UIControlEvents.TouchUpInside)
        missedThree3.frame = CGRectMake(self.view.frame.size.width / 6 * 4, self.view.frame.height / 12 * 5 + 8, (self.view.frame.size.width / 6) - 8, (self.view.frame.size.height / 12) - 4)
        missedThree3.setTitle("MISS 3PTR", forState: UIControlState.Normal)
        missedThree3.backgroundColor = UIColor.orangeColor()
        missedThree3.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        missedThree3.tag = 2
        self.view.addSubview(missedThree3)
        
        missedThree4.addTarget(self, action: "missedThree:", forControlEvents: UIControlEvents.TouchUpInside)
        missedThree4.frame = CGRectMake(self.view.frame.size.width / 6 * 4, self.view.frame.height / 12 * 7 + 12, (self.view.frame.size.width / 6) - 8, (self.view.frame.size.height / 12) - 4)
        missedThree4.setTitle("MISS 3PTR", forState: UIControlState.Normal)
        missedThree4.backgroundColor = UIColor.orangeColor()
        missedThree4.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        missedThree4.tag = 3
        self.view.addSubview(missedThree4)
        
        missedThree5.addTarget(self, action: "missedThree:", forControlEvents: UIControlEvents.TouchUpInside)
        missedThree5.frame = CGRectMake(self.view.frame.size.width / 6 * 4, self.view.frame.height / 12 * 9 + 16, (self.view.frame.size.width / 6) - 8, (self.view.frame.size.height / 12) - 4)
        missedThree5.setTitle("MISS 3PTR", forState: UIControlState.Normal)
        missedThree5.backgroundColor = UIColor.orangeColor()
        missedThree5.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        missedThree5.tag = 4
        self.view.addSubview(missedThree5)
    }
    
    
    
    func addAssistButtons() {
        
        let blue = UIColor(red:0.0, green:0.0, blue:0.5, alpha:1.0)
        
        assist1.addTarget(self, action: "madeAssist:", forControlEvents: UIControlEvents.TouchUpInside)
        assist1.frame = CGRectMake(self.view.frame.size.width / 6 * 5, self.view.frame.height / 12, (self.view.frame.size.width / 6) - 8, (self.view.frame.size.height / 12) - 4)
        assist1.setTitle("ASSIST", forState: UIControlState.Normal)
        assist1.backgroundColor = blue
        assist1.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        assist1.tag = 0
        self.view.addSubview(assist1)
        
        assist2.addTarget(self, action: "madeAssist:", forControlEvents: UIControlEvents.TouchUpInside)
        assist2.frame = CGRectMake(self.view.frame.size.width / 6 * 5, self.view.frame.height / 12 * 3 + 4, (self.view.frame.size.width / 6) - 8, (self.view.frame.size.height / 12) - 4)
        assist2.setTitle("ASSIST", forState: UIControlState.Normal)
        assist2.backgroundColor = blue
        assist2.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        assist2.tag = 1
        self.view.addSubview(assist2)
        
        assist3.addTarget(self, action: "madeAssist:", forControlEvents: UIControlEvents.TouchUpInside)
        assist3.frame = CGRectMake(self.view.frame.size.width / 6 * 5, self.view.frame.height / 12 * 5 + 8, (self.view.frame.size.width / 6) - 8, (self.view.frame.size.height / 12) - 4)
        assist3.setTitle("ASSIST", forState: UIControlState.Normal)
        assist3.backgroundColor = blue
        assist3.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        assist3.tag = 2
        self.view.addSubview(assist3)
        
        assist4.addTarget(self, action: "madeAssist:", forControlEvents: UIControlEvents.TouchUpInside)
        assist4.frame = CGRectMake(self.view.frame.size.width / 6 * 5, self.view.frame.height / 12 * 7 + 12, (self.view.frame.size.width / 6) - 8, (self.view.frame.size.height / 12) - 4)
        assist4.setTitle("ASSIST", forState: UIControlState.Normal)
        assist4.backgroundColor = blue
        assist4.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        assist4.tag = 3
        self.view.addSubview(assist4)
        
        assist5.addTarget(self, action: "madeAssist:", forControlEvents: UIControlEvents.TouchUpInside)
        assist5.frame = CGRectMake(self.view.frame.size.width / 6 * 5, self.view.frame.height / 12 * 9 + 16, (self.view.frame.size.width / 6) - 8, (self.view.frame.size.height / 12) - 4)
        assist5.setTitle("ASSIST", forState: UIControlState.Normal)
        assist5.backgroundColor = blue
        assist5.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        assist5.tag = 4
        self.view.addSubview(assist5)
    }
    
    func addSubButton() {
        subButton.addTarget(self, action: "goToSub:", forControlEvents: UIControlEvents.TouchUpInside)
        subButton.frame = CGRectMake(self.view.frame.size.width / 2, self.view.frame.height / 48 * 43, self.view.frame.size.width / 2, (self.view.frame.size.height / 48) * 5)
        subButton.setTitle("Substitutions", forState: UIControlState.Normal)
        subButton.backgroundColor = UIColor.blueColor()
        subButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        self.view.addSubview(subButton)
        
        homeButton.addTarget(self, action: "returnHome:", forControlEvents: UIControlEvents.TouchUpInside)
        homeButton.frame = CGRectMake(0 , self.view.frame.height / 48 * 43, self.view.frame.size.width / 2, (self.view.frame.size.height / 48) * 5)
        homeButton.setTitle("Home", forState: UIControlState.Normal)
        homeButton.backgroundColor = UIColor.redColor()
        homeButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        self.view.addSubview(homeButton)
    }
    
    func goToSub(sender: UIButton) {
        performSegueWithIdentifier("subPlayers", sender: nil)
    }
    
    func returnHome(sender: UIButton) {
        performSegueWithIdentifier("scoringToHome", sender: nil)
    }
    
    
    func setNameLabels() {
        var counter = 0
        let nameLabels = [name1, name2, name3, name4, name5]
        for(var i=0; i<players.count; i++) {
            if((players[i].valueForKey("inlineup") as! Bool)) {
                if((players[i].valueForKey("game") as! Int) == game) {
                    nameLabels[counter].text = players[i].valueForKey("name") as! String
                    lineup.append(players[i].valueForKey("name") as! String)
                    counter++
                }
            } else {
                if(!(players[i].valueForKey("inlineup") as! Bool)) {
                    bench.append(players[i].valueForKey("name") as! String)
                }
            }
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        setNameLabels()
        if(firstTime == true) {
            let alert = UIAlertController(title: "Opponent", message: "", preferredStyle: .Alert)
            alert.addTextFieldWithConfigurationHandler({ (textField) -> Void in
                
            })
            
            alert.addAction(UIAlertAction(title: "Done", style: .Default, handler: { (action) -> Void in
                let textField = alert.textFields![0]
                //CoreData stuff
                let appDelegate =
                UIApplication.sharedApplication().delegate as! AppDelegate
                let managedContext = appDelegate.managedObjectContext
                let entity =  NSEntityDescription.entityForName("Game",
                    inManagedObjectContext:
                    managedContext)
                
                
                self.games[self.game].setValue(textField.text, forKey: "opponent")
                
                self.performSegueWithIdentifier("subPlayers", sender: nil)
                
                do {
                    try managedContext.save()
                } catch _ {
                }
                
            }))
            self.presentViewController(alert, animated: true, completion: nil)
            
        }
    }
    
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "subPlayers" {
            
            let controller = segue.destinationViewController as! SubViewController
        
            controller.games = games
            controller.game = game
            
        }
    }
    
    
    
    func made2ptr(sender: UIButton) {
        //CoreData stuff
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let entity =  NSEntityDescription.entityForName("Player",
            inManagedObjectContext:
            managedContext)
        
        let playersIdx = searchPlayers(lineup[sender.tag])
        
        print(players[playersIdx].valueForKey("name"))
        
        var value = players[playersIdx].valueForKey("twopointersmade") as! Int
        value++
        self.players[playersIdx].setValue(value, forKey: "twopointersmade")
        do {
            try managedContext.save()
        } catch _ {
        }
        
    }
    
    
    func madeThree(sender: UIButton) {
        //CoreData stuff
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let entity =  NSEntityDescription.entityForName("Player",
            inManagedObjectContext:
            managedContext)
        
        let playersIdx = searchPlayers(lineup[sender.tag])
        
        print(players[playersIdx].valueForKey("name"))
        
        var value = players[playersIdx].valueForKey("threepointersmade") as! Int
        value++
        self.players[playersIdx].setValue(value, forKey: "threepointersmade")
        do {
            try managedContext.save()
        } catch _ {
        }
        
    }
    
    
    func madeAssist(sender: UIButton) {
        //CoreData stuff
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let entity =  NSEntityDescription.entityForName("Player",
            inManagedObjectContext:
            managedContext)
        
        let playersIdx = searchPlayers(lineup[sender.tag])
        
        var value = players[playersIdx].valueForKey("assists") as! Int
        value++
        self.players[playersIdx].setValue(value, forKey: "assists")
        do {
            try managedContext.save()
        } catch _ {
        }
    }
    
    func madeRebound(sender: UIButton) {
        //CoreData stuff
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let entity =  NSEntityDescription.entityForName("Player",
            inManagedObjectContext:
            managedContext)
        
        let playersIdx = searchPlayers(lineup[sender.tag])
        
        var value = players[playersIdx].valueForKey("rebounds") as! Int
        value++
        self.players[playersIdx].setValue(value, forKey: "rebounds")
        do {
            try managedContext.save()
        } catch _ {
        }
    }
    
    func missedTwo(sender: UIButton) {
        //CoreData stuff
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let entity =  NSEntityDescription.entityForName("Player",
            inManagedObjectContext:
            managedContext)
        
        let playersIdx = searchPlayers(lineup[sender.tag])
        
        var value = players[playersIdx].valueForKey("missedtwopointers") as! Int
        value++
        self.players[playersIdx].setValue(value, forKey: "missedtwopointers")
        do {
            try managedContext.save()
        } catch _ {
        }
    }
    
    func missedThree(sender: UIButton) {
        //CoreData stuff
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let entity =  NSEntityDescription.entityForName("Player",
            inManagedObjectContext:
            managedContext)
        
        let playersIdx = searchPlayers(lineup[sender.tag])
        
        var value = players[playersIdx].valueForKey("missedthreepointers") as! Int
        value++
        self.players[playersIdx].setValue(value, forKey: "missedthreepointers")
        do {
            try managedContext.save()
        } catch _ {
        }
    }
    
    func missFT(sender: UIButton) {
        //CoreData stuff
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let entity =  NSEntityDescription.entityForName("Player",
            inManagedObjectContext:
            managedContext)
        
        let playersIdx = searchPlayers(lineup[sender.tag])
        
        var value = players[playersIdx].valueForKey("missedfreethrows") as! Int
        value++
        self.players[playersIdx].setValue(value, forKey: "missedfreethrows")
        do {
            try managedContext.save()
        } catch _ {
        }
    }
    
    func madeFT(sender: UIButton) {
        //CoreData stuff
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let entity =  NSEntityDescription.entityForName("Player",
            inManagedObjectContext:
            managedContext)
        
        let playersIdx = searchPlayers(lineup[sender.tag])
        
        var value = players[playersIdx].valueForKey("madefreethrows") as! Int
        value++
        self.players[playersIdx].setValue(value, forKey: "madefreethrows")
        do {
            try managedContext.save()
        } catch _ {
        }
    }
    
    
    
    
    func searchPlayers(name: String) -> Int {
        for(var i=0; i<players.count; i++) {
            let pName = players[i].valueForKey("name") as! String
            let gNum = players[i].valueForKey("game") as! Int
            if((pName == name) && (gNum == game)) {
                return i
            }
        }
        return -1
    }
}
