//
//  PlayerViewController.swift
//  scorer
//
//  Created by Jacob Kohn on 12/2/15.
//  Copyright © 2015 Jacob Kohn. All rights reserved.
//

import UIKit
import CoreData
import Foundation

class PlayerViewController: UIViewController {
    
    @IBOutlet weak var playerNameLabel: UILabel!
    
    
    var players = [NSManagedObject]()
    var game = Int()
    var player = Int()
    var opponent = String()
    var date = String()
    
    
    let blankLabel = UILabel()
    let pointsLabel = UILabel()
    let shootingLabel = UILabel()
    let assistsLabel = UILabel()
    let reboundsLabel = UILabel()
    let threeShootingLabel = UILabel()
    let FTShootingLabel = UILabel()
    let fantasyPointsLabel = UILabel()
    
    
    let gameLabel = UILabel()
    let gPointsLabel = UILabel()
    let gShootingLabel = UILabel()
    let gAssistsLabel = UILabel()
    let gReboundsLabel = UILabel()
    let gThreeShootingLabel = UILabel()
    let gFTShootingLabel = UILabel()
    let gFantasyPointsLabel = UILabel()
    
    let averageLabel = UILabel()
    let aPointsLabel = UILabel()
    let aShootingLabel = UILabel()
    let aThreeShootingLabel = UILabel()
    let aFTShootingLabel = UILabel()
    let aAssistsLabel = UILabel()
    let aReboundsLabel = UILabel()
    
    let aFantasyPointsLabel = UILabel()
    
    
    let NathanHale = ["Sam Leach","Sam Nasralla","Malik Johnson","Ishmael Simpson", "Luke Alkire","Stieg Smith", "TJ Williams","Dempsey Hope","Kateel Barnett","Malcolm Gulyard","Khepra Mims", "Niles Bateman","Phil Asmelash", "Carter Petro","Langston Barlow"]
    let backButton = UIButton()
    let forwardButton = UIButton()
    let boxScoreButton = UIButton()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        playerNameLabel.text = (players[player].valueForKey("name") as! String) + " vs. " + opponent + " on " + date
        
        makeButtons()
        
