//
//  ProposalDetailVC.swift
//  LTY_Partner
//
//  Created by ChawTech Solutions on 30/05/23.
//

import UIKit



class ProposalDetailVC: UIViewController {
    
    //MARK:- Title Outlets
    
    @IBOutlet weak var relationStackView: UIStackView!
    @IBOutlet weak var agentEmailStackView: UIStackView!
    @IBOutlet weak var offerIDLbl: UILabel!
    @IBOutlet weak var typePolcyLbl: UILabel!
    @IBOutlet weak var keyTagLbl: UILabel!
    @IBOutlet weak var insuranceTypeLbl: UILabel!
    @IBOutlet weak var endTitleDateLbl: UILabel!
    @IBOutlet weak var startTitleDateLbl: UILabel!
    
    @IBOutlet weak var relationTitle: UILabel!
    @IBOutlet weak var memberTitle: UILabel!
    @IBOutlet weak var agentNameTitle: UILabel!
    @IBOutlet weak var agentIDTitle: UILabel!
    @IBOutlet weak var agentEmailTitle: UILabel!
    @IBOutlet weak var agentMobileTitle: UILabel!
    
    
    @IBOutlet weak var periodicityTitleLbl: UILabel!
    @IBOutlet weak var catLbl: UILabel!
    @IBOutlet weak var premiumAmtLbl: UILabel!
    @IBOutlet weak var totalAmtLbl: UILabel!
    @IBOutlet weak var chooseAgentLbl: UILabel!
    @IBOutlet weak var insuranceProductLBL: UILabel!
    @IBOutlet weak var subCatLbl: UILabel!
    @IBOutlet weak var partnerGrossCommLbl: UILabel!
    @IBOutlet weak var PartnerReserveLbl: UILabel!
    @IBOutlet weak var AgentReservLbl: UILabel!
    
    @IBOutlet weak var chooseMembLbl: UILabel!
    @IBOutlet weak var polictVisbiLbl: UILabel!
    @IBOutlet weak var AttcahDocLbl: UILabel!
    @IBOutlet weak var partnerCommLbl: UILabel!
    @IBOutlet weak var abentCommLbl: UILabel!
    @IBOutlet weak var agentGrossLbl: UILabel!
    @IBOutlet weak var tiltleCustomerInfo: UILabel!
    @IBOutlet weak var lblDocumentInfoTitle: UILabel!
    @IBOutlet weak var lblTitlePolicyBasicinfo: UILabel!
    @IBOutlet weak var lblTitleProductBenifit: UILabel!
    @IBOutlet weak var lblTitleProducSpec: UILabel!
    @IBOutlet weak var lblTitleKeyFeatues: UILabel!
    @IBOutlet weak var lblProductPolicyName: UILabel!
    @IBOutlet weak var btnCancel: UIButton!
    //MarK:- outlets
    
    @IBOutlet weak var lblAgentEmail: UILabel!
    @IBOutlet weak var lblAgentID: UILabel!
    @IBOutlet weak var lblAgentName: UILabel!
    @IBOutlet weak var lblAgentMobile: UILabel!
    @IBOutlet weak var lblRelation: UILabel!
    @IBOutlet weak var lblMembarName: UILabel!
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var polictTablHeight: NSLayoutConstraint!
    @IBOutlet weak var policyTableView: UITableView!
    @IBOutlet weak var addProposalStackView: UIStackView!
    @IBOutlet weak var agentGrpBtn: UIButton!
    @IBOutlet weak var policyDocumnetBtn: UIButton!
    @IBOutlet weak var commissionBtn: UIButton!
    @IBOutlet weak var keyFeaturesBtn: UIButton!
    @IBOutlet weak var productBenifitBtn: UIButton!
    @IBOutlet weak var productPolicyBtn: UIButton!
    @IBOutlet weak var policyBtn: UIButton!
    //MARK:- policy outlet
    @IBOutlet weak var keytagStackHeight: NSLayoutConstraint!
    @IBOutlet weak var policyView: UIView!
    @IBOutlet weak var policyTypeLbl: UILabel!
    @IBOutlet weak var policynumberLbl: UILabel!
    @IBOutlet weak var startDateLbl: UILabel!
    @IBOutlet weak var endDateLbl: UILabel!
    @IBOutlet weak var periodicityLbl: UILabel!
    @IBOutlet weak var premiumAmountLbl: UILabel!
    
    //MARK:-  produsct policy outlet
    @IBOutlet weak var productPolicyView: UIView!
    
   
    @IBOutlet weak var catLcbl: UILabel!
    @IBOutlet weak var subcatLcbl: UILabel!
    @IBOutlet weak var insuranceProductLcbl: UILabel!
    @IBOutlet weak var agentbl: UILabel!
    @IBOutlet weak var totalAmountLcbl: UILabel!
    
    //MARK:-  product benifits outlet
    
    @IBOutlet weak var productBenifitView: UIView!
  
    @IBOutlet weak var benefitsLbl: UILabel!
    
    @IBOutlet weak var featuresLbl: UILabel!
    //MARK:-  key features outlet
    
    @IBOutlet weak var keyFeaturesView: UIView!
    
    @IBOutlet weak var lblPartnerCommission: UILabel!
    //MARK:-  produsct specification outlet
    
    @IBOutlet weak var productSpeciView: UIView!
    
    @IBOutlet weak var lblAgentNetCommission: UILabel!
    @IBOutlet weak var lblAgentCommission: UILabel!
    @IBOutlet weak var lblPartenerReserve: UILabel!
    @IBOutlet weak var lblAgentGross: UILabel!
    @IBOutlet weak var lblPartnerGross: UILabel!
    
    //MARK:-  Document Info outlet
    
    @IBOutlet weak var documentInfoView: UIView!
    
    @IBOutlet weak var lblInsuranceType: UILabel!
    
    //MARK:-  Customer Info outlet
    @IBOutlet weak var customerInfoVIew: UIView!
    @IBOutlet weak var lblMemberShip: UILabel!
    @IBOutlet weak var lblCustomerPolicy: UILabel!
    
