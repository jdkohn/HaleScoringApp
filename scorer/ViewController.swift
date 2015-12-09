//
//  ViewController.swift
//  scorer
//
//  Created by Jacob Kohn on 11/30/15.
//  Copyright © 2015 Jacob Kohn. All rights reserved.
//

import UIKit
import CoreData
import Foundation

class ViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var addGameButton: UIButton!
    
    @IBOutlet weak var pastGamesTable: UITableView!
    
    var games = [NSManagedObject]()
    var players = [NSManagedObject]()
    
    let NathanHale = ["Sam Leach","Sam Nasralla","Malik Johnson","Ishmael Simpson", "Luke Alkire","Stieg Smith", "TJ Williams","Dempsey Hope","Kateel Barnett","Malcolm Gulyard","Khepra Mims", "Niles Bateman","Phil Asmelash", "Carter Petro","Langston Barlow"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        addGameButton.addTarget(self, action: "newGame:", forControlEvents: UIControlEvents.TouchUpInside)
        
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
        
        pastGamesTable.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func newGame(sender: UIButton) {
        performSegueWithIdentifier("goToStatEntry", sender: nil)
    }
    
    // MARK: UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) 
        
        
        cell.textLabel!.text = (games[indexPath.row].valueForKey("opponent") as! String) + " on " + (games[indexPath.row].valueForKey("date") as! String)
        if((indexPath.row as Int) % 2 == 0 ) {
            cell.backgroundColor = UIColor.lightGrayColor()
        } else {
            cell.backgroundColor = UIColor.whiteColor()
        }
        
        
        return cell
    }
    
    
    //remove item from list
    func tableView(tableView: UITableView, commitEditingStyle editingStyle:
        UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
            if editingStyle == .Delete {
                
                //CoreData stuff
                let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                let managedContext = appDelegate.managedObjectContext
                let entity =  NSEntityDescription.entityForName("Game",
                    inManagedObjectContext:
                    managedContext)
                
                managedContext.deleteObject(games[indexPath.row])
                
                games.removeAtIndex(indexPath.row)
                
                print("!")
                
                for(var i=0; i<players.count; i++) {
                    if(players[i].valueForKey("game") as! Int == indexPath.row) {
                        managedContext.deleteObject(players[i])
                        players.removeAtIndex(i)
                        i = i - 1
                    }
                }
                
                print("!")

                reduceGameIDsByOne(indexPath.row)
                reduceGameNumsByOne(indexPath.row)
                
                print("!")
                
                do {
                    try managedContext.save()
                } catch _ {
                }
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
                
                
                
                
            } else if editingStyle == .Insert {
                // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
            }
    }
    
    func reduceGameNumsByOne(row: Int) {
        //CoreData stuff
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let entity =  NSEntityDescription.entityForName("Player",
            inManagedObjectContext:
            managedContext)
        
        
        for(var i=0; i<players.count; i++) {
            if let gamenum = players[i].valueForKey("game") {
                if((gamenum as! Int) > row) {
                    players[i].setValue((gamenum as! Int) - 1, forKey: "game")
                }
            }
        }
    }
    
    func reduceGameIDsByOne(row: Int) {
        //CoreData stuff
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let entity =  NSEntityDescription.entityForName("Game",
            inManagedObjectContext:
            managedContext)
        
        
        
        for(var l=row; l<games.count; l++) {
            if let id = games[l].valueForKey("id") {
                games[l].setValue((id as! Int) - 1, forKey: "id")
            }
        }
    }
    
    func getDate() -> String {
        
        //get the month
        let getMonth = NSDateFormatter()
        getMonth.dateFormat = "MM"
        let monthNum = getMonth.stringFromDate(NSDate())
        
        //get the day
        let getDay = NSDateFormatter()
        getDay.dateFormat = "dd"
        var day = getDay.stringFromDate(NSDate())
        
        if(Int(day) < 10) {
            day =  String(day[day.endIndex.predecessor()])
        }
        
        var month = ""
        
        if(monthNum == "01") { month = "January" }
        else if(monthNum == "02") { month = "February" }
        else if(monthNum == "03") { month = "March" }
        else if(monthNum == "04") { month = "April" }
        else if(monthNum == "05") { month = "May" }
        else if(monthNum == "06") { month = "June" }
        else if(monthNum == "07") { month = "July" }
        else if(monthNum == "08") { month = "August" }
        else if(monthNum == "09") { month = "September" }
        else if(monthNum == "10") { month = "October" }
        else if(monthNum == "11") { month = "November" }
        else if(monthNum == "12") { month = "December" }
        
        let date = month + " " + day
        
        return date
        
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "goToStatEntry" {
 
            let newGameNum = games.count
            
            let controller = segue.destinationViewController as! ScoringViewController
            
            //CoreData stuff
            let appDelegate =
            UIApplication.sharedApplication().delegate as! AppDelegate
            let managedContext = appDelegate.managedObjectContext
            let entity =  NSEntityDescription.entityForName("Game",
                inManagedObjectContext:
                managedContext)
            
            let date = getDate()
            
            //creates new swing object
            let gameObject = NSManagedObject(entity: entity!,
                insertIntoManagedObjectContext:managedContext)
            gameObject.setValue(newGameNum, forKey: "id")
            gameObject.setValue(date, forKey: "date")
            
            var error: NSError?
            do {
                try managedContext.save()
            } catch var error1 as NSError {
                error = error1
                print("Could not save \(error), \(error?.userInfo)")
            }
            
            games.insert(gameObject, atIndex: games.count)
            
            
            for(var i=0; i<NathanHale.count; i++) {
            
                let e =  NSEntityDescription.entityForName("Player",
                    inManagedObjectContext:
                    managedContext)
                
                //creates new swing object
                let playerObject = NSManagedObject(entity: e!,
                    insertIntoManagedObjectContext:managedContext)
                playerObject.setValue(newGameNum, forKey: "game")
                playerObject.setValue(NathanHale[i], forKey: "name")
                playerObject.setValue(false, forKey: "inlineup")
                
                var error: NSError?
                do {
                    try managedContext.save()
                } catch var error1 as NSError {
                    error = error1
                    print("Could not save \(error), \(error?.userInfo)")
                }
                
                players.insert(gameObject, atIndex: i)
                
            }
            do {
                try managedContext.save()
            } catch _ {
            }
            
            controller.game = newGameNum
            controller.firstTime = true
            controller.players = players
        }
        if(segue.identifier == "goToBoxScore") {
            if let indexPath = self.pastGamesTable.indexPathForSelectedRow {
                let controller = segue.destinationViewController as! BoxScoreViewController
                controller.game = indexPath.row
                
                let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                let managedContext = appDelegate.managedObjectContext
                let fetchRequest = NSFetchRequest(entityName:"Player")
                let error: NSError?
                var fetchedResults = [NSManagedObject]()
                do {
                    fetchedResults = try managedContext.executeFetchRequest(fetchRequest) as! [NSManagedObject]
                } catch let error as NSError {
                    print("Fetch failed: \(error.localizedDescription)")
                }
                let pList = fetchedResults
                var playersFromGame = [NSManagedObject]()
                
                for(var i=0; i<pList.count; i++) {
                    if(pList[i].valueForKey("game") as! Int == indexPath.row) {
                        playersFromGame.insert(pList[i], atIndex: playersFromGame.count)
                    }
                }
    
                controller.players = playersFromGame
            }
        }
    }
}

