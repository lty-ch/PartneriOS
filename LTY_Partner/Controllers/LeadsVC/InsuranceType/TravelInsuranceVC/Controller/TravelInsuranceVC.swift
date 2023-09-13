//
//  TravelInsuranceVC.swift
//  LTY_Partner
//
//  Created by Chawtech on 12/06/23.
//

import UIKit

class TravelInsuranceVC: UIViewController {

 
    @IBOutlet weak var lblFullName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblMobile: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblNationality: UILabel!
    @IBOutlet weak var lblState: UILabel!
    @IBOutlet weak var lblCity: UILabel!
    @IBOutlet weak var lblPostCode: UILabel!
    
    // member info

    @IBOutlet weak var lblRelation: UILabel!
    @IBOutlet weak var lblmemberName: UILabel!
    @IBOutlet weak var lblInsuranceType: UILabel!
    
    //Travel Insurance Offer
    
    @IBOutlet weak var lblAdults: UILabel!
    @IBOutlet weak var lblChildren: UILabel!
    @IBOutlet weak var lblAssistance: UILabel!
    @IBOutlet weak var lblDesireBlankets: UILabel!
    @IBOutlet weak var lblinjuredPerson: UILabel!

    @IBOutlet weak var customNavDrower: CustomNavigationBarForDrawer!
    @IBOutlet weak var customNavHeight: NSLayoutConstraint!
    
    var leadId = ""
    var leadInsuranceViewModel = LeadInsuranceViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()

        setDrowerHeight()
        leadInsuranceViewModel.delegate = self
        customNavDrower.titleLabel.text = "Travel Insurance Offer"
        customNavDrower.titleLabel.textAlignment = .center
        customNavDrower.leftSideMenuButtonItem.setImage(Asset.Assets.backArrow.image, for: .normal)
        customNavDrower.leftSideMenuButtonItem.addTarget(self, action: #selector(backActionBtn(_:)), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let param:[String:Any] = ["leadId":leadId]
        leadInsuranceViewModel.HeathInsuranceApiCall(param: param)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    //MARK:- backAction Btn
    
    @objc func backActionBtn(_ sender: UIButton) {
        self.popVC(animated: true)
        
    }
    
    //MARK:- set navigationDrower Height
    
    func setDrowerHeight() {
        if UIDevice.current.hasNotch {
            customNavHeight.constant = DroverHeight.haveNotch
        } else {
            customNavHeight.constant = DroverHeight.dontHaveNotch
            
        }
    }
 
    @IBAction func onClickSubmit(_ sender: Any) {
        let vc = UIStoryboard.init(name: "LeadStoryboard", bundle: Bundle.main).instantiateViewController(withIdentifier: "GeneralRequestVC") as? GeneralRequestVC
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    
    
    @IBAction func onClickCancle(_ sender: Any) {
    }
    
    
}


