//
//  SubViewController.swift
//  scorer
//
//  Created by Jacob Kohn on 12/1/15.
//  Copyright © 2015 Jacob Kohn. All rights reserved.
//

import UIKit
import CoreData
import Foundation

class SubViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var outTable: UITableView!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var inTable: UITableView!
    
    var lineup = [String]()
    var bench = [String]()
    var counter = 0
    var game = Int()
    var games = [NSManagedObject]()
    var players = [NSManagedObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        outTable.dataSource = self
        inTable.dataSource = self
        doneButton.addTarget(self, action: "done:", forControlEvents: UIControlEvents.TouchUpInside)
        
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchReq = NSFetchRequest(entityName:"Player")
        let err: NSError?
        var fetchedR = [NSManagedObject]()
        do {
            fetchedR = try managedContext.executeFetchRequest(fetchReq) as! [NSManagedObject]
        } catch let err as NSError {
            
            print("Fetch failed: \(err.localizedDescription)")
        }
        players = fetchedR
        
        
        for(var i=0; i<players.count; i++) {
            if((players[i].valueForKey("inlineup") as! Bool)) {
                lineup.append(players[i].valueForKey("name") as! String)
                counter++
            } else {
                bench.append(players[i].valueForKey("name") as! String)
            }
        }
        
        
    }
    
    func done(sender: UIButton) {
        if(lineup.count == 5) {
            performSegueWithIdentifier("returnToScoring", sender: nil)
        } else {
            let alert = UIAlertView()
            alert.title = "Idiot:"
            alert.message = "You need five players to play basketball"
            alert.addButtonWithTitle("OK")
            alert.show()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(tableView == self.outTable) {
            return (bench.count)
        } else {
            return (lineup.count)
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if(tableView == self.inTable) {
            let cell = tableView.dequeueReusableCellWithIdentifier("OutCell", forIndexPath: indexPath) as! subOutCell
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            cell.nameLabel.text = lineup[indexPath.row]
            cell.subButton.tag = indexPath.row
            cell.subButton.addTarget(self, action: "subOut:", forControlEvents: UIControlEvents.TouchUpInside)
            return cell
        } else {
            let cell2 = tableView.dequeueReusableCellWithIdentifier("InCell", forIndexPath: indexPath) as! subInCell
            cell2.selectionStyle = UITableViewCellSelectionStyle.None
            cell2.nameLabel.text = bench[indexPath.row]
            cell2.subButton.tag = indexPath.row
            cell2.subButton.addTarget(self, action: "subIn:", forControlEvents: UIControlEvents.TouchUpInside)
            return cell2
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "returnToScoring") {
            let controller = segue.destinationViewController as! ScoringViewController
            controller.game = game
            controller.lineup = lineup
            controller.bench = bench
            controller.games = games
            controller.players = players
        }
    }
    
    func subIn(sender: UIButton) {
        let player = bench[sender.tag]
        bench.removeAtIndex(sender.tag)
        lineup.append(player)
        
        for(var i=0; i<players.count; i++) {
            if((players[i].valueForKey("name") as! String) == player) {
                
                print("!")
                
                //CoreData stuff
                let appDelegate =
                UIApplication.sharedApplication().delegate as! AppDelegate
                let managedContext = appDelegate.managedObjectContext
                let entity =  NSEntityDescription.entityForName("Player",
                    inManagedObjectContext:
                    managedContext)
                
                players[i].setValue(true, forKey: "inlineup")
                
                var error: NSError?
                do {
                    try managedContext.save()
                } catch var error1 as NSError {
                    error = error1
                    print("Could not save \(error), \(error?.userInfo)")
                }
                
                if(players[i].valueForKey("inlineup") as! Bool) {
                    print("!!")
                }
                
                break;
            }
        }
        self.outTable.reloadData()
        self.inTable.reloadData()
    }
    
    func subOut(sender:UIButton) {
        let player = lineup[sender.tag]
        lineup.removeAtIndex(sender.tag)
        bench.append(player)
        for(var i=0; i<players.count; i++) {
            if((players[i].valueForKey("name") as! String) == player) {
                
                //CoreData stuff
                let appDelegate =
                UIApplication.sharedApplication().delegate as! AppDelegate
                let managedContext = appDelegate.managedObjectContext
                let entity =  NSEntityDescription.entityForName("Player",
                    inManagedObjectContext:
                    managedContext)
                
                players[i].setValue(false, forKey: "inlineup")
                
                var error: NSError?
                do {
                    try managedContext.save()
                } catch var error1 as NSError {
                    error = error1
                    print("Could not save \(error), \(error?.userInfo)")
                }
                break;
            }
        }
        self.outTable.reloadData()
        self.inTable.reloadData()
    }
}


