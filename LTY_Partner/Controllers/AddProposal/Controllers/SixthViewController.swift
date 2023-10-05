//
//  SixthViewController.swift
//  LTY_Partner
//
//  Created by Chawtech on 31/05/23.
//

import UIKit
import SDWebImage
import MobileCoreServices
import UniformTypeIdentifiers

class SixthViewController: UIViewController {
    
    
    var picker = UIImagePickerController()
    var pickedImageUrl:URL?
    var isComingFrom = ""
    var delegate : updateProposalData?
    var updateDelegate : updateProposalEditDataFromMainListing?
    
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var btnDone: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var collView: UICollectionView!
    @IBOutlet weak var nextBtnStackView: UIStackView!
    @IBOutlet weak var doneStackView: UIStackView!
    
    var policyDocsArr = NSMutableArray()
//    var addProposalVM = AddProposalViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setLocalizationText()
        if isComingFrom == "ProposalVC" || isComingFrom == "ForEditProposal" || isComingFrom == "EditVC" || isComingFrom == "ContractVC" {
            self.setData()
        }
    }
    
    func setLocalizationText() {
        self.btnDone.setTitle("Done".localized(), for: .normal)
        self.btnCancel.setTitle("Cancel".localized(), for: .normal)
        self.btnNext.setTitle("Next".localized(), for: .normal)
        
        self.lblTitle.text = "Policy Documents & Information".localized()
   
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        
        if isComingFrom == "EditVC" || isComingFrom == "ProposalVC" || isComingFrom == "LeadProposalVC" || isComingFrom == "ForEditProposal"{
            doneStackView.isHidden = false
            nextBtnStackView.isHidden = true
        }else {
            doneStackView.isHidden = true
            nextBtnStackView.isHidden = false
        }
    }
    

    @IBAction func onClickUpload(_ sender: UIButton) {
        self.chooseWhatToUpload()
    }
    
    @IBAction func onClickNext(_ sender: Any) {
      
        if policyDocsArr.count > 0 {
            addProposalDic.setValue(self.policyDocsArr, forKey: "policyDocs")
            let vc = ProposalDetailVC.instantiate(fromAppStoryboard: .proposalStoryboard)
            vc.fromWhichVC = "EditVC"
            self.pushToVC(vc, animated: true)
        } else {
            self.ShowAlert(message: "Please upload policy docs.".localized())
        }
        

    }
    
    //MARK:- done action btn
    @IBAction func doneActionBtn(_ sender: UIButton) {
        addProposalDic.setValue(self.policyDocsArr, forKey: "policyDocs")
        
        navigationController?.popViewControllerWithHandler(animated: true, completion: {
            if self.isComingFrom == "EditVC" || self.isComingFrom == "ForEditProposal"{
                self.delegate?.updateData()
            } else {
                self.updateDelegate?.updateEditedDataFromMainListing()
            }
        })
        
    }
    
    @IBAction func onClickCancel(_ sender: Any) {
        self.popVC(animated: true)
    }
    
    @IBAction func backActionBtn(_ sender: UIButton) {
        popVC(animated: true)
    }

    func setData() {
        
        let policyDetails = addProposalDic["policyDocs"] as! NSMutableArray
        self.policyDocsArr = policyDetails
        self.collView.reloadData()
    }
    
    
    @IBAction func removeAction(_ sender: UIButton) {
        let indexPath: IndexPath? = collView.indexPathForItem(at: sender.convert(CGPoint.zero, to: collView))
        self.policyDocsArr.removeObject(at: indexPath!.row)
        self.collView.reloadData()
    }
    
}

extension SixthViewController : UINavigationControllerDelegate, UIDocumentMenuDelegate, UIDocumentPickerDelegate, UIImagePickerControllerDelegate {
    
    func chooseWhatToUpload() {
            
        let alertController = UIAlertController(title: "Please select what would you like to upload?".localized(), message: "", preferredStyle: .actionSheet)
            let cancelButton = UIAlertAction(title: "Cancel".localized(), style: .cancel, handler: nil)
            alertController.addAction(UIAlertAction(title: "Image".localized(), style: .default , handler:{ (UIAlertAction)in
//                self.chooseType()
                self.picker.delegate = self
                self.picker.allowsEditing = false
                self.picker.sourceType = .photoLibrary
                self.present(self.picker, animated: true)
            }))
            alertController.addAction(UIAlertAction(title: "Document".localized(), style: .default , handler:{ (UIAlertAction)in
                self.clickFunction()
            }))
            
            alertController.addAction(cancelButton)
            self.present(alertController, animated: true)
    //        UIApplication.topViewController()?.present(alertController, animated: true, completion: nil)

        }
        
