//
//  Extension+WorkChatDetailVC.swift
//  LTY_Partner
//
//  Created by shashivendra sengar on 08/07/23.
//

import UIKit
import Foundation
import MobileCoreServices
import UniformTypeIdentifiers


extension WorkChatDetailChatVC : UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIDocumentPickerDelegate {
    
    func chooseMediaSelection() {
        let optionMenu = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: .default, handler:
                                            {
            (alert: UIAlertAction!) -> Void in
            self.openCamera()
        })
        let libraryAction = UIAlertAction(title: "Photo Library", style: .default, handler:
                                            {
            (alert: UIAlertAction!) -> Void in
            self.openGallery()
        })
        
        let pdfAction = UIAlertAction(title: "Choose Pdf", style: .default, handler:
                                            {
            (alert: UIAlertAction!) -> Void in
            self.capturePhotoFromDocs()
            
        })
        
    
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler:
                                            {
            (alert: UIAlertAction!) -> Void in
        })
        optionMenu.addAction(cameraAction)
        optionMenu.addAction(libraryAction)
        optionMenu.addAction(pdfAction)
        optionMenu.addAction(cancelAction)
        self.present(optionMenu, animated: true, completion: nil)
    }
   
     
    //MARK:- Opening camera
    
    func openCamera(){
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera){
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
        else{
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    //MARK:- Opening Gallery
    
    func openGallery() {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            imagePicker.delegate = self
            imagePicker.sourceType =   .photoLibrary//.savedPhotosAlbum

            imagePicker.allowsEditing = false
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    //MARK:- imagePickerController delegate methods
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info:  [UIImagePickerController.InfoKey : Any]) {
        
        if let pickedImage = info[.originalImage] as? UIImage {

            // Step 1: Convert the picked image to data
            guard let imageData = pickedImage.jpegData(compressionQuality: 0.8) else {
                print("Failed to convert image to data.")
                return
            }

            deleteDirectory(name: "temp.jpeg")
            let pickedImageUrl = getImageUrl()


            // self.profileimg.image = pickedImage
            let imgUrlStr = String(describing: pickedImageUrl!)
            print("\(imgUrlStr)")


            saveImageDocumentDirectory(usedImage: pickedImage)
            //UPDATEprofile(imagepath : pickedImage, isType: "image", docurl: "")
            // update profile from firebase

           // guard let fromId = Auth.auth().currentUser?.uid else { return }
            let fromId = kUserDefaults.value(forKey: AppKeys.partnerID)  as? String

            let toId = self.senderId
            if toId == ""
            {
                return
            }
            let timestamp = Int(Date().timeIntervalSince1970*1000)
            let isRead = false
            let type = "image"
           // self.sendNotification(message: sendMsgTxtView.text!, image: "")
            
            let request = Message1(message: "\(pickedImage)", senderId: fromId, receiverId: toId, timestamp: "\(timestamp)", type: type, isSeen: isRead)


          uploadImageURLToFirebase(request: request, imageURL: imageData, onSuccess: { (result) in
                print(result)
            })
          
        }
        imagePicker.dismiss(animated: true, completion: nil)

    }
  
// MARK:- open document directory
    
    func capturePhotoFromDocs(){
        
        let types: [String] = ["com.apple.iwork.pages.pages", "com.apple.iwork.numbers.numbers", "com.apple.iwork.keynote.key","public.image", "com.apple.application", "public.item", "public.content", "public.audiovisual-content", "public.movie", "public.audiovisual-content", "public.video", "public.audio", "public.text", "public.data", "public.zip-archive", "com.pkware.zip-archive", "public.composite-content"]
        let documentPicker = UIDocumentPickerViewController(documentTypes: types, in: .import)
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false
        documentPicker.modalPresentationStyle = .formSheet
        present(documentPicker, animated: true, completion: nil)
    }
    
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        
        guard let selectedFileURL = urls.first else {
            self.ShowAlert(message: "please select document")
            return
        }
        
        
        do {
            let pdfData = try Data(contentsOf: selectedFileURL)
            //let model = Document(url:nil, type:.pdf, image: nil , pdf:selectedFileURL)
            // documents.append(model)
            
            let fileNameWithExt = selectedFileURL.lastPathComponent
            let docSizeMB: Int = Int(Double(pdfData.count) / 1024.0 / 1024.0)
            
            
            if docSizeMB > 5 {
                self.ShowAlert(message: "File size must be less then or equal to 5 mb")
            }else{
                // add code here
                
                // guard let fromId = Auth.auth().currentUser?.uid else { return }
                let fromId = kUserDefaults.value(forKey: AppKeys.partnerID)  as? String
                
                let toId = self.senderId
                if toId == ""
                {
                return
                }
                let timestamp = Int(Date().timeIntervalSince1970*1000)
                let isRead = false
                let type = "document"
                // self.sendNotification(message: sendMsgTxtView.text!, image: "")
                
                let request = Message1(message: "\(selectedFileURL)", senderId: fromId, receiverId: toId, timestamp: "\(timestamp)", type: type, isSeen: isRead)
                
                uploadDocumentToFirebase(request: request,docUrl:pdfData, onSuccess: { (result) in
                print(result)
                })
            }
            
            
            
        }catch(let error){
            self.ShowAlert(message: error.localizedDescription)
        }

    }
}