        addLabels()
        
    }
    
    func addLabels() {
        
        //creates static labels
        let labels = [blankLabel, pointsLabel,shootingLabel, threeShootingLabel, FTShootingLabel, assistsLabel,reboundsLabel,fantasyPointsLabel]
        let labelsText = ["","Points", "Shooting", "3-Point Shooting", "Free Throws", "Assists", "Rebounds","Fantasy"]
        for(var i=0; i<labels.count; i++) {
            let label = labels[i]
            label.frame = CGRectMake(((self.view.frame.size.width / CGFloat(labels.count)) * CGFloat(i)), (self.view.frame.size.height / 5), (self.view.frame.size.width / CGFloat(labels.count)), (self.view.frame.size.height / 5) - 4)
            label.text = labelsText[i]
            label.textAlignment = NSTextAlignment.Center
            self.view.addSubview(label)
        }
        
        //creates current game labels
        
        let gameLabels = [gameLabel, gPointsLabel,gShootingLabel, gThreeShootingLabel, gFTShootingLabel, gAssistsLabel,gReboundsLabel,gFantasyPointsLabel]
        
        let madeFTs = ((players[player].valueForKey("madefreethrows") as! Int))
        let madeTwos = (players[player].valueForKey("twopointersmade") as! Int)
        let madeThrees = (players[player].valueForKey("threepointersmade") as! Int)
        let missedFTs = (players[player].valueForKey("missedfreethrows") as! Int)
        let missedTwos = (players[player].valueForKey("missedtwopointers") as! Int)
        let missedThrees = (players[player].valueForKey("missedthreepointers") as! Int)
        let assists = players[player].valueForKey("assists") as! Int
        let rebounds = players[player].valueForKey("rebounds") as! Int
        
        let gamePoints = madeFTs + (madeTwos * 2) + (madeThrees * 3)
        let madeShots = madeTwos + madeThrees
        let totalShots = madeShots + missedTwos + missedThrees
        
        let shooting = String(madeShots) + "-" + String(totalShots)
        let treShooting = String(madeThrees) + "-" + String(missedThrees + madeThrees)
        let ftShooting = String(madeFTs) + "-" + String(madeFTs + missedFTs)
        
        let fantasyPoints = gamePoints + assists + rebounds
        
        let gameLabelsText = ["Game",String(gamePoints),shooting, treShooting,ftShooting, String(assists),String(rebounds), String(fantasyPoints)]
        
        for(var i=0; i<labels.count; i++) {
            let label = gameLabels[i]
            label.frame = CGRectMake(((self.view.frame.size.width / CGFloat(gameLabels.count)) * CGFloat(i)), (self.view.frame.size.height / 5) * 2, (self.view.frame.size.width / CGFloat(gameLabels.count)), (self.view.frame.size.height / 5) - 4)
            label.text = gameLabelsText[i]
            label.textAlignment = NSTextAlignment.Center
            self.view.addSubview(label)
        }
        
        //average row
        
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        let averageLabels = [averageLabel, aPointsLabel,aShootingLabel, aThreeShootingLabel, aFTShootingLabel, aAssistsLabel,aReboundsLabel,aFantasyPointsLabel]
        
        let fetchReq = NSFetchRequest(entityName:"Player")
        let err: NSError?
        var fetchedR = [NSManagedObject]()
        do {
            fetchedR = try managedContext.executeFetchRequest(fetchReq) as! [NSManagedObject]
        } catch let err as NSError {
            
            print("Fetch failed: \(err.localizedDescription)")
        }
        let allP = fetchedR
        
        var aPoints = 0
        var aMadeFTs = 0
        var aMadeTwos = 0
        var aMadeThrees = 0
        var aMissedFTs = 0
        var aMissedTwos = 0
        var aMissedThrees = 0
        var aAssists = 0
        var aRebounds = 0
        var aFantasyPoints = 0
        var c = 0
        
        for(var i=0; i<allP.count; i++) {
            if((allP[i].valueForKey("name") as! String) == (players[player].valueForKey("name") as! String)) {
                let tMadeFTs = ((players[player].valueForKey("madefreethrows") as! Int))
                let tMadeTwos = (players[player].valueForKey("twopointersmade") as! Int)
                let tMadeThrees = (players[player].valueForKey("threepointersmade") as! Int)
                let tMissedFTs = (players[player].valueForKey("missedfreethrows") as! Int)
                let tMissedTwos = (players[player].valueForKey("missedtwopointers") as! Int)
                let tMissedThrees = (players[player].valueForKey("missedthreepointers") as! Int)
                let tAssists = players[player].valueForKey("assists") as! Int
                let tRebounds = players[player].valueForKey("rebounds") as! Int
                
                var tPoints = tMadeFTs + (tMadeTwos * 2) + (tMadeThrees * 3)
                
                aPoints = aPoints + tPoints
                aMadeFTs = aMadeFTs + tMadeFTs
                aMadeTwos = aMadeTwos + tMadeTwos
                aMadeThrees = aMadeThrees + tMadeThrees
                aMissedFTs = aMissedFTs + tMissedFTs
                aMissedTwos = aMissedTwos + tMissedTwos
                aMissedThrees = aMissedThrees + tMissedThrees
                aAssists = aAssists + tAssists
                aRebounds = aRebounds + tRebounds

                aFantasyPoints = aFantasyPoints + tPoints + tAssists + tRebounds
                c++
            }
        }
        
        let counter = Float(c)
        var aPointsF = Float(aPoints)

        var aMadeFTsF = Float(aMadeFTs)
        var aMadeTwosF = Float(aMadeTwos)
        var aMadeThreesF = Float(aMadeThrees)
        var aMissedFTsF = Float(aMissedFTs)
        var aMissedTwosF = Float(aMissedTwos)
        var aMissedThreesF = Float(aMissedThrees)
        
        var aAssistsF = Float(aAssists)
        var aReboundsF = Float(aRebounds)

        var aFantasyPointsF = Float(aFantasyPoints)
        
        var totalMakesF = aMadeTwosF + aMadeThreesF
        var totalShotsF = (aMissedTwosF + aMissedThreesF + totalMakesF) / counter
        var aTotalThrees = (aMadeThreesF + aMissedThreesF) / counter
        totalMakesF = totalMakesF / counter
        aMadeThreesF = aMadeThreesF / counter
        
        var aTotalFTs = (aMadeFTsF + aMissedFTsF) / counter
        aMadeFTsF = aMadeFTsF / counter
        
        
        aPointsF = aPointsF / counter
        aMadeTwosF = aMadeTwosF / counter
        totalShotsF = totalShotsF / counter
  
        aAssistsF = aAssistsF / counter
        aReboundsF = aReboundsF / counter

        aFantasyPointsF = aFantasyPointsF / counter
        
        let aShooting = String(totalMakesF) + "-" + String(totalShotsF)
        let aThreeShooting = String(aMadeThreesF) + "-" + String(aTotalThrees)
        let aFTShooting = String(aMadeFTs) + "-" + String(aTotalFTs)
        
        let averageLabelsText = ["Average",String(aPointsF),aShooting,aThreeShooting, aFTShooting, String(aAssistsF),String(aReboundsF), String(aFantasyPointsF)]
        
        for(var i=0; i<labels.count; i++) {
            let label = averageLabels[i]
            label.frame = CGRectMake(((self.view.frame.size.width / CGFloat(averageLabels.count)) * CGFloat(i)), (self.view.frame.size.height / 5) * 3, (self.view.frame.size.width / CGFloat(averageLabels.count)), (self.view.frame.size.height / 5) - 4)
            label.text = averageLabelsText[i]
            label.textAlignment = NSTextAlignment.Center
            self.view.addSubview(label)
        }
        
        
    }
    
    func updateGameLabels() {
        let gameLabels = [gameLabel, gPointsLabel,gShootingLabel, gThreeShootingLabel, gFTShootingLabel, gAssistsLabel,gReboundsLabel,gFantasyPointsLabel]
        
        let madeFTs = ((players[player].valueForKey("madefreethrows") as! Int))
        let madeTwos = (players[player].valueForKey("twopointersmade") as! Int)
        let madeThrees = (players[player].valueForKey("threepointersmade") as! Int)
        let missedFTs = (players[player].valueForKey("missedfreethrows") as! Int)
        let missedTwos = (players[player].valueForKey("missedtwopointers") as! Int)
        let missedThrees = (players[player].valueForKey("missedthreepointers") as! Int)
        let assists = players[player].valueForKey("assists") as! Int
        let rebounds = players[player].valueForKey("rebounds") as! Int
        
        let gamePoints = madeFTs + (madeTwos * 2) + (madeThrees * 3)
        let madeShots = madeTwos + madeThrees
        let totalShots = madeShots + missedTwos + missedThrees
        
        let shooting = String(madeShots) + "-" + String(totalShots)
        let treShooting = String(madeThrees) + "-" + String(missedThrees + madeThrees)
        let ftShooting = String(madeFTs) + "-" + String(madeFTs + missedFTs)
        
        let fantasyPoints = gamePoints + assists + rebounds
        
        let gameLabelsText = ["Game",String(gamePoints),shooting, treShooting,ftShooting, String(assists),String(rebounds), String(fantasyPoints)]
        
        for(var i=0; i<gameLabels.count; i++) {
            let label = gameLabels[i]
            label.text = gameLabelsText[i]
        }
        
        //average row
        
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        let averageLabels = [averageLabel, aPointsLabel,aShootingLabel, aThreeShootingLabel, aFTShootingLabel, aAssistsLabel,aReboundsLabel,aFantasyPointsLabel]
        
        let fetchReq = NSFetchRequest(entityName:"Player")
        let err: NSError?
        var fetchedR = [NSManagedObject]()
        do {
            fetchedR = try managedContext.executeFetchRequest(fetchReq) as! [NSManagedObject]
        } catch let err as NSError {
            
            print("Fetch failed: \(err.localizedDescription)")
        }
        let allP = fetchedR
        
        var aPoints = 0
        var aMadeFTs = 0
        var aMadeTwos = 0
        var aMadeThrees = 0
        var aMissedFTs = 0
        var aMissedTwos = 0
        var aMissedThrees = 0
        var aAssists = 0
        var aRebounds = 0
        var aFantasyPoints = 0
        var c = 0
        
        for(var i=0; i<allP.count; i++) {
            if((allP[i].valueForKey("name") as! String) == (players[player].valueForKey("name") as! String)) {
                let tMadeFTs = ((players[player].valueForKey("madefreethrows") as! Int))
                let tMadeTwos = (players[player].valueForKey("twopointersmade") as! Int)
                let tMadeThrees = (players[player].valueForKey("threepointersmade") as! Int)
                let tMissedFTs = (players[player].valueForKey("missedfreethrows") as! Int)
                let tMissedTwos = (players[player].valueForKey("missedtwopointers") as! Int)
                let tMissedThrees = (players[player].valueForKey("missedthreepointers") as! Int)
                let tAssists = players[player].valueForKey("assists") as! Int
                let tRebounds = players[player].valueForKey("rebounds") as! Int
                
                var tPoints = tMadeFTs + (tMadeTwos * 2) + (tMadeThrees * 3)
                
                aPoints = aPoints + tPoints
                aMadeFTs = aMadeFTs + tMadeFTs
                aMadeTwos = aMadeTwos + tMadeTwos
                aMadeThrees = aMadeThrees + tMadeThrees
                aMissedFTs = aMissedFTs + tMissedFTs
                aMissedTwos = aMissedTwos + tMissedTwos
                aMissedThrees = aMissedThrees + tMissedThrees
                aAssists = aAssists + tAssists
                aRebounds = aRebounds + tRebounds
                
                aFantasyPoints = aFantasyPoints + tPoints + tAssists + tRebounds
                c++
            }
        }
        
        let counter = Float(c)
        var aPointsF = Float(aPoints)
        
        var aMadeFTsF = Float(aMadeFTs)
        var aMadeTwosF = Float(aMadeTwos)
        var aMadeThreesF = Float(aMadeThrees)
        var aMissedFTsF = Float(aMissedFTs)
        var aMissedTwosF = Float(aMissedTwos)
        var aMissedThreesF = Float(aMissedThrees)
        
        var aAssistsF = Float(aAssists)
        var aReboundsF = Float(aRebounds)
        
        var aFantasyPointsF = Float(aFantasyPoints)
        
        var totalMakesF = aMadeTwosF + aMadeThreesF
        var totalShotsF = (aMissedTwosF + aMissedThreesF + totalMakesF) / counter
        var aTotalThrees = (aMadeThreesF + aMissedThreesF) / counter
        totalMakesF = totalMakesF / counter
        aMadeThreesF = aMadeThreesF / counter
        
        var aTotalFTs = (aMadeFTsF + aMissedFTsF) / counter
        aMadeFTsF = aMadeFTsF / counter
        
        
        aPointsF = aPointsF / counter
        aMadeTwosF = aMadeTwosF / counter
        totalShotsF = totalShotsF / counter
        
        aAssistsF = aAssistsF / counter
        aReboundsF = aReboundsF / counter
        
        aFantasyPointsF = aFantasyPointsF / counter
        
        let aShooting = String(totalMakesF) + "-" + String(totalShotsF)
        let aThreeShooting = String(aMadeThreesF) + "-" + String(aTotalThrees)
        let aFTShooting = String(aMadeFTs) + "-" + String(aTotalFTs)
        
        let averageLabelsText = ["Average",String(aPointsF),aShooting,aThreeShooting, aFTShooting, String(aAssistsF),String(aReboundsF), String(aFantasyPointsF)]
        
        for(var i=0; i<averageLabels.count; i++) {
            let label = averageLabels[i]
            label.text = averageLabelsText[i]
        }
        
        
    }
    
    func previous(sender: UIButton) {
        if(player > 0) {
            player = player - 1
        } else {
            player = players.count - 1
        }
        updateGameLabels()
        var prevName = ""
        if(player > 0) {
            prevName = players[player - 1].valueForKey("name") as! String
        } else {
            prevName = players[players.count - 1].valueForKey("name") as! String
        }
        backButton.setTitle(prevName, forState: UIControlState.Normal)
        
        var nextName = ""
        if(player < players.count - 1) {
            nextName = players[player + 1].valueForKey("name") as! String
        } else {
            nextName = players[0].valueForKey("name") as! String
        }
        forwardButton.setTitle(nextName, forState: UIControlState.Normal)
        playerNameLabel.text = players[player].valueForKey("name") as! String + " vs. " + opponent
    }
    
    func next(sender: UIButton) {
        if(player < players.count - 1) {
            player = player + 1
        } else {
            player = 0
        }
        updateGameLabels()
        var prevName = ""
        if(player > 0) {
            prevName = players[player - 1].valueForKey("name") as! String
        } else {
            prevName = players[players.count - 1].valueForKey("name") as! String
        }
        backButton.setTitle(prevName, forState: UIControlState.Normal)
        
        var nextName = ""
        if(player < players.count - 1) {
            nextName = players[player + 1].valueForKey("name") as! String
        } else {
            nextName = players[0].valueForKey("name") as! String
        }
        forwardButton.setTitle(nextName, forState: UIControlState.Normal)
        playerNameLabel.text = players[player].valueForKey("name") as! String + " vs. " + opponent
    }
    
    func makeButtons() {
        
        let blue = UIColor(red:0.0, green:0.0, blue:0.5, alpha:1.0)
        
        backButton.frame = CGRectMake(0, self.view.frame.size.height - 44, self.view.frame.size.width / 4, 44)
        backButton.addTarget(self, action: "previous:", forControlEvents: UIControlEvents.TouchUpInside)
        var prevName = ""
        if(player > 0) {
            prevName = players[player - 1].valueForKey("name") as! String
        } else {
            prevName = players[players.count - 1].valueForKey("name") as! String
        }
        backButton.setTitle(prevName, forState: UIControlState.Normal)
        backButton.backgroundColor = blue
        backButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        self.view.addSubview(backButton)
        
        boxScoreButton.frame = CGRectMake(self.view.frame.size.width / 4, self.view.frame.size.height - 44, self.view.frame.size.width / 2, 44)
        boxScoreButton.addTarget(self, action: "backToBoxScore:", forControlEvents: UIControlEvents.TouchUpInside)
        boxScoreButton.setTitle("Return to Player List", forState: UIControlState.Normal)
        boxScoreButton.backgroundColor = UIColor.redColor()
        boxScoreButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        self.view.addSubview(boxScoreButton)
        
        forwardButton.frame = CGRectMake((self.view.frame.size.width / 4) * 3, self.view.frame.size.height - 44, self.view.frame.size.width / 4, 44)
        forwardButton.addTarget(self, action: "next:", forControlEvents: UIControlEvents.TouchUpInside)
        var nextName = ""
        if(player < players.count - 1) {
            nextName = players[player + 1].valueForKey("name") as! String
        } else {
            nextName = players[0].valueForKey("name") as! String
        }
        forwardButton.setTitle(nextName, forState: UIControlState.Normal)
        forwardButton.backgroundColor = blue
        forwardButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        self.view.addSubview(forwardButton)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func backToBoxScore(sender: UIButton) {
        performSegueWithIdentifier("backToBox", sender: nil)
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "backToBox") {
            
            let controller = segue.destinationViewController as! BoxScoreViewController
            controller.game = game
            controller.players = players
        }
    }
}