        func noCamera(){
            let alertVC = UIAlertController(
                title: "No Camera".localized(),
                message: "Sorry, this device has no camera".localized(),
                preferredStyle: .alert)
            let okAction = UIAlertAction(
                title: "OK".localized(),
                style:.default,
                handler: nil)
            alertVC.addAction(okAction)
            self.present(alertVC, animated: true)
    //        UIApplication.topViewController()?.present(
    //            alertVC,
    //            animated: true,
    //            completion: nil)
        }
        
        func chooseType() {
            let alert = UIAlertController(title: "", message: "Select Mode".localized(), preferredStyle: UIAlertController.Style.actionSheet)
            
            
            let deletbutton =  UIAlertAction(title: "Delete".localized(), style: UIAlertAction.Style.destructive, handler: {(action) in
                // self.Profileimage.image = #imageLiteral(resourceName: "customer.png")
                
            })
            // add the actions (buttons)
            let takephoto =  UIAlertAction(title: "Take Photo".localized(), style: UIAlertAction.Style.default, handler: {(action) in
                
                if UIImagePickerController.isSourceTypeAvailable(.camera) {
                    self.picker.delegate = self
                    self.picker.allowsEditing = false
                    self.picker.sourceType = UIImagePickerController.SourceType.camera
                    self.picker.cameraCaptureMode = .photo
                    self.picker.modalPresentationStyle = .fullScreen
                    self.present(self.picker, animated: true)
    //                UIApplication.topViewController()?.present(self.picker,animated: true,completion: nil)
                } else {
                    self.noCamera()
                }
                
                
            })
            
            alert.addAction(UIAlertAction(title: "Cancel".localized(), style: UIAlertAction.Style.cancel, handler: nil))
            
            let uploadphoto = UIAlertAction(title: "Upload Photo".localized(), style: UIAlertAction.Style.default, handler: {(action) in
                self.picker.delegate = self
                self.picker.allowsEditing = false
                self.picker.sourceType = .photoLibrary
                self.present(self.picker, animated: true)
    //            UIApplication.topViewController()?.present(self.picker, animated: true, completion: nil)
                
                
            })
            
//            alert.addAction(takephoto)
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
            let fileUrlkk = Foundation.URL(string: myURL.absoluteString)
            let filename = URL(fileURLWithPath: String(describing:urls)).lastPathComponent

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
            let fullUrl = LTY_BASE_URL.DOCUMENT_UPLOAD_URL
            let partnerIdd = kUserDefaults.string(forKey: "partnerID") ?? ""
//            let param = ["userId": partnerIdd, "docName": "Abc"]
            let param = ["userId": "", "docName": docName, "uploadedBy": partnerIdd, "memberId": ""]
                       print(param)
                
            ServerClass.sharedInstance.sendMultipartRequestToServer(urlString: fullUrl, fileName: "doc", sendJson: param, imageUrl: pickedImageUrl, successBlock: { (json) in
                print(json)
                SwiftLoader.hide()
                //hideAllProgressOnView(appDelegateInstance.window!)
                let success = json["status"].stringValue
                if success  == "SUCCESS"
                {
                    let url = json["data"]["key"].stringValue
                    self.policyDocsArr.add(url)
                    DispatchQueue.main.async {
                        self.showToast(message: "Image upload successfully.", font: FontSize.size14!)
                        self.collView.reloadData()
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

extension SixthViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return policyDocsArr.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PolicyDocsCollCell", for: indexPath) as! PolicyDocsCollCell
        
        cell.cellImg.sd_setImage(with: URL(string: self.policyDocsArr[indexPath.row] as! String), placeholderImage: UIImage(named: "docs"))
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width: CGFloat = ((collView.frame.size.width) / 3)
        return CGSize(width: width, height: width)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
         let filename: NSString = policyDocsArr[indexPath.row] as! NSString
         let pathExtention = filename.pathExtension
         
        if pathExtention == "pdf" || pathExtention == "docx" || pathExtention == "doc"{
            
            let vc = ViewAttachmentsVC.instantiate(fromAppStoryboard: .home)
            let info = policyDocsArr[indexPath.row] as! String
            vc.attachmentStr = info
            self.presentVC(vc, animated: true, presentationStyle: .pageSheet)

//             if let url = URL(string:policyDocsArr[indexPath.row] as! String) {
//                 UIApplication.shared.open(url)
//             }
         }else{
             let vc = ViewImageVC.instantiate(fromAppStoryboard: .proposalStoryboard)
             vc.image = policyDocsArr[indexPath.row] as! String
             vc.modalTransitionStyle = .crossDissolve
             vc.modalPresentationStyle = .overFullScreen
             self.present(vc, animated: true)
         }
    }
}
