//
//  SelectLanguageVC.swift
//  LTY_Partner
//
//  Created by Chawtech on 03/05/23.
//

import UIKit

protocol DismissSelectLanguageVC {
    func dismissScreen(setValue:Bool)
}

class SelectLanguageVC: UIViewController {
    
    //MARK:- Variables
    
    var selectLang = [SelectLang]()
    var isComingFrom = ""
    var delegate : DismissSelectLanguageVC?
    //MARK:- Outlets
    
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var imageLogo: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var labelSelectLanguage: UILabel!
    
    //MARK:- Did load func
    
    override func viewDidLoad() {
        super.viewDidLoad()

        selectLang.append(SelectLang(languageName: LTYText.french.localized()))
        selectLang.append(SelectLang(languageName:LTYText.english.localized()))
//        selectLang.append(SelectLang(languageName: LTYText.italian.localized()))
//        selectLang.append(SelectLang(languageName: LTYText.portuguese.localized()))
//        selectLang.append(SelectLang(languageName:LTYText.albanian.localized()))

      
        SetUpView()
        setUpTableView()

    }
    
    //MARK:- setUp TableView
    
    func setUpTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.registerCell(SelectLanguageTVC.self)
    }
    
    //MARK:- SetUp UIVIew
    
    func SetUpView() {
        lineView.viewCorner(5)
        backgroundView.viewCorner(15)
        imageLogo.isHidden = true
        labelSelectLanguage.font = FontSize.size20
     //   view.backgroundColor = Asset.Colors.lightBlack.color
        self.navigationController?.navigationBar.isHidden = true
        btnBack.setImage(Asset.Assets.backArrow.image, for: .normal)
        labelSelectLanguage.textColor = Asset.Colors.blackColor.color
        
//        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissPopUp(_:)))
//        mainView.addGestureRecognizer(tap)
//        mainView.isUserInteractionEnabled = true
    }
    
    //MARK:- Dismiss PopUP
    
    @objc func dismissPopUp(_ sender: UITapGestureRecognizer? = nil) {
      //  self.dismiss(animated: true)
    }
    
    //MARK:- back btn Action
    
    @IBAction func btnBackAction(_ sender: UIButton) {
        //popVC(animated: true)
        dismiss(animated: false)
    }
}
