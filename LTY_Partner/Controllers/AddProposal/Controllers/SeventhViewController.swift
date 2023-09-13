//
//  SeventhViewController.swift
//  LTY_Partner
//
//  Created by Chawtech on 31/05/23.
//

import UIKit

class SeventhViewController: UIViewController {

    
    @IBOutlet weak var nextBtnStackView: UIStackView!
    @IBOutlet weak var doneStackView: UIStackView!
    @IBOutlet weak var partnerCommissionLbl: UILabel!
    @IBOutlet weak var partnerReserveLbl: UILabel!
    @IBOutlet weak var partnerGrossCommissionLbl: UILabel!
    @IBOutlet weak var AgentCommissionLbl: UILabel!
    @IBOutlet weak var agentReserveLbl: UILabel!
    @IBOutlet weak var agentGrossCommissionLbl: UILabel!
    @IBOutlet weak var partnerCommissionTxt: UITextField!
    @IBOutlet weak var partnerReserveTxt: UITextField!
    @IBOutlet weak var partnerGrossCommissionTxt: UITextField!
    @IBOutlet weak var agentCommissionTxt: UITextField!
    @IBOutlet weak var agentReserveTxt: UITextField!
    @IBOutlet weak var agentGrossCommissionTxt: UITextField!
    
    var isComingFrom = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if isComingFrom == "EditVC"{
            doneStackView.isHidden = false
            nextBtnStackView.isHidden = true
        }else {
            doneStackView.isHidden = true
            nextBtnStackView.isHidden = false
        }
        self.tabBarController?.tabBar.isHidden = true
    }
    
    @IBAction func onClickNext(_ sender: Any) {
//        let next = self.storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
//        self.navigationController?.pushViewController(next , animated: true)

    }
    
    //MARK:- done action btn
    @IBAction func doneActionBtn(_ sender: UIButton) {
        popVC(animated: true)
    }
    
    
    @IBAction func onClickCancel(_ sender: Any) {
        self.popVC(animated: true)
    }
    
    
   
}