    @IBOutlet weak var customerStackHeight: NSLayoutConstraint!
    //MARK:-  nav drover outlets
    
    @IBOutlet weak var customNavDrower: CustomNavigationBarForDrawer!
    @IBOutlet weak var customNavHeight: NSLayoutConstraint!
    
    @IBOutlet weak var policyDocLbl: UILabel!
    //MARK:- Collection outlet
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionHeight: NSLayoutConstraint!
    @IBOutlet weak var chooseMemberCollHeight: NSLayoutConstraint!
    @IBOutlet weak var chooseMemberCollectionView: UICollectionView!
    
    @IBOutlet weak var collectionViewFlowLayout: UICollectionViewFlowLayout!{
        didSet {
            collectionViewFlowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
    
    @IBOutlet weak var chooseMemberCollLayout: UICollectionViewFlowLayout!{
        didSet {
            chooseMemberCollLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
    
    var keyTagsArr = [String]()
    var membersArr = NSMutableArray()
    var addProposalVM = AddProposalViewModel()
    var proposaldetailVM = ProposalDetailViewModel()
    var commissionData : commissionDataClass?
    var proposalId = ""
    var userId = ""
    var offerId = ""
    var catDic = NSMutableDictionary()
    var fromWhichVC = ""
    
    var productArr = NSMutableArray()
    var productDic = NSMutableDictionary()
    var policyDocsArr = NSMutableArray()
    var shouldEditProposal = false
    var leadId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDrowerHeight()
        setLocalization()
        setUpCollectionView()
        policyTableView.estimatedRowHeight = 60
        self.policyTableView.rowHeight = UITableView.automaticDimension
        customNavDrower.titleLabel.text = "Review Proposal".localized()
        customNavDrower.titleLabel.textAlignment = .center
        customNavDrower.leftSideMenuButtonItem.setImage(Asset.Assets.backArrow.image, for: .normal)
        customNavDrower.leftSideMenuButtonItem.addTarget(self, action: #selector(backActionBtn(_:)), for: .touchUpInside)
        addProposalVM.addProposalDelegate = self
        addProposalVM.editProposalDelegate = self
//        proposaldetailVM.delegate = self
        self.policyTableView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)

        
        if self.proposalId == ""  {
            
            self.setData()
            self.hideEditBtns(isHidden: false)
            self.relationStackView.isHidden = true
            self.agentEmailStackView.isHidden = true
            
        } else {
            shouldEditMembers = false
            if self.fromWhichVC == "ViewVC" || self.fromWhichVC == "LeadProposalVC" {
                shouldEditProposal = false
                self.hideEditBtns(isHidden: true)
                self.relationStackView.isHidden = false
                self.agentEmailStackView.isHidden = false
                let param: [String:Any] = ["proposalId": self.proposalId]
                self.viewProposalApi(param: param)
            } else {
                shouldEditProposal = true
                addProposalDic.setValue(self.proposalId, forKey: "proposalId")
                self.hideEditBtns(isHidden: false)
                self.relationStackView.isHidden = false
                self.agentEmailStackView.isHidden = false
                let param: [String:Any] = ["proposalId": self.proposalId]
                self.viewProposalApi(param: param)
            }
        }
//        else if self.fromWhichVC == "ContractVC"{
//            shouldEditProposal = true
//            let param: [String:Any] = ["offerId": self.offerId, "userId": self.userId]
//            self.viewProposalByOfferIdApi(param: param)
//        }
    }
    
    func setLocalization() {
        
        self.relationTitle.text = "Relation".localized()
        self.memberTitle.text = "Member Name".localized()
        self.agentNameTitle.text = "Agent Name".localized()
        self.agentIDTitle.text = "Member / Relation".localized()
        self.agentEmailTitle.text = "Agent Email".localized()
        self.agentMobileTitle.text = "Agent Mobile".localized()
        self.offerIDLbl.text = "Offer Number".localized()
        self.typePolcyLbl.text = "Type of Policy".localized()
        self.keyTagLbl.text = "Key Tag".localized()
        self.insuranceTypeLbl.text = "Insurance Type".localized()
        self.endTitleDateLbl.text = "End Date".localized()
        self.startTitleDateLbl.text = "Start Date".localized()
 
        self.periodicityTitleLbl.text = "Periodicity".localized()
        self.catLbl.text = "Insurance Company".localized()
        self.premiumAmtLbl.text = "Premium Amount".localized()
        self.totalAmtLbl.text = "Total Amount".localized()
        self.chooseAgentLbl.text = "Choose Agent".localized()
        self.insuranceProductLBL.text = "Insurance coverage".localized()
        self.subCatLbl.text = "Insurance Product".localized()
        
        self.partnerGrossCommLbl.text = "Partner Gross Commission ".localized()
        self.PartnerReserveLbl.text = "Partner reserve ".localized()
        self.AgentReservLbl.text = "Agent Reserve ".localized()
     
        self.chooseMembLbl.text = "Customers".localized()
        self.polictVisbiLbl.text = "Policy visibility".localized()
        self.AttcahDocLbl.text = "Attached Documents".localized()
        self.partnerCommLbl.text = "Partner commission".localized()
        self.abentCommLbl.text = "Agent commission".localized()
        self.agentGrossLbl.text = "Agent Gross Commission ".localized()
        
        self.tiltleCustomerInfo.text = "Agent, Group & Customer Information".localized()
        self.lblDocumentInfoTitle.text = "Policy Document’s & Information".localized()
        self.lblTitlePolicyBasicinfo.text = "Policy Basic Information".localized()
        self.lblTitleProductBenifit.text = "Product Benefits".localized()
        self.lblTitleProducSpec.text = "Commission".localized()
        self.lblTitleKeyFeatues.text = "Key Features".localized()
        self.lblProductPolicyName.text = "Product, Policy and Product Specifications".localized()
        self.sendBtn.setTitle("Send".localized(), for: .normal)
        self.btnCancel.setTitle("Cancel".localized(), for: .normal)
    }
    
    //MARK:- hide btns
    func hideEditBtns(isHidden:Bool) {
        agentGrpBtn.isHidden = isHidden
        policyBtn.isHidden = isHidden
        keyFeaturesBtn.isHidden = isHidden
        commissionBtn.isHidden = isHidden
        productPolicyBtn.isHidden = isHidden
        productBenifitBtn.isHidden = isHidden
        policyDocumnetBtn.isHidden = isHidden
        addProposalStackView.isHidden = isHidden

    }
    
    //MARK:- SetUp CollectionView
    
    func setUpCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        chooseMemberCollectionView.delegate = self
        chooseMemberCollectionView.dataSource = self
        
        policyTableView.delegate = self
        policyTableView.dataSource = self
        self.policyTableView.reloadData()
        
        collectionView.register(UINib(nibName: "ProposelDetailCollectionCell", bundle: Bundle.main), forCellWithReuseIdentifier: "ProposelDetailCollectionCell")
        
        chooseMemberCollectionView.register(UINib(nibName: "ChooseMemberCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "ChooseMemberCollectionViewCell")
        
        policyTableView.register(UINib(nibName: "ProposalDetailPolicyTableCell", bundle: Bundle.main), forCellReuseIdentifier: "ProposalDetailPolicyTableCell")
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        polictTablHeight.constant = policyTableView.contentSize.height
       
        self.customerStackHeight.constant = self.chooseMemberCollectionView.collectionViewLayout.collectionViewContentSize.height
        
        self.chooseMemberCollHeight.constant = self.chooseMemberCollectionView.collectionViewLayout.collectionViewContentSize.height
        
        self.keytagStackHeight.constant = self.collectionView.collectionViewLayout.collectionViewContentSize.height + 40
        self.collectionHeight.constant = self.collectionView.collectionViewLayout.collectionViewContentSize.height
        
        chooseMemberCollectionView.reloadData()
        collectionView.reloadData()
        setUpCollectionView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.chooseMemberCollectionView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        
        self.collectionView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        tabBarController?.tabBar.isHidden = true
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        self.collectionView.removeObserver(self, forKeyPath: "contentSize")
        self.chooseMemberCollectionView.removeObserver(self, forKeyPath: "contentSize")
        
        tabBarController?.tabBar.isHidden = false

    }
    
    func setData(){
     
        
        lblInsuranceType.text = addProposalDic["insuranceType"] as? String
        policyTypeLbl.text = addProposalDic["policyType"] as? String
        
        
        var startDate =  addProposalDic["startDate"] as? String
        startDate = startDate?.components(separatedBy: "T")[0]
        startDateLbl.text = returnDOB(date: startDate ?? "")
        
        var endDate = addProposalDic["endDate"] as? String
        endDate = endDate?.components(separatedBy: "T")[0]
        endDateLbl.text = returnDOB(date: endDate ?? "")
        
        //startDateLbl.text = addProposalDic["startDate"] as? String
       // endDateLbl.text = addProposalDic["endDate"] as? String
        
        
        policynumberLbl.text = addProposalDic["offerId"] as? String
        //key tag
        let catDetails = addProposalDic["categoryDetails"] as! NSMutableDictionary
        
        
        let language =  kUserDefaults.value(forKey: APPLE_LANGUAGE_KEY)
        let result = language as! NSArray
        
        if result[0] as! String == "fr" {
            catLcbl.text = catDetails["categoryNameInFrench"] as? String
            subcatLcbl.text = catDetails["subCategoryNameInFrench"] as? String
        }else{
            catLcbl.text = catDetails["categoryName"] as? String
            subcatLcbl.text = catDetails["subCategoryName"] as? String
        }

 
        
        let productDetails = addProposalDic["productDetails"] as! NSMutableDictionary
        let prodList = productDetails["productList"] as! NSMutableArray
        var arr = NSMutableArray()
        self.insuranceProductLcbl.text = ""
//        let language =  kUserDefaults.value(forKey: APPLE_LANGUAGE_KEY)
//        let result = language as! NSArray
//        
    
        for items in prodList {
            let item = items as! NSMutableDictionary
            if result[0] as! String == "fr" {
                arr.add(item["productNameInFrench"] ?? "")
                self.insuranceProductLcbl.text! += "\(item["productNameInFrench"] ?? "") - \(item["amount"] ?? 0)\n"
            }else{
                arr.add(item["productName"] ?? "")
                self.insuranceProductLcbl.text! += "\(item["productName"] ?? "") - \(item["amount"] ?? 0)\n"
            }
        }
       // self.insuranceProductLcbl.text = arr.componentsJoined(by: ",")
        
//        insuranceProductLcbl.text = addProposalDic["policyType"] as? String
//        agentbl.text = addProposalDic["agentId"] as? String
        agentbl.text = addProposalDic["agentName"] as? String
        
        
        lblAgentName.text = addProposalDic["agentName"] as? String
        
        if lblAgentName.text?.isEmpty == true{
            lblAgentName.text = "unassigned".localized()
        }
            
    
        periodicityLbl.text = addProposalDic["periodicity"] as? String
        premiumAmountLbl.text = addProposalDic["premiumAmount"] as? String
        totalAmountLcbl.text = addProposalDic["totalAmount"] as? String
        
        let productBenefits = addProposalDic["productBenefits"] as? String
        benefitsLbl.text =  productBenefits?.html2String
        
        let keyFeatures = addProposalDic["keyFeatures"] as? String

        featuresLbl.text = keyFeatures?.html2String

        
        
      
        lblCustomerPolicy.text = addProposalDic["policyVisibility"] as? String
        
//        let membersDetails = addProposalDic["memberId"] as! NSMutableArray
//        lblMemberShip.text = membersDetails.componentsJoined(by: ",")
        let membersDetails = addProposalDic["memberNames"] as! NSMutableArray
        lblMemberShip.text = membersDetails.componentsJoined(by: ",")
        lblAgentID.text = lblMemberShip.text
        self.keyTagsArr = addProposalDic["keyTags"] as! [String]
        self.membersArr = addProposalDic["memberId"] as! NSMutableArray
        
       // lblRelation.text =
        lblMembarName.text = membersDetails.componentsJoined(by: ",")
        
        let policyDetails = addProposalDic["policyDocs"] as! NSMutableArray
        self.policyDocsArr = policyDetails
//        policyDocLbl.text = policyDetails.componentsJoined(by: ",")
        
       // let partnerId =  kUserDefaults.string(forKey: "partnerID") ?? ""
        let catId = catDetails["categoryId"] as! String
        let subCatId = catDetails["subCategoryId"] as! String
        let agentId = addProposalDic["agentId"] as! String
        
        self.catDic.setValue(catDetails["categoryId"] ?? "", forKey: "categoryId")
        self.catDic.setValue(catDetails["categoryName"] ?? "", forKey: "categoryName")
        self.catDic.setValue(catDetails["categoryNameInFrench"] ?? "", forKey: "categoryNameInFrench")
        self.catDic.setValue(catDetails["subCategoryId"] ?? "", forKey: "subCategoryId")
        self.catDic.setValue(catDetails["subCategoryName"] ?? "", forKey: "subCategoryName")
        self.catDic.setValue(catDetails["subCategoryNameInFrench"] ?? "", forKey: "subCategoryNameInFrench")
        
        let userType = kUserDefaults.value(forKey: AppKeys.userType)
        let sourceId = kUserDefaults.value(forKey: AppKeys.sourceId)
        let PartnerId = kUserDefaults.value(forKey: AppKeys.partnerID)
        var param :[String:Any]
        if userType as! String == "AGENT"{
            param  = ["agentId":PartnerId, "partnerId":sourceId, "categoryId":catId, "subCategoryId":subCatId, "productList":prodList]
        }else{
            param  = ["agentId":agentId, "partnerId":PartnerId, "categoryId":catId, "subCategoryId":subCatId, "productList":prodList]
        }
        print(param)
        setUpCollectionView()
        proposaldetailVM.delegate = self
        proposaldetailVM.getCommissionApi(param: param)
        
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if collectionView == chooseMemberCollectionView {
            
            if keyPath == "contentSize"
            {
                if let newValue = change?[.newKey]
                {
                    let newsize = newValue as! CGSize
                    self.chooseMemberCollHeight.constant = newsize.height
                }
            }
            
        } else if collectionView == self.collectionView {
            if keyPath == "contentSize"
            {
                if let newValue = change?[.newKey]
                {
                    let newsize = newValue as! CGSize
                    self.collectionHeight.constant = newsize.height
                }
            }
        } else {
            if(keyPath == "contentSize"){
                if let newvalue = change?[.newKey]
                {
                    let newsize = newvalue as! CGSize
                    polictTablHeight.constant = newsize.height
                }
            }
        }
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
    
    //MARK:- Edit button Actions
    
    @IBAction func editActionBtn(_ sender: UIButton) {
        
        switch sender.tag {
        case 101:
            let vc  = SecondViewController.instantiate(fromAppStoryboard: .proposalStoryboard)
            vc.isComingFrom = self.fromWhichVC
            vc.delegate = self
            vc.updateDelegate = self
            pushToVC(vc, animated: true)
        case 102:
            let vc  = ThirdViewController.instantiate(fromAppStoryboard: .proposalStoryboard)
            vc.isComingFrom = self.fromWhichVC
            vc.agentId = addProposalDic.value(forKey: "agentId") as! String
            vc.catId = self.catDic.value(forKey: "categoryId") as! String
            vc.subcatId = self.catDic.value(forKey: "subCategoryId") as! String
            //shouldEditMembers = false
            vc.delegate = self
            vc.updateDelegate = self
            pushToVC(vc, animated: true)

        case 103:
            let vc  = FourthViewController.instantiate(fromAppStoryboard: .proposalStoryboard)
            vc.isComingFrom = self.fromWhichVC
            vc.delegate = self
            vc.updateDelegate = self
            pushToVC(vc, animated: true)

        case 104:
            let vc  = FifthViewController.instantiate(fromAppStoryboard: .proposalStoryboard)
            vc.isComingFrom = self.fromWhichVC
            vc.delegate = self
            vc.updateDelegate = self
            pushToVC(vc, animated: true)

        case 105:
            print("")
//            let vc  = FirstViewController.instantiate(fromAppStoryboard: .proposalStoryboard)
//            vc.isComingFrom = self.fromWhichVC
//            vc.delegate = self
//            vc.updateDelegate = self
//            pushToVC(vc, animated: true)

        case 106:
            let vc  = SixthViewController.instantiate(fromAppStoryboard: .proposalStoryboard)
            vc.isComingFrom = self.fromWhichVC
            vc.updateDelegate = self
            vc.delegate = self
            pushToVC(vc, animated: true)

        case 107:
            let vc  = FirstViewController.instantiate(fromAppStoryboard: .proposalStoryboard)
            vc.isComingFrom = self.fromWhichVC
           // shouldEditMembers = false
            vc.delegate = self
            vc.updateDelegate = self
            pushToVC(vc, animated: true)
            
        default:
            print("")
        }
    }
    
    @IBAction func addActionBtn(_ sender: UIButton) {
        print(addProposalDic as! [String : Any])
        let memberIdArr = addProposalDic.value(forKey: "memberId") as! NSMutableArray
        if memberIdArr.count == 0 {
            self.showOkAlertWithHandler("Since you have changed Agent, Please update the customer also.") {
                let vc  = FirstViewController.instantiate(fromAppStoryboard: .proposalStoryboard)
                vc.isComingFrom = self.fromWhichVC
                vc.delegate = self
                vc.updateDelegate = self
                self.pushToVC(vc, animated: true)
            }
            return
        }
        if shouldEditProposal {
            // Edit proposal
            addProposalVM.editProposalAPI(param: addProposalDic as! [String : Any])
        } else {
            // Add Proposal
            addProposalVM.addProposalAPI(param: addProposalDic as! [String : Any])
        }
        
    }
    
    @IBAction func cancelActionBtn(_ sender: UIButton) {
        popVC(animated: true)
    }
    
    func setCommissionData() {
//        let partnerGross = self.commissionData["partnerGrossCommission"] ?? 0.0
        lblPartnerGross.text = "\(self.commissionData?.partnerGrossCommission ?? 0.0)"
        lblAgentGross.text = "\(self.commissionData?.agentGrossCommission ?? 0.0)"
        lblPartenerReserve.text = "\(self.commissionData?.partnerReserve ?? 0.0)"
        lblAgentNetCommission.text = "\(self.commissionData?.agentReserve ?? 0.0)"
        lblPartnerCommission.text = "\(self.commissionData?.partnerCommission ?? 0.0)"
        lblAgentCommission.text = "\(self.commissionData?.agentCommission ?? 0.0)"
     //   agentbl.text = self.commissionData.p
        
        let commissionDic = NSMutableDictionary()
        
//        commissionDic.setValue(self.commissionData?.partnerGrossCommission ?? 0.0, forKey: "partnerGrossCommission")
//        commissionDic.setValue(self.commissionData?.partnerReserve ?? 0.0, forKey: "partnerReserve")
//        commissionDic.setValue(self.commissionData?.partnerCommission ?? 0.0, forKey: "partnerCommission")
//        commissionDic.setValue(self.commissionData?.agentGrossCommission ?? 0.0, forKey: "agentGrossCommission")
//        commissionDic.setValue(self.commissionData?.agentReserve ?? 0.0, forKey: "agentReserve")
//        commissionDic.setValue(self.commissionData?.agentCommission ?? 0.0, forKey: "agentCommission")
        
        commissionDic.setValue(lblPartnerGross.text, forKey: "partnerGrossCommission")
        commissionDic.setValue(lblPartenerReserve.text, forKey: "partnerReserve")
        commissionDic.setValue(lblPartnerCommission.text, forKey: "partnerCommission")
        commissionDic.setValue(lblAgentGross.text, forKey: "agentGrossCommission")
        commissionDic.setValue(lblAgentNetCommission.text, forKey: "agentReserve")
        commissionDic.setValue(lblAgentCommission.text, forKey: "agentCommission")
        
        print(commissionDic)
        
        addProposalDic.setValue(commissionDic, forKey: "commissionDetails")
        if UserDefaults.standard.value(forKey: "fromLead") as! String == "yes"{
          //  addProposalDic.setValue(self.leadId, forKey: "leadId")
            addProposalDic.setValue("SAVE", forKey: "proposalAction")
            addProposalDic.setValue("PERSONALIZED", forKey: "offerType")

            sendBtn.setTitle("Save", for: .normal)
        }else{
            addProposalDic.setValue("SEND", forKey: "proposalAction")
            addProposalDic.setValue("GENERALIZED", forKey: "offerType")
            sendBtn.setTitle("Send", for: .normal)
        }
  
    }
    
    func viewProposalApi (param:[String:Any]) {
            
            SwiftLoader.show(animated: true)

            Services.shareInstance.postRequestApi(url: LTY_BASE_URL.BASE_URL_INSURANCE + LTY_END_POINT_URL.viewProposal, method: "POST", passToken: true, expecting:ViewProposalModel.self, dataDict: param) { response
                
                in

                print(response)
                switch response {
                
                case .success(let result):
                    SwiftLoader.hide()

                   
                    
                    DispatchQueue.main.async {
                        self.createDicForSettingData(data: result.data!)

                    }

                case .failure(let error):
                    SwiftLoader.hide()
                    DispatchQueue.main.async {
                        
                        
                        self.ShowAlert(message: error.localizedDescription)
                        
                    }
                }

            
            }

        }
    
    func viewProposalByOfferIdApi (param:[String:Any]) {
            
            SwiftLoader.show(animated: true)

            Services.shareInstance.postRequestApi(url: LTY_BASE_URL.BASE_URL_INSURANCE + LTY_END_POINT_URL.viewProposalByOfferID, method: "POST", passToken: true, expecting:ViewProposalModel.self, dataDict: param) { response
                
                in

                print(response)
                switch response {
                
                case .success(let result):
                    SwiftLoader.hide()

                   
                    
                    DispatchQueue.main.async {
                        self.createDicForSettingData(data: result.data!)

                    }

                case .failure(let error):
                    SwiftLoader.hide()
                    DispatchQueue.main.async {
                        
                        
                        self.ShowAlert(message: error.localizedDescription)
                        
                    }
                }

            
            }

        }
    
    func createDicForSettingData(data: ViewProposalData) {
        
        let partnerId =  kUserDefaults.string(forKey: "partnerID") ?? ""
        
        let userType = kUserDefaults.value(forKey: AppKeys.userType)
        let sourceId = kUserDefaults.value(forKey: AppKeys.sourceId)
        
        if userType as! String == "AGENT"{
            addProposalDic.setValue(sourceId, forKey: "partnerId")
        }else{
            addProposalDic.setValue(partnerId, forKey: "partnerId")
        }
        
        
        addProposalDic.setValue(data.insuranceType, forKey: "insuranceType")
        let offerId = data.policyDetails?.offerId ?? ""
//        let newOfferId = offerId + "_1"
        addProposalDic.setValue(offerId, forKey: "offerId")
        addProposalDic.setValue(data.policyDetails?.policyType, forKey: "policyType")
        
        addProposalDic.setValue(data.policyDetails?.startDate, forKey: "startDate")
        addProposalDic.setValue(data.policyDetails?.endDate, forKey: "endDate")
        //        addProposalDic.setValue("2023-06-08T09:07:10.182Z", forKey: "startDate")
        //        addProposalDic.setValue("2023-06-08T09:07:10.182Z", forKey: "endDate")
        
        let keyTags = data.policyDetails?.keyTags ?? []
        
        for item in keyTags {
            self.keyTagsArr.append(item)
        }
        
        addProposalDic.setValue(self.keyTagsArr, forKey: "keyTags")
        //print(self.keyTagsArr)
        addProposalDic.setValue(data.leadDetails?.leadId ?? "", forKey: "leadId")
        
        var memberNameArr = NSMutableArray()
        let fname = data.memberDetails?.firstName?.capitalized   ?? ""
        let lname = data.memberDetails?.lastName?.capitalized   ?? ""
        memberNameArr.add(fname + " " + lname)
        addProposalDic.setValue(memberNameArr, forKey: "memberNames")
        
        self.catDic.setValue(data.policyDetails?.categoryDetails?.categoryId ?? "", forKey: "categoryId")
        self.catDic.setValue(data.policyDetails?.categoryDetails?.categoryName, forKey: "categoryName")
        self.catDic.setValue(data.policyDetails?.categoryDetails?.categoryNameInFrench, forKey: "categoryNameInFrench")
        self.catDic.setValue(data.policyDetails?.categoryDetails?.subCategoryId, forKey: "subCategoryId")
        self.catDic.setValue(data.policyDetails?.categoryDetails?.subCategoryName, forKey: "subCategoryName")
        self.catDic.setValue(data.policyDetails?.categoryDetails?.subCategoryNameInFrench, forKey: "subCategoryNameInFrench")
        addProposalDic.setValue(self.catDic, forKey: "categoryDetails")
        addProposalDic.setValue(data.policyDetails?.periodicity, forKey: "periodicity")
        addProposalDic.setValue("\(data.policyDetails?.premiumAmount ?? 0)", forKey: "premiumAmount")
        addProposalDic.setValue("\(data.policyDetails?.totalAmount ?? 0)", forKey: "totalAmount")
        //        addProposalDic.setValue(data.policyDetails?.categoryDetails, forKey: "categoryDetails")
        addProposalDic.setValue(data.agentDetails?.agentId ?? "", forKey: "agentId")
        addProposalDic.setValue(data.agentDetails?.agentName ?? "", forKey: "agentName")
        
        addProposalDic.setValue(data.policyDetails?.productBenefits, forKey: "productBenefits")
        
        addProposalDic.setValue(data.policyDetails?.keyFeatures, forKey: "keyFeatures")
        if UserDefaults.standard.value(forKey: "fromLead") as! String == "yes"{
            addProposalDic.setValue("SAVE", forKey: "proposalAction")
            addProposalDic.setValue("PERSONALIZED", forKey: "offerType")

            sendBtn.setTitle("Save", for: .normal)
        }else{
            addProposalDic.setValue("SEND", forKey: "proposalAction")
            addProposalDic.setValue("GENERALIZED", forKey: "offerType")

            sendBtn.setTitle("Send", for: .normal)
        }
        
        
        let commissionDic = NSMutableDictionary()
        
        commissionDic.setValue(data.commissionDetails?.partnerGrossCommission ?? 0, forKey: "partnerGrossCommission")
        commissionDic.setValue(data.commissionDetails?.partnerReserve ?? 0, forKey: "partnerReserve")
        commissionDic.setValue(data.commissionDetails?.partnerCommission ?? 0, forKey: "partnerCommission")
        commissionDic.setValue(data.commissionDetails?.agentGrossCommission ?? 0, forKey: "agentGrossCommission")
        commissionDic.setValue(data.commissionDetails?.agentReserve ?? 0, forKey: "agentReserve")
        commissionDic.setValue(data.commissionDetails?.agentCommission ?? 0, forKey: "agentCommission")
        
        
        addProposalDic.setValue(commissionDic, forKey: "commissionDetails")
        
        addProposalDic.setValue(data.policyDetails?.policyVisibility, forKey: "policyVisibility")
        
        var memberArr = NSMutableArray()
        memberArr.add(data.memberDetails?.memberId ?? "")
        addProposalDic.setValue(memberArr, forKey: "memberId")
        
        var policyDocsArr = NSMutableArray()
        let fds = data.policyDetails?.policyDocs ?? []
        for item in fds {
            policyDocsArr.add(item)
        }

        addProposalDic.setValue(policyDocsArr, forKey: "policyDocs")

        let products = data.policyDetails?.productDetails?.productList
        for item in products! {
            let it = item as! ViewProposalProductList
            var dic = NSMutableDictionary()
            dic.setValue(it.productName, forKey: "productName")
            dic.setValue(it.productNameInFrench, forKey: "productNameInFrench")
            dic.setValue(it.productId, forKey: "productId")
            dic.setValue(it.amount, forKey: "amount")
            self.productArr.add(dic)
        }
        
        self.productDic.setValue(self.productArr, forKey: "productList")
        addProposalDic.setValue(self.productDic, forKey: "productDetails")
        
        let memberName = data.leadDetails?.memberName ?? ""
        let memberRelation = data.leadDetails?.relation ?? ""
        
        lblRelation.text = data.leadDetails?.relation ?? ""
        lblAgentID.text =  memberName + " / " + memberRelation  //data.leadDetails?.agentId ?? ""
        lblAgentName.text = data.agentDetails?.agentName ?? "unassigned".localized()
   
            
        lblAgentEmail.text = data.agentDetails?.email ?? ""
        let fName = data.memberDetails?.firstName?.capitalized   ?? ""
        let lName = data.memberDetails?.lastName?.capitalized   ?? ""
        lblMembarName.text = fName + " " + lName
        let countryCode = data.agentDetails?.countryCode ?? ""
        
        lblAgentMobile.text = "\(countryCode) \(data.agentDetails?.mobile ?? "")"
       // lblAgentMobile.text = data.agentDetails?.mobile ?? ""
        
        self.setDataFromAPI(data: data)
        
    }
    
    func setDataFromAPI(data: ViewProposalData) {
        
        
        
        lblInsuranceType.text = data.insuranceType ?? ""
        policyTypeLbl.text = data.policyDetails?.policyType ?? ""
        
        var startDate = "\(data.policyDetails?.startDate ?? "")"
        startDate = startDate.components(separatedBy: "T")[0]
        startDateLbl.text = returnDOB(date: startDate)
        
        var endDate = "\(data.policyDetails?.endDate ?? "")"
        endDate = endDate.components(separatedBy: "T")[0]
        endDateLbl.text = returnDOB(date: endDate)

        policynumberLbl.text = data.policyDetails?.offerId ?? ""
        //key tag
//        let catDetails = addProposalDic["categoryDetails"] as! NSMutableDictionary
        let language =  kUserDefaults.value(forKey: APPLE_LANGUAGE_KEY)
        let result = language as! NSArray
        
        if result[0] as! String == "fr" {
            catLcbl.text = data.policyDetails?.categoryDetails?.categoryNameInFrench ?? ""
            subcatLcbl.text = data.policyDetails?.categoryDetails?.subCategoryNameInFrench ?? ""
        }else{
            catLcbl.text = data.policyDetails?.categoryDetails?.categoryName ?? ""
            subcatLcbl.text = data.policyDetails?.categoryDetails?.subCategoryName ?? ""
        }
//        let productDetails = addProposalDic["productDetails"] as! NSMutableDictionary
        let prodList = data.policyDetails?.productDetails?.productList ?? []
        var arr = NSMutableArray()
        self.insuranceProductLcbl.text = ""
        for items in prodList {
//            arr.add(items.productName ?? "")
            if result[0] as! String == "fr" {
                self.insuranceProductLcbl.text! += "\(items.productNameInFrench ?? "") - \(items.amount ?? 0)\n"
            }else{
                self.insuranceProductLcbl.text! += "\(items.productName ?? "") - \(items.amount ?? 0)\n"
            }
          
        }
       // self.insuranceProductLcbl.text = arr.componentsJoined(by: ",")
        
//        insuranceProductLcbl.text = addProposalDic["policyType"] as? String
        agentbl.text = data.agentDetails?.agentName ?? "Unassigned".localized()
        periodicityLbl.text = data.policyDetails?.periodicity ?? ""
        premiumAmountLbl.text = "\(data.policyDetails?.premiumAmount ?? 0)"
        totalAmountLcbl.text = "\(data.policyDetails?.totalAmount ?? 0)"
        
//        benefitsLbl.text = data.policyDetails?.productBenefits ?? ""
//        featuresLbl.text = data.policyDetails?.keyFeatures ?? ""
        
        let productBenefits = data.policyDetails?.productBenefits ?? ""
        benefitsLbl.text =  productBenefits.html2String
        
        let keyFeatures = data.policyDetails?.keyFeatures ?? ""

        featuresLbl.text = keyFeatures.html2String

        
//        let commissionDetails = addProposalDic["commissionDetails"] as! NSMutableDictionary
        lblPartnerGross.text = "\(String(describing: data.commissionDetails?.partnerGrossCommission ?? 0))"
        lblPartenerReserve.text = "\(String(describing: data.commissionDetails?.partnerReserve ?? 0))"
        lblPartnerCommission.text = "\(String(describing: data.commissionDetails?.partnerCommission ?? 0))"
        lblAgentGross.text = "\(String(describing: data.commissionDetails?.agentGrossCommission ?? 0))"
        lblAgentNetCommission.text = "\(String(describing: data.commissionDetails?.agentReserve ?? 0))"
        lblAgentCommission.text = "\(String(describing: data.commissionDetails?.agentCommission ?? 0))"
      
        lblCustomerPolicy.text = data.policyDetails?.policyVisibility ?? ""
        
//        let membersDetails = addProposalDic["memberId"] as! NSMutableArray
//        lblMemberShip.text = membersDetails.componentsJoined(by: ",")
        let keyTags = data.policyDetails?.keyTags ?? []
        self.keyTagsArr.removeAll()
        for item in keyTags {
            self.keyTagsArr.append(item)
        }
        
        let fname = data.memberDetails?.firstName?.capitalized   ?? ""
        let lname = data.memberDetails?.lastName?.capitalized   ?? ""
        lblMemberShip.text = fname + " " + lname
        
        let policyDetails = addProposalDic["policyDocs"] as! NSMutableArray
        self.policyDocsArr = policyDetails
        
        self.setUpCollectionView()
        
//        self.keyTagsArr = addProposalDic["keyTags"] as! [String]
//        self.membersArr = addProposalDic["memberId"] as! NSMutableArray
//        let policyDetails = addProposalDic["policyDocs"] as! NSMutableArray
//        if policyDetails != nil {
//            policyDocLbl.text = policyDetails.componentsJoined(by: ",")
//        }
        
        
        let partnerId =  kUserDefaults.string(forKey: "partnerID") ?? ""
        let catId = data.policyDetails?.categoryDetails?.categoryId ?? ""
        let subCatId = data.policyDetails?.categoryDetails?.subCategoryId ?? ""
        let agentId = data.policyDetails?.agentId ?? ""
        
//        let param :[String:Any]  = ["agentId":agentId, "partnerId":partnerId, "categoryId":catId, "subCategoryId":subCatId, "productList":prodList]
//        print(param)
//        proposaldetailVM.getCommissionApi(param: param)
        
    }
    
    
}

extension ProposalDetailVC: updateProposalData, AddPropsalProtocolDelegate, ProposalCommissionProtocolDelegate, SuccessProtocol, updateProposalEditDataFromMainListing, UpdateGeneralPropsalProtocolDelegate {
    
    func setUpdateProposalSuccessList(data: editProposalModel) {
        if data.status == "SUCCESS" {

//            UserDefaults.standard.removeObject(forKey: "fromLead")
            UserDefaults.standard.set("no", forKey: "fromLead")
            self.popVC(animated: true)
            
            
        } else {
            DispatchQueue.main.async {
                  if data.error?.errorCode == AppKeys.invalidTokenCode {
                      
                      LTY_AppDelegate.setRootVC()
                  }else {
                      DispatchQueue.main.async {
                          let language =  kUserDefaults.value(forKey: APPLE_LANGUAGE_KEY)
                          let result = language as! NSArray
                          
                          if result[0] as! String == "fr" {
                              self.ShowAlert(message: data.error?.clientErrorMessageInFrench ?? "")

                          }else{
                              self.ShowAlert(message: data.error?.clientErrorMessage ?? "")

                          }
                      }
                      
                  }
              }
          }
    }
    
    
    func updateEditedDataFromMainListing() {
        
        lblInsuranceType.text = addProposalDic["insuranceType"] as? String
        policyTypeLbl.text = addProposalDic["policyType"] as? String
        
        var startDate =  addProposalDic["startDate"] as? String
        startDate = startDate?.components(separatedBy: "T")[0]
        startDateLbl.text = returnDOB(date: startDate ?? "")
        
        var endDate =  addProposalDic["endDate"] as? String
        endDate = endDate?.components(separatedBy: "T")[0]
        endDateLbl.text = returnDOB(date: endDate ?? "")
        
        policynumberLbl.text = addProposalDic["offerId"] as? String
        self.keyTagsArr = addProposalDic["keyTags"] as! [String]
        
        let catDetails = addProposalDic["categoryDetails"] as! NSMutableDictionary
        
        let language =  kUserDefaults.value(forKey: APPLE_LANGUAGE_KEY)
        let result = language as! NSArray
        
        if result[0] as! String == "fr" {
            catLcbl.text = catDetails["categoryNameInFrench"] as? String
            subcatLcbl.text = catDetails["subCategoryNameInFrench"] as? String
        }else{
            catLcbl.text = catDetails["categoryName"] as? String
            subcatLcbl.text = catDetails["subCategoryName"] as? String
        }
        
        let productDetails = addProposalDic["productDetails"] as! NSMutableDictionary
        let prodList = productDetails["productList"] as! NSMutableArray
        var arr = NSMutableArray()
        self.insuranceProductLcbl.text = ""
        for items in prodList {
            let item = items as! NSMutableDictionary
           
            if result[0] as! String == "fr" {
                arr.add(item["productNameInFrench"] ?? "")
                self.insuranceProductLcbl.text! += "\(item["productNameInFrench"] ?? "") - \(item["amount"] ?? 0)\n"

            }else{
                arr.add(item["productName"] ?? "")
                self.insuranceProductLcbl.text! += "\(item["productName"] ?? "") - \(item["amount"] ?? 0)\n"
            }
        }

//        self.insuranceProductLcbl.text = arr.componentsJoined(by: ",")
//
////        insuranceProductLcbl.text = addProposalDic["policyType"] as? String
        agentbl.text = addProposalDic["agentName"] as? String
        periodicityLbl.text = addProposalDic["periodicity"] as? String
        premiumAmountLbl.text = addProposalDic["premiumAmount"] as? String
        totalAmountLcbl.text = addProposalDic["totalAmount"] as? String

        
        let productBenefits = addProposalDic["productBenefits"] as? String
        benefitsLbl.text =  productBenefits?.html2String
        
        let keyFeatures = addProposalDic["keyFeatures"] as? String

        featuresLbl.text = keyFeatures?.html2String
        
//        benefitsLbl.text = addProposalDic["productBenefits"] as? String
//        featuresLbl.text = addProposalDic["keyFeatures"] as? String

        let policyDetails = addProposalDic["policyDocs"] as! NSMutableArray
        self.policyDocsArr = policyDetails
//        policyDocLbl.text = policyDetails.componentsJoined(by: ",")

        // set commissions again after editing proposal
        
        let partnerId =  kUserDefaults.string(forKey: "partnerID") ?? ""
        let catId = catDetails["categoryId"] as! String
        let subCatId = catDetails["subCategoryId"] as! String
        let agentId = addProposalDic["agentId"] as! String
        
        let userType = kUserDefaults.value(forKey: AppKeys.userType)
        let sourceId = kUserDefaults.value(forKey: AppKeys.sourceId)
        let PartnerId = kUserDefaults.value(forKey: AppKeys.partnerID)
        var param :[String:Any]
        if userType as! String == "AGENT"{
            param = ["agentId":partnerId, "partnerId":sourceId, "categoryId":catId, "subCategoryId":subCatId, "productList":prodList]
        }else{
            param = ["agentId":agentId, "partnerId":partnerId, "categoryId":catId, "subCategoryId":subCatId, "productList":prodList]
        }

        
        proposaldetailVM.delegate = self
        proposaldetailVM.getCommissionApi(param: param)
        setUpCollectionView()
        
    }
    
    
    func updateSuccess() {
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
            self.navigationController!.popToViewController(viewControllers[viewControllers.count - 8], animated: true)
    }
    
    
    func setCommissionData(data: commissionModel) {
        if data.status == "SUCCESS" {
            self.commissionData = data.data!
            print(self.commissionData!)
            setCommissionData()
        }
        
        
    }
    
    func popupMsg(msg: String) {
        ShowAlert(message: msg)
    }
    
    
    func updateData() {
        setData()
        setUpCollectionView()
    }
    
    func setSuccessList(data: addProposalModel) {
        if data.status == "SUCCESS" {
//            DispatchQueue.main.async {
//                let vc = ProposalAddSuccessVC.instantiate(fromAppStoryboard: .proposalStoryboard)
//                vc.delegate = self
//                vc.modalTransitionStyle = .crossDissolve
//                vc.modalPresentationStyle = .overFullScreen
//                self.present(vc, animated: true)
//            }
//            UserDefaults.standard.removeObject(forKey: "fromLead")
            UserDefaults.standard.set("no", forKey: "fromLead")

            if fromWhichVC == "ProposalVC" {
                self.popVC(animated: true)
            } else if fromWhichVC == "ForEditProposal" {
                self.popVC(animated: true)
            } else {
                let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
                    self.navigationController!.popToViewController(viewControllers[viewControllers.count - 8], animated: true)
            }
            
            
            
            
        } else {
            DispatchQueue.main.async {
                  if data.error?.errorCode == AppKeys.invalidTokenCode {
                      
                      LTY_AppDelegate.setRootVC()
                  }else {
                      DispatchQueue.main.async {
                          let language =  kUserDefaults.value(forKey: APPLE_LANGUAGE_KEY)
                          let result = language as! NSArray
                          
                          if result[0] as! String == "fr" {
                              self.ShowAlert(message: data.error?.clientErrorMessageInFrench ?? "")

                          }else{
                              self.ShowAlert(message: data.error?.clientErrorMessage ?? "")

                          }
                      }
                      
                  }
              }
          }
    }
    
}

extension Data {
    var html2AttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: self, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            print("error:", error)
            return  nil
        }
    }
    var html2String: String { html2AttributedString?.string ?? "" }
}

extension StringProtocol {
    var html2AttributedString: NSAttributedString? {
        Data(utf8).html2AttributedString
    }
    var html2String: String {
        html2AttributedString?.string ?? ""
    }
}
