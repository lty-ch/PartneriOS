//
//  AgentListSearchVC.swift
//  LTY_Partner
//
//  Created by CTS on 21/06/23.
//

import UIKit

protocol AgentCallbackNameAndId : AnyObject {
    func setSelectedAgentData(name : String, id: String)
}

class AgentListSearchVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var table: UITableView!
    
    var customerAgentArr = [CustomerActiveAgentsList]()
    var filteredData = [CustomerActiveAgentsList]()
    var delegate : AgentCallbackNameAndId?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        filteredData = self.customerAgentArr
        searchBar.delegate = self
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AgentListCell", for: indexPath) as! AgentListCell
        
        let info = self.filteredData[indexPath.row]
        
        let fName = info.firstName?.capitalized  ?? ""
        let lName = info.lastName?.capitalized  ?? ""
        
        cell.cellLbl.text = fName + " " + lName
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let info = self.filteredData[indexPath.row]
        
        let fName = info.firstName?.capitalized  ?? ""
        let lName = info.lastName?.capitalized  ?? ""
        
        self.dismiss(animated: true) {
            self.delegate?.setSelectedAgentData(name: fName + " " + lName, id: info.partnerId ?? "")
        }
        
    }
    

}

extension AgentListSearchVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredData.removeAll()
        if searchText == "" {
            filteredData = self.customerAgentArr
        }
        for item in self.customerAgentArr {
            let fName = item.firstName?.capitalized   ?? ""
            if fName.localizedCaseInsensitiveContains(searchText) {
                filteredData.append(item)
            }
        }
        self.table.reloadData()
    }
}
