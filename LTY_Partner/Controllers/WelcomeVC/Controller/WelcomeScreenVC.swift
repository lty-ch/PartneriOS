//
//  WelcomeScreenVC.swift
//  LTY_Partner
//
//  Created by Chawtech on 03/05/23.
//

import UIKit

class WelcomeScreenVC: UIViewController {

    //MARK:- Outlets
    
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var labelSubTitle: UILabel!
    @IBOutlet weak var imageBackGround: UIImageView!

    //MARK:- Did load func
    
    override func viewDidLoad() {
        super.viewDidLoad()
      //  setUpView()
    }
    override func viewWillAppear(_ animated: Bool) {
        setUpView()
    }
    
    //MARK:- SetUp View
    
    func setUpView() {
        labelSubTitle.text = LTYText.text_WelcomeVCTitle.localized()
        btnNext.viewCorner(8)
        view.backgroundColor = Asset.Colors.lightBlue.color
        labelSubTitle.font = FontSize.boldsize32
        btnNext.titleLabel?.font = FontSize.size16
    
        labelSubTitle.textColor = Asset.Colors.whiteColor.color
        btnNext.backgroundColor = Asset.Colors.lightBlue.color
        btnNext.setTitle(LTYText.text_Next.localized(), for: .normal)
        btnNext.titleLabel?.textColor = Asset.Colors.whiteColor.color

    }
    
    //MARK:- next Btn Action
    
    @IBAction func btnNextAction(_ sender: UIButton) {
        
        let vc = SelectLanguageVC.instantiate(fromAppStoryboard: .main)
        vc.delegate = self
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true)
    }
    
}

extension WelcomeScreenVC : DismissSelectLanguageVC {
    func dismissScreen(setValue: Bool) {
        if setValue == true {
            let vc = GetStartScreenVC.instantiate(fromAppStoryboard: .main)
            //self.storyboard?.instantiateViewController(withIdentifier: "GetStartScreenVC") as! GetStartScreenVC
            pushToVC(vc, animated: true)
        }
    }
    
}
