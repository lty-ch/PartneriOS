//
//  GetStartScreenVC.swift
//  LTY_Partner
//
//  Created by Chawtech on 04/05/23.
//

import UIKit

class GetStartScreenVC: UIViewController {

    //MARK:- Outlets
    
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelSubTitle: UILabel!
    @IBOutlet weak var btnGetStarted: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
    
    //var images = ["family-insurance","man-working-on-ab-testing","support-center"]
    var images = ["step01","step02","step03"]
    //MARK:- Did load func
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCollectionView()
        setUpView()

    }
    
    //MARK:- SetUp Collection view
    
    func setUpCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.viewCorner(10)
       
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(GetStartedCVC.self)
    }
    
    //MARK:- SetUp UIView
    
    func setUpView () {
        self.pageControl.numberOfPages = 3
        btnGetStarted.viewCorner(8)
//        labelTitle.textColor = Asset.Colors.gray1.color
//        labelTitle.font = UIFont(name:"Helvetica",size:20)
//        labelSubTitle.font = UIFont(name:"Helvetica",size:14)
//        labelSubTitle.textColor = Asset.Colors.lightGray.color
        self.navigationController?.navigationBar.isHidden = true
        
        btnBack.setImage(Asset.Assets.backArrow.image, for: .normal)
        btnGetStarted.titleLabel?.font = UIFont(name: "Helvetica",size: 16)
        btnGetStarted.backgroundColor = Asset.Colors.lightBlue.color
        btnGetStarted.titleLabel?.textColor = Asset.Colors.whiteColor.color
        btnGetStarted.setTitle(LTYText.text_GetStarted.localized(), for: .normal)
//        labelTitle.text = LTYText.text_getStartVCTitle1.localized()
//        labelSubTitle.text = LTYText.text_getStartVCSubTitle1.localized()
    }
    
    
    @IBAction func btnGetStartAction(_ sender: UIButton) {
         let vc = LoginVC.instantiate(fromAppStoryboard: .main)
        //self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        pushToVC(vc, animated: true)
    }
    
    @IBAction func backBtnAction(_ sender: UIButton) {
    popVC(animated: true)
    }
}
