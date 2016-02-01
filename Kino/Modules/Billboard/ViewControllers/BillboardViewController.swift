//
//  BillboardViewController.swift
//  Kino
//
//  Created by Julian Alonso on 16/11/15.
//  Copyright © 2015 Julian. All rights reserved.
//

import UIKit
import CoreData

protocol BillboardEventHandler {
    
    func updateView()
    
}


class BillboardViewController: BaseViewController, NSFetchedResultsControllerDelegate, UITableViewDataSource {
    
    var eventHandler: BillboardEventHandler?
    
    lazy var fetchResultController: NSFetchedResultsController = {
        let fetchRequest = NSFetchRequest(entityName: "\(FilmMO.self)")
        let sortDescriptor = NSSortDescriptor(key: "releaseDate", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        return NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataManager.sharedInstance.readMOC!, sectionNameKeyPath: nil, cacheName: "billboardCache")
    }()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchResultController.delegate = self
        self.tableView.dataSource = self
        self.tableView.registerNib(UINib(nibName: "\(FilmTableViewCell.self)", bundle: nil), forCellReuseIdentifier: "\(FilmTableViewCell.self)")
        do {
            try self.fetchResultController.performFetch()
        } catch let error {
            DLog(error)
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.eventHandler?.updateView()
    }
    
    // MARK: - TabeViewDelegate
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: FilmTableViewCell = tableView.dequeueReusableCellWithIdentifier("\(FilmTableViewCell.self)")! as! FilmTableViewCell
        
        let film = self.fetchResultController.objectAtIndexPath(indexPath)
        
        cell.filmTitleLabel.text = film.title
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.fetchResultController.sections![0].numberOfObjects
    }
}
