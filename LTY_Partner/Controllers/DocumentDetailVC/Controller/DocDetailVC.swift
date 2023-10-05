//
//  DocDetailVc.swift
//  LTY_Partner
//
//  Created by Chawtech on 05/07/23.
//

import UIKit
import MobileCoreServices
import UniformTypeIdentifiers

protocol UpdateDoctableDelegate{
    func updateDocCount(value:String)
}

class DocDetailVC: UIViewController {

    @IBOutlet weak var noDataFoundView: UIView!
    @IBOutlet weak var customNavDrower: CustomNavigationBarForDrawer!
    @IBOutlet weak var customNavHeight: NSLayoutConstraint!
    @IBOutlet weak var btnUploadNew: UIButton!
    @IBOutlet weak var docTable: UITableView!
    
    var docArr = [CustMemberDocDocList]()
    var customerMemberVM = CustomerMemberViewModel()
    var userId = ""
    var memberId = ""
    var picker = UIImagePickerController()
    var pickedImageUrl:URL?
    var updateDocCountProtocol : UpdateDoctableDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        setDrowerHeight()
        setupTableView()
        customNavDrower.titleLabel.text = "Document Details".localized()
        btnUploadNew.setTitle("Upload New File".localized(), for: .normal)
        customNavDrower.titleLabel.textAlignment = .center
        customNavDrower.leftSideMenuButtonItem.setImage(Asset.Assets.backArrow.image, for: .normal)
        customNavDrower.leftSideMenuButtonItem.addTarget(self, action: #selector(backActionBtn(_:)), for: .touchUpInside)
        customerMemberVM.docDelegate = self
        let param: [String : Any] = ["userId": userId, "memberId": memberId]
        customerMemberVM.getCustomerMemberDocumentApi(param: param)
    }

    func setupTableView(){
        docTable.delegate = self
        docTable.dataSource = self
        docTable.register(UINib(nibName: "DocDetailTVC", bundle: .main), forCellReuseIdentifier: "DocDetailTVC")
    }
    
    override func viewWillAppear(_ animated: Bool) {
     
        self.tabBarController?.tabBar.isHidden = true

    }

    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    //MARK:- backAction Btn
    
    @objc func backActionBtn(_ sender: UIButton) {
     //   self.popVC(animated: true)
        self.navigationController?.popViewControllerWithHandler(completion: {
            self.updateDocCountProtocol?.updateDocCount(value: "true")
        })
        
    }
    
    //MARK:- set navigationDrower Height
    
    func setDrowerHeight() {
        if UIDevice.current.hasNotch {
            customNavHeight.constant = DroverHeight.haveNotch
        } else {
            customNavHeight.constant = DroverHeight.dontHaveNotch
            
        }
    }
    
    @IBAction func onClickUpload(_ sender: UIButton) {
        self.chooseWhatToUpload()
    }
    
    

}

extension DocDetailVC: CustomerMemberDocProtocolDelegate {
    
    func setCustMemberDocData(data: CustMemberDocModel) {
        self.docArr.removeAll()
        if data.status == "SUCCESS" {
            self.docArr = data.data?.docList ?? []
            
            if docArr.count == 0 {
                DispatchQueue.main.async {

                    self.docTable.isHidden = true
                    self.noDataFoundView.isHidden = false



                }
            } else {
                DispatchQueue.main.async {

                    self.docTable.isHidden = false
                    self.noDataFoundView.isHidden = true


                    self.docTable.reloadData()
                }
            }
            
        }
        else {
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
    
    func popupMsg(msg: String) {
        ShowAlert(message: msg)
    }
    
    
}

extension DocDetailVC :UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 211
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.docArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = docTable.dequeueReusableCell(withIdentifier: "DocDetailTVC", for: indexPath) as! DocDetailTVC
        let info = self.docArr[indexPath.row]
        cell.btnView.tag = indexPath.row
        cell.btnView.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        cell.lblName.text = info.docName ?? ""
        cell.lblUploaded.text = info.uploadedBy ?? ""
        var uploadedOnStr = info.uploadedOn ?? ""
        uploadedOnStr = uploadedOnStr.components(separatedBy: "T")[0]
        cell.lblUploadOn.text = returnDOB(date: uploadedOnStr)
        cell.selectionStyle = .none
        return cell
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        let vc = ViewAttachmentsVC.instantiate(fromAppStoryboard: .home)
        let info = self.docArr[sender.tag]
        vc.attachmentStr = info.docUrl ?? ""
        self.presentVC(vc, animated: true, presentationStyle: .pageSheet)
    }
    
    
}

