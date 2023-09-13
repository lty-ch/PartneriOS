//
//  ContainerViewController.swift
//  LTY_Partner
//
//  Created by Chawtech on 30/05/23.
//

import UIKit
class ContainerViewController: UIViewController {
    
    @IBOutlet private weak var stepView: StepView!
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var nextButton: UIButton!
    @IBOutlet weak var customNavView: CustomNavigationBarForDrawer!
    @IBOutlet weak var customNavHeight: NSLayoutConstraint!
    
    
    private var pageViewController: UIPageViewController!
    fileprivate lazy var pages: [UIViewController] = {
        return [
//            self.getViewController(withIdentifier: String.init(describing: FirstViewController.self)),
            self.getViewController(withIdentifier: String.init(describing: SecondViewController.self)),
            self.getViewController(withIdentifier: String.init(describing: ThirdViewController.self)),
            self.getViewController(withIdentifier: String.init(describing: FourthViewController.self)),
            self.getViewController(withIdentifier: String.init(describing: FifthViewController.self)),
            self.getViewController(withIdentifier: String.init(describing: FirstViewController.self)),
            self.getViewController(withIdentifier: String.init(describing: SixthViewController.self)),
            self.getViewController(withIdentifier: String.init(describing: SeventhViewController.self))
                    
        ]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupControllers()
        setDrowerHeight()
        customNavView.titleLabel.text = "Add Proposal".localized()
        customNavView.titleLabel.textAlignment = .center
        customNavView.leftSideMenuButtonItem.setImage(Asset.Assets.backArrow.image, for: .normal)
        customNavView.leftSideMenuButtonItem.addTarget(self, action: #selector(backActionBtn(_:)), for: .touchUpInside)
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true
        }
    
    override func viewWillDisappear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false

    }
  
    
    //MARK:- backAction Btn
    
    @objc func backActionBtn(_ sender: UIButton) {
       // self.dismiss(animated: true)
        if stepView.selectedStep == 1 {
            self.navigationController?.popViewController(animated: true)
        }
        else {
            stepView.showPreviousStep()

            if let controllerToShow = getControllerToShow(from: stepView.selectedStep) {
                pageViewController.setViewControllers([controllerToShow], direction: .reverse, animated: true, completion: nil)
            }
        }
        
    }
    
    //MARK:- set navigationDrower Height
    
    func setDrowerHeight() {
        if UIDevice.current.hasNotch {
            customNavHeight.constant = DroverHeight.haveNotch
        } else {
            customNavHeight.constant = DroverHeight.dontHaveNotch
            
        }
    }
    // MARK: - Setup views
    
    private func setupControllers() {
        pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageViewController.view.frame = containerView.bounds
        containerView.addSubview(pageViewController.view)
        
        if let firstController = pages.first {
            pageViewController.setViewControllers([firstController], direction: .forward, animated: true, completion: nil)
        }
    }
    
    fileprivate func getViewController(withIdentifier identifier: String) -> UIViewController {
        return UIStoryboard(name: "Proposals", bundle: nil).instantiateViewController(withIdentifier: identifier)
    }
    
    private func getControllerToShow(from index: Int) -> UIViewController? {
        if index - 1 < pages.count {
            return pages[index - 1]
        }
        else {
            print("Index is out of range")
            return nil
        }
    }
    
    // MARK: - Actions
    
    @IBAction func nextButtonDidPress(_ sender: Any) {
        stepView.showNextStep()
    if let controllerToShow = getControllerToShow(from: stepView.selectedStep) {
            pageViewController.setViewControllers([controllerToShow], direction: .forward, animated: true, completion: nil)
        }
    }
            
    @IBAction func CancleButtonDidPress(_ sender: Any) {
        backButtonDidPress()
    }
    
    
    func backButtonDidPress() {
        if stepView.selectedStep == 1 {
            self.navigationController?.popViewController(animated: true)
        }
        else {
            stepView.showPreviousStep()

            if let controllerToShow = getControllerToShow(from: stepView.selectedStep) {
                pageViewController.setViewControllers([controllerToShow], direction: .reverse, animated: true, completion: nil)
            }
        }
    }
}
