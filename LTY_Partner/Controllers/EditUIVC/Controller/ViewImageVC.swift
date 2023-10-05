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
    var showImageViewModel = ShowImageViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
  
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print(image)
        showImageViewModel.delegate = self

        let param : [String:Any] = ["key":image ]
        showImageViewModel.ViewImageApi(param: param)
    }

    @IBAction func onClickRemove(_ sender: UIButton) {
        self.dismiss(animated: true)
    }


}

extension ViewImageVC : ShowImageViewProtocolDelegate{
    func showImage(data: ShowImageModel) {
        print(data)
        self.imgimageView.sd_setImage(with: URL(string: data.data?.preSignedUrl ?? ""), placeholderImage: UIImage(named: "image_placeholder"))

    }
    
    func popupMsg(msg: String) {
        DispatchQueue.main.async {
            self.ShowAlert(message: msg)
        }
    }
    
    
}