extension DocDetailVC : UINavigationControllerDelegate, UIDocumentMenuDelegate, UIDocumentPickerDelegate, UIImagePickerControllerDelegate {
    
    func chooseWhatToUpload() {
            
            let alertController = UIAlertController(title: "Please select what would you like to upload?".localized(), message: "", preferredStyle: .actionSheet)
            let cancelButton = UIAlertAction(title: "Cancel".localized(), style: .cancel, handler: nil)
            alertController.addAction(UIAlertAction(title: "Image".localized(), style: .default , handler:{ (UIAlertAction)in
                self.chooseType()
            }))
            alertController.addAction(UIAlertAction(title: "Document".localized(), style: .default , handler:{ (UIAlertAction)in
                self.clickFunction()
            }))
            
            alertController.addAction(cancelButton)
            self.present(alertController, animated: true)
    //        UIApplication.topViewController()?.present(alertController, animated: true, completion: nil)

        }
        
        
        func chooseType() {
            let alert = UIAlertController(title: "", message: "Select Mode".localized(), preferredStyle: UIAlertController.Style.actionSheet)
            
            
            let deletbutton =  UIAlertAction(title: "Delete".localized(), style: UIAlertAction.Style.destructive, handler: {(action) in
                // self.Profileimage.image = #imageLiteral(resourceName: "customer.png")
                
            })

            
            alert.addAction(UIAlertAction(title: "Cancel".localized(), style: UIAlertAction.Style.cancel, handler: nil))
            
            let uploadphoto = UIAlertAction(title: "Upload Photo".localized(), style: UIAlertAction.Style.default, handler: {(action) in
                self.picker.delegate = self
                self.picker.allowsEditing = false
                self.picker.sourceType = .photoLibrary
                self.present(self.picker, animated: true)
    //            UIApplication.topViewController()?.present(self.picker, animated: true, completion: nil)
                
                
            })
            
            alert.addAction(uploadphoto)
            //  alert.addAction(deletbutton)
            // show the alert
            self.present(alert, animated: true)
    //        UIApplication.topViewController()?.present(alert, animated: true, completion: nil)
        }
        
