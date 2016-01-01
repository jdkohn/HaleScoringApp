//
//  BoxScoreViewController.swift
//  scorer
//
//  Created by Jacob Kohn on 12/2/15.
//  Copyright © 2015 Jacob Kohn. All rights reserved.
//

import UIKit
import CoreData
import Foundation
//banana

class BoxScoreViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var boxScore: UITableView!
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var opponentLabel: UILabel!
    
    var games = [NSManagedObject]()
    @IBOutlet weak var nameLabel: UILabel!
    var players = [NSManagedObject]()
    var game = Int()
    
    let NathanHale = ["Sam Leach","Sam Nasralla","Julien Streetman","Ishmael Simpson", "Trey McAdams","Stieg Smith", "TJ Williams","Dempsey Hope","Kateel Barnett","Malcolm Gulyard","Khepra Mims"]
    let homeButton = UIButton()
    let editButton = UIButton()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
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
        
        for(var i = 0; i<games.count; i++) {
            if(games[i].valueForKey("id") as! Int == game) {
                var opponent = games[i].valueForKey("opponent") as! String
                var date = games[i].valueForKey("date") as! String
                opponentLabel.text = opponent + " on " + date
            }
        }
        
        print(players.count)
        
        for(var l=0; l<players.count; l++) {
            print(players[l].valueForKey("name"))
        }

        
        makeButtons()
        makeTable()
        
        
        boxScore.dataSource = self
    }
    
    func makeButtons() {
        homeButton.frame = CGRectMake(0, self.view.frame.size.height - 44, self.view.frame.size.width / 2, 44)
        homeButton.addTarget(self, action: "backToHome:", forControlEvents: UIControlEvents.TouchUpInside)
        homeButton.setTitle("Home", forState: UIControlState.Normal)
        homeButton.backgroundColor = UIColor.greenColor()
        homeButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        self.view.addSubview(homeButton)
        
        editButton.frame = CGRectMake(self.view.frame.size.width / 2, self.view.frame.size.height - 44, self.view.frame.size.width / 2, 44)
        editButton.addTarget(self, action: "editGame:", forControlEvents: UIControlEvents.TouchUpInside)
        editButton.setTitle("Edit", forState: UIControlState.Normal)
        editButton.backgroundColor = UIColor.redColor()
        editButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        self.view.addSubview(editButton)
    }
    
    func makeTable() {
        boxScore.frame = CGRectMake(0, 80, self.view.frame.size.width, self.view.frame.size.height - 124)
    }
    
    


    
     // MARK: UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("BoxCell", forIndexPath: indexPath)
        
        cell.textLabel!.text = players[indexPath.row].valueForKey("name") as? String
        
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
                let appDelegate =
                UIApplication.sharedApplication().delegate as! AppDelegate
                let managedContext = appDelegate.managedObjectContext
                let entity =  NSEntityDescription.entityForName("Game",
                    inManagedObjectContext:
                    managedContext)
                
                managedContext.deleteObject(games[indexPath.row])
                
                
                games.removeAtIndex(indexPath.row)
                do {
                    try managedContext.save()
                } catch _ {
                }
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
                
                
                
            } else if editingStyle == .Insert {
                // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
            }
    }
    
    
    func backToHome(sender: UIButton) {
        performSegueWithIdentifier("boxToHome", sender: nil)
    }
    
    func editGame(sender: UIButton) {
        performSegueWithIdentifier("boxToScoring", sender: nil)
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "showPlayerDetail") {
            if let indexPath = self.boxScore.indexPathForSelectedRow {
                let controller = segue.destinationViewController as! PlayerViewController
                controller.players = players
                controller.game = game
                controller.player = indexPath.row
                controller.opponent = games[game].valueForKey("opponent") as! String
                controller.date = games[game].valueForKey("date") as! String
            }
        }
        if(segue.identifier == "boxToScoring") {
            let controller = segue.destinationViewController as! ScoringViewController
            controller.players = players
            controller.game = game
            controller.games = games
        }
    }
    
}


