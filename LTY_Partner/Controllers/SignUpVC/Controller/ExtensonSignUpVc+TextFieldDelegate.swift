//
//  ExtensonSignUpVc+TextFieldDelegate.swift
//  LTY_Partner
//
//  Created by CTS on 25/05/23.
//

import Foundation
import UIKit
import MobileCoreServices
import UniformTypeIdentifiers

extension SignUpVC : UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        if textField == textDob {
            
            showDatePicker()
            return true
        }
        
        return true
        
    }
    
}
extension SignUpVC : UINavigationControllerDelegate, UIDocumentMenuDelegate, UIDocumentPickerDelegate, UIImagePickerControllerDelegate {
    
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
    
    func clickFunction() {
        
        let types: [String] = ["com.apple.iwork.pages.pages", "com.apple.iwork.numbers.numbers", "com.apple.iwork.keynote.key","public.image", "com.apple.application", "public.item", "public.content", "public.audiovisual-content", "public.movie", "public.audiovisual-content", "public.video", "public.audio", "public.text", "public.data", "public.zip-archive", "com.pkware.zip-archive", "public.composite-content"]
        let documentPicker = UIDocumentPickerViewController(documentTypes: types, in: .import)
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false
        documentPicker.modalPresentationStyle = .formSheet
        present(documentPicker, animated: true, completion: nil)
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
                self.requestNativeImageUpload(tf: self.selectedTf, docName: filename)
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
        
        if selectedTf == nil {
            
           // self.profileImageUpload(docName: pickedImageUrl?.lastPathComponent ?? "")
        } else {
            self.requestNativeImageUpload(tf: self.selectedTf, docName: pickedImageUrl?.lastPathComponent ?? "")
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        //        UIApplication.topViewController()?.dismiss(animated: true, completion: nil)
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func requestNativeImageUpload(tf: UITextField, docName: String){
        SwiftLoader.show(animated: true)
        let fullUrl =  LTY_BASE_URL.DOCUMENT_UPLOAD_URL
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
                DispatchQueue.main.async {
                    tf.text = url
                }
                
            } else {
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

