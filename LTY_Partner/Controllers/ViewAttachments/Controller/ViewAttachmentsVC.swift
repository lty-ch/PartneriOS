//
//  ViewAttachmentsVC.swift
//  LTY_Partner
//
//  Created by ChawTech Solutions on 01/06/23.
//

import UIKit
import WebKit

class ViewAttachmentsVC: UIViewController, WKUIDelegate {

    @IBOutlet weak var myWebView: WKWebView!
    @IBOutlet weak var vieww: UIView!
    
    @IBOutlet weak var btnDawnload: UIButton!
    var attachmentStr = ""
    var dawnloadStringUrl = ""
    var showImageViewModel = ShowImageViewModel()

    var webView: WKWebView!
    
    @IBOutlet weak var customNavDrower: CustomNavigationBarForDrawer!
    @IBOutlet weak var customNavHeight: NSLayoutConstraint!
    
    /*
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .init(x: 20, y: 70, width: 335, height: 400), configuration: webConfiguration)
        myWebView.uiDelegate = self
        self.vieww = webView
    }
    */
    override func viewDidLoad() {
        super.viewDidLoad()

        self.btnDawnload.layer.cornerRadius = 5
        self.btnDawnload.setTitle("Dawnload".localized(), for: .normal)
        
        setDrowerHeight()
        customNavDrower.titleLabel.text = "".localized()
        customNavDrower.titleLabel.textAlignment = .center
        customNavDrower.leftSideMenuButtonItem.setImage(Asset.Assets.backArrow.image, for: .normal)
        customNavDrower.leftSideMenuButtonItem.addTarget(self, action: #selector(backActionBtn(_:)), for: .touchUpInside)
//        myWebView.uiDelegate = self
       // self.dsa()
    }
    
    //MARK:- backAction Btn
    
    @objc func backActionBtn(_ sender: UIButton) {
        self.dismiss(animated: true)
        
    }
    
    //MARK:- set navigationDrower Height
    
    func setDrowerHeight() {
        if UIDevice.current.hasNotch {
            customNavHeight.constant = DroverHeight.haveNotch
        } else {
            customNavHeight.constant = DroverHeight.dontHaveNotch
            
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        myWebView.uiDelegate = self
        showImageViewModel.delegate = self

        let param : [String:Any] = ["key":attachmentStr ]
        showImageViewModel.ViewImageApi(param: param)
    }
    
    
    @IBAction func btnDawnloadaction(_ sender: UIButton) {
        
       // let myHTTPUrl = self.attachmentStr
        let myHTTPUrl = self.dawnloadStringUrl
      //  let x = myHTTPUrl.components(separatedBy: "?")[0]
        //let myHTTPUrl = "https://lty-platform.s3.eu-central-2.amazonaws.com/dev/document-store/98204d8d-b122-479f-9de3-c792e9c47900.pdf"
        //savefile(urlString: myHTTPUrl,viewController: self)
        let url = URL(string: myHTTPUrl)
        FileDownloader.loadFileAsync(url: url!) { (path, error) in
            print("PDF File downloaded to : \(path!)")
            DispatchQueue.main.async {
                self.showOkAlert("File downloaded successfully.")
            }
         
        }
        
    }
    
    public func dsa(_ url:String) {

        
        let myURL = URL(string:url)
        let myRequest = URLRequest(url: myURL!)

        myWebView.load(myRequest)
        
    }
    
   
}

extension ViewAttachmentsVC : ShowImageViewProtocolDelegate{
    func showImage(data: ShowImageModel) {
        print(data)
        DispatchQueue.main.async {

            self.dawnloadStringUrl = data.data?.preSignedUrl ?? ""
            self.dsa(data.data?.preSignedUrl ?? "")
        }
       
    
    
    }
    
    func popupMsg(msg: String) {
        DispatchQueue.main.async {
            self.ShowAlert(message: msg)
        }
    }
    
    
}
extension ViewAttachmentsVC {
    
    func getCurrentMillis()->Int64 {
        return Int64(Date().timeIntervalSince1970 * 1000)
    }

    //MARK: Method to save document file
    func savefile(urlString: String,viewController:UIViewController) {
        SwiftLoader.show(animated: true)
        let currentTime = getCurrentMillis()
        let urlStrin = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = URL(string: urlStrin!)
        let fileName = String((url!.lastPathComponent)) as NSString
        let encodec_fileName = fileName.replacingOccurrences(of: " ", with: "")
        // Create destination URL
        let documentsUrl:URL =  (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first as URL?)!
        let destinationFileUrl = documentsUrl.appendingPathComponent("\(currentTime) \(encodec_fileName)")
        //Create URL to the source file you want to download
        let fileURL = URL(string: urlStrin!)
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        let request = URLRequest(url:fileURL!)
        let task = session.downloadTask(with: request) { (tempLocalUrl, response, error) in
            if let tempLocalUrl = tempLocalUrl, error == nil {
                // Success
                DispatchQueue.main.async {
                    SwiftLoader.hide()
                }

                if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                    print("downloaded failed. Status code: \(statusCode)")
                    if statusCode == 200 {
                        DispatchQueue.main.async {
                            self.showOkAlert("File downloaded successfully.")
                        }
                    }
                    
                }

                do {
                    try FileManager.default.copyItem(at: tempLocalUrl, to: destinationFileUrl)
                    do {
                        //Show UIActivityViewController to save the downloaded file
    //                        let contents  = try FileManager.default.contentsOfDirectory(at: documentsUrl, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
    //                        for indexx in 0..<contents.count {
    //                            if contents[indexx].lastPathComponent == destinationFileUrl.lastPathComponent {
    //                                DispatchQueue.main.async {
    //
    //
    //                                    let activityViewController = UIActivityViewController(activityItems: [contents[indexx]], applicationActivities: nil)
    //                                    viewController.present(activityViewController, animated: true, completion: nil)
    //                                }
    //                            }
    //                        }

                    }
                    catch (let err) {
                        print("error: \(err)")
                        SwiftLoader.hide()
                        self.showOkAlert(err.localizedDescription)
    //                        UIAlertController.showInfoAlertWithTitle("Alert", message: err.localizedDescription, buttonTitle: "Okay")
                       
                        // self.displayAlertMessage(messageToDisplay: err.localizedDescription)
                    }
                } catch (let writeError) {

                    SwiftLoader.hide()
                    print("Error creating a file \(destinationFileUrl) : \(writeError)")
                    //  self.displayAlertMessage(messageToDisplay: writeError.localizedDescription)

                }
            } else {
                SwiftLoader.hide()
                print("Error took place while downloading a file. Error description: \(error?.localizedDescription ?? "")")
            }
        }
        task.resume()
    }

}

class FileDownloader {