        func clickFunction() {
            
            
            
            let types: [String] = ["com.apple.iwork.pages.pages", "com.apple.iwork.numbers.numbers", "com.apple.iwork.keynote.key","public.image", "com.apple.application", "public.item", "public.content", "public.audiovisual-content", "public.movie", "public.audiovisual-content", "public.video", "public.audio", "public.text", "public.data", "public.zip-archive", "com.pkware.zip-archive", "public.composite-content"]
            let documentPicker = UIDocumentPickerViewController(documentTypes: types, in: .import)
            documentPicker.delegate = self
            documentPicker.allowsMultipleSelection = false
            documentPicker.modalPresentationStyle = .formSheet
            present(documentPicker, animated: true, completion: nil)
            
            /*
            let importMenu = UIDocumentMenuViewController(documentTypes: ["public.text", "com.apple.iwork.pages.pages", "public.data"], in: .import)
            importMenu.delegate = self
            importMenu.modalPresentationStyle = .formSheet
            self.present(importMenu, animated: true, completion: nil)
            
            // UIApplication.topViewController()?.present(importMenu, animated: true, completion: nil)
            */
        }
        
        
        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            guard let myURL = urls.first else {
                return
            }
            print("import result : \(myURL)")
            let filename = URL(fileURLWithPath: String(describing:urls)).lastPathComponent
            let fileUrlkk = Foundation.URL(string: myURL.absoluteString)
            do {
                let data = try Data(contentsOf: fileUrlkk!)
                let imageSize: Int = data.count
                if Double(imageSize) / 1000000.0 < 25.0 {
    //                self.uploadFileAPI(data, fileNamee: myURL.lastPathComponent)
                    self.pickedImageUrl = myURL
                    self.requestNativeImageUpload(filename)
                }
            } catch {
                
            }
            
        }
        
        func documentMenu(_ documentMenu: UIDocumentMenuViewController, didPickDocumentPicker documentPicker: UIDocumentPickerViewController) {
            documentPicker.delegate = self
            documentPicker.modalPresentationStyle = .fullScreen
            self.present(documentPicker, animated: true, completion: nil)
            // UIApplication.topViewController()?.present(documentPicker, animated: true, completion: nil)
        }
        
        func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
            print("view was cancelled")
            //UIApplication.topViewController()?.dismiss(animated: true, completion: nil)
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    //        let chosenImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
    //        let imageData = chosenImage.jpegData(compressionQuality: 0.5)
    //        UIApplication.topViewController()?.dismiss(animated: true, completion: nil)
            if let pickedImage = info[.originalImage] as? UIImage {
                saveImageDocumentDirectory(usedImage: pickedImage)
            }
            if let imgUrl = getImageUrl()
            {
                pickedImageUrl = imgUrl
            }
            
            self.dismiss(animated: true, completion: nil)
            
            self.requestNativeImageUpload(pickedImageUrl?.lastPathComponent ?? "")
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    //        UIApplication.topViewController()?.dismiss(animated: true, completion: nil)
            self.dismiss(animated: true, completion: nil)
        }


        
    func requestNativeImageUpload(_ docName: String){
        SwiftLoader.show(animated: true)
        let fullUrl =  LTY_BASE_URL.DOCUMENT_UPLOAD_URL
        let partnerIdd = kUserDefaults.string(forKey: "partnerID") ?? ""
        //            let param = ["userId": partnerIdd, "docName": "Abc"]
        let param = ["userId": self.userId, "docName": docName, "uploadedBy": partnerIdd, "memberId": self.memberId]
        print(param)
        
        ServerClass.sharedInstance.sendMultipartRequestToServer(urlString: fullUrl, fileName: "doc", sendJson: param, imageUrl: pickedImageUrl, successBlock: { (json) in
            print(json)
            SwiftLoader.hide()
            //hideAllProgressOnView(appDelegateInstance.window!)
            let success = json["status"].stringValue
            if success  == "SUCCESS"
            {
//                self.policyDocArr.removeAll()
//                let url = json["data"]["key"].stringValue
//
//                self.policyDocArr.append(url)
                DispatchQueue.main.async {
                    self.showToast(message: "File uploaded successfully.".localized(), font: FontSize.size14!)
                    let param: [String : Any] = ["userId": self.userId, "memberId": self.memberId]

                    self.customerMemberVM.getCustomerMemberDocumentApi(param: param)
                }
                
                
            }else{
                self.ShowAlert(message: json["error"]["serverErrorMessage"].stringValue)
            }
            DispatchQueue.main.async {
                //self.tbleView.reloadData()
            }
        }, errorBlock: { (NSError) in
            SwiftLoader.hide()
            //                UIAlertController.showInfoAlertWithTitle("Alert", message: kUnexpectedErrorAlertString, buttonTitle: "Okay")
            //                hideAllProgressOnView(appDelegateInstance.window!)
        })
        
    }
        
        
        
        
        func generateBoundary() -> String {
            return "Boundary-\(NSUUID().uuidString)"
        }
        
        func createDataBody(withParameters params: [String: String]?, media: [Media]?, boundary: String) -> Data {
            
            let lineBreak = "\r\n"
            var body = Data()
            
            if let parameters = params {
                for (key, value) in parameters {
                    body.append("--\(boundary + lineBreak)")
                    body.append("Content-Disposition: form-data; name=\"\(key)\"\(lineBreak + lineBreak)")
                    body.append("\(value + lineBreak)")
                }
            }
            
            if let media = media {
                for photo in media {
                    body.append("--\(boundary + lineBreak)")
                    body.append("Content-Disposition: form-data; name=\"\(photo.key)\"; filename=\"\(photo.fileName)\"\(lineBreak)")
                    body.append("Content-Type: \(photo.mimeType + lineBreak + lineBreak)")
                    body.append(photo.data)
                    body.append(lineBreak)
                }
            }
            
            body.append("--\(boundary)--\(lineBreak)")
            
            return body
        }
        
        
        struct Media {
            let key: String
            let fileName: String
            let data: Data
            let mimeType: String
            
            init?(withImage image: UIImage, forKey key: String) {
                self.key = key
                self.mimeType = "image/jpg"
                self.fileName = "\(arc4random()).jpeg"
                
                guard let data = image.jpegData(compressionQuality: 0.5) else { return nil }
                self.data = data
            }
        }
    
}
