//
//  ViewImageVC.swift
//  LTY_Partner
//
//  Created by Chawtech on 09/06/23.
//

import UIKit
import SDWebImage

class ViewImageVC: UIViewController {
    
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var imgimageView: UIImageView!
    var image = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.imgimageView.sd_setImage(with: URL(string: image), placeholderImage: nil)
    }
    

    @IBAction func onClickRemove(_ sender: UIButton) {
        self.dismiss(animated: true)
    }


}