    static func loadFileSync(url: URL, completion: @escaping (String?, Error?) -> Void)
    {
        let documentsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!

        let destinationUrl = documentsUrl.appendingPathComponent(url.lastPathComponent)

        if FileManager().fileExists(atPath: destinationUrl.path)
        {
            
            print("File already exists [\(destinationUrl.path)]")
            completion(destinationUrl.path, nil)
        }
        else if let dataFromURL = NSData(contentsOf: url)
        {
            if dataFromURL.write(to: destinationUrl, atomically: true)
            {
                print("file saved [\(destinationUrl.path)]")
                completion(destinationUrl.path, nil)
            }
            else
            {
                print("error saving file")
                let error = NSError(domain:"Error saving file", code:1001, userInfo:nil)
                completion(destinationUrl.path, error)
            }
        }
        else
        {
            let error = NSError(domain:"Error downloading file", code:1002, userInfo:nil)
            completion(destinationUrl.path, error)
        }
    }

    static func loadFileAsync(url: URL, completion: @escaping (String?, Error?) -> Void)
    {
        let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!

        let destinationUrl = documentsUrl.appendingPathComponent(url.lastPathComponent)

        if FileManager().fileExists(atPath: destinationUrl.path)
        {
            print("File already exists [\(destinationUrl.path)]")
            completion(destinationUrl.path, nil)
        }
        else
        {
            let session = URLSession(configuration: URLSessionConfiguration.default, delegate: nil, delegateQueue: nil)
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            let task = session.dataTask(with: request, completionHandler:
            {
                data, response, error in
                if error == nil
                {
                    if let response = response as? HTTPURLResponse
                    {
                        if response.statusCode == 200
                        {
                            if let data = data
                            {
                                if let _ = try? data.write(to: destinationUrl, options: Data.WritingOptions.atomic)
                                {
                                    completion(destinationUrl.path, error)
                                }
                                else
                                {
                                    completion(destinationUrl.path, error)
                                }
                            }
                            else
                            {
                                completion(destinationUrl.path, error)
                            }
                        }
                    }
                }
                else
                {
                    completion(destinationUrl.path, error)
                }
            })
            task.resume()
        }
    }
}
