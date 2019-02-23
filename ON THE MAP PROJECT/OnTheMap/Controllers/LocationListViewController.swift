//
//  LocationListViewController.swift
//  OnTheMap
//
//  Created by MAC on 20/05/1440 AH.
//  Copyright © 1440 MAC. All rights reserved.
//

import UIKit

class LocationListViewController: LocationViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override var list: [Location]? {
        didSet {
            filteredList = list?.filter({ $0.firstName != nil && $0.firstName?.isEmpty == false})
            tableView.reloadData()
        }
    }
    
    private var filteredList: [Location]?
    
    var senderLocation : Location!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "List"
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension LocationListViewController: UITableViewDelegate {
    
}

extension LocationListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "LocationListViewCell", for: indexPath) as? LocationListViewCell else {
            return UITableViewCell()
        }
        let item = filteredList?[indexPath.row]
        cell.textFieldTitle.text = (item?.firstName ?? "") + " " + (item?.lastName ?? "")
        cell.textFieldSubtitle.text = item?.mapString
        cell.stLocation = item
        return cell
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1 {
            let indexPath = tableView.indexPathForSelectedRow!
            let currentCell = tableView.cellForRow(at: indexPath)!as? LocationListViewCell
            senderLocation = currentCell!.stLocation
//            let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailView") as! StudentLocation
            
            let vc = storyboard?.instantiateViewController(withIdentifier: "StudentLocation") as? StudentLocation
           
            vc?.location = senderLocation
            navigationController?.pushViewController(vc!, animated: true)

        }
        
    }
    

}
