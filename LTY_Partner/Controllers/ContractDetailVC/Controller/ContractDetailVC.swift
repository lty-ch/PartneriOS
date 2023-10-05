//
//  ContractDetailVC.swift
//  LTY_Partner
//
//  Created by shashivendra sengar on 19/06/23.
//

import UIKit

class ContractDetailVC: UIViewController, URLSessionDownloadDelegate {
    
    @IBOutlet weak var lblTotalAmount: UILabel!
    @IBOutlet weak var lblSubCatName: UILabel!
    @IBOutlet weak var lblCatName: UILabel!
    @IBOutlet weak var docTableHeight: NSLayoutConstraint!
    @IBOutlet weak var docTableView: UITableView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEndDate: UILabel!
    @IBOutlet weak var lblStartDate: UILabel!
    @IBOutlet weak var lblSumAssured: UILabel!
    @IBOutlet weak var lblTotalDuration: UILabel!
    @IBOutlet weak var lblPersonCovered: UILabel!
    @IBOutlet weak var lblBenifits: UILabel!
    @IBOutlet weak var lblPremiumTerm: UILabel!
    @IBOutlet weak var lblPeriodicity: UILabel!
    @IBOutlet weak var lblAgentEmail: UILabel!
    @IBOutlet weak var lblAgentName: UILabel!
    @IBOutlet weak var lblPolicyNumber: UILabel!
    @IBOutlet weak var lblPolicyName: UILabel!
    
    @IBOutlet weak var customNavHeight: NSLayoutConstraint!
    @IBOutlet weak var customNavDrower: CustomNavigationBarForDrawer!
    
    var contractDictArr = [ContractDetailModel]()
    var downloadStr = [String]()
    var fileURL : URL!
//    let fileURL = URL(string: "http://example.com/example.pdf")! // URL of the file to download
    var downloadTask: URLSessionDownloadTask!
    var downloadTasks: [URLSessionDownloadTask] = []
    var backgroundSession: URLSession!
//    var progressView: UIProgressView!
//    var loaderView: UIActivityIndicatorView!
    
  //  fileprivate var downloadManager = DownloadManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setDrowerHeight()
        setData()
        customNavDrower.titleLabel.text = "Contract Detail".localized()
        customNavDrower.titleLabel.textAlignment = .center
        customNavDrower.leftSideMenuButtonItem.setImage(Asset.Assets.backArrow.image, for: .normal)
        customNavDrower.leftSideMenuButtonItem.addTarget(self, action: #selector(backActionBtn(_:)), for: .touchUpInside)
        
//        progressView = UIProgressView(progressViewStyle: .default)
//        progressView.frame = CGRect(x: 50, y: 100, width: 200, height: 20)
//        view.addSubview(progressView)
//
//        loaderView = UIActivityIndicatorView(style: .gray)
//        loaderView.center = view.center
//        view.addSubview(loaderView)
        
        let configuration = URLSessionConfiguration.background(withIdentifier: "com.example.backgroundSession")
        backgroundSession = URLSession(configuration: configuration, delegate: self, delegateQueue: OperationQueue.main)
        
        docTableView.delegate = self
        docTableView.dataSource = self
        docTableView.separatorStyle = .none
  
        docTableView.register(UINib(nibName: "ContractDocCell", bundle: .main), forCellReuseIdentifier: "ContractDocCell")
        docTableView.estimatedRowHeight = 44
        self.docTableView.rowHeight = UITableView.automaticDimension
        self.docTableView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        docTableHeight.constant = docTableView.contentSize.height
        
        
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
            if(keyPath == "contentSize"){
                if let newvalue = change?[.newKey]
                {
                    let newsize = newvalue as! CGSize
                    docTableHeight.constant = newsize.height
                    //docViewHeight.constant = 125 + newsize.height
                }
            }
    }
    
    
    
    //MARK:- func set Data
    
    func setData () {
        for item in contractDictArr{
            
            var startDate = item.startDate
            startDate = startDate?.components(separatedBy: "T")[0]
            var endDate = item.endDate
            endDate = endDate?.components(separatedBy: "T")[0]
            self.lblName.text = item.name
            self.lblEndDate.text = returnDOB(date: endDate ?? "")//endDate
            self.lblStartDate.text = returnDOB(date: startDate ?? "")//startDate
            self.lblAgentEmail.text = item.email
            self.lblTotalAmount.text = "\(item.totalAmount ?? 0)"
            self.lblCatName.text = item.category
            self.lblSubCatName.text = item.subCategory
            self.lblBenifits.text = item.benifits
            self.lblAgentName.text = item.agentName == "" ? "Unassigned".localized() : item.agentName
           // self.lblPolicyName.text = item.policyName
            self.lblSumAssured.text = item.sumAssured
            self.lblPremiumTerm.text = "\(String(describing: item.premiumTerm ?? 0))"
            self.lblPeriodicity.text = item.periodicity
            self.lblPolicyNumber.text = item.policyNumber
         //   self.lblTotalDuration.text = item.totalDuration
            self.lblPersonCovered.text = item.name//item.personCovered

           
            self.downloadStr = item.contractDoc ?? []
            if self.downloadStr.count > 0 {
               fileURL = URL(string: self.downloadStr[0])
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
    
    //MARK:- backAction Btn
    
    @objc func backActionBtn(_ sender: UIButton) {
        self.popVC(animated: true)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
        
    }
    
    func downloadFiles() {
        SwiftLoader.show(animated: true)
        for str in self.downloadStr {
            let fileUrll = URL(string: str)!
            let downloadTask = backgroundSession.downloadTask(with: fileUrll)
            downloadTask.resume()
            downloadTasks.append(downloadTask)
        }
    }
    
//    func downloadFile() {
//
//        SwiftLoader.show(animated: true)
////            loaderView.startAnimating()
//            downloadTask = backgroundSession.downloadTask(with: fileURL)
//            downloadTask.resume()
//        }
    
    @IBAction func dawnloadActionBtn(_ sender: UIButton) {
        if self.downloadStr.count > 0 {
//            downloadFile()
            downloadFiles()
//            let urlString = "https://lty-platform.s3.eu-central-2.amazonaws.com/dev/document-store/c8f93607-cf0f-4e6d-a59a-0621fed6ba70.png"
//            let url = URL(string: urlString)
//            let fileName = String((url!.lastPathComponent)) as NSString
//            // Create destination URL
//            let documentsUrl:URL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first as! URL
//            let destinationFileUrl = documentsUrl.appendingPathComponent("\(fileName)")
//            //Create URL to the source file you want to download
//            let fileURL = URL(string: urlString)
//            let sessionConfig = URLSessionConfiguration.default
//            let session = URLSession(configuration: sessionConfig)
//            let request = URLRequest(url:fileURL!)
//            let task = session.downloadTask(with: request) { (tempLocalUrl, response, error) in
//                if let tempLocalUrl = tempLocalUrl, error == nil {
//                    // Success
//                    if let statusCode = (response as? HTTPURLResponse)?.statusCode {
//                        print("Successfully downloaded. Status code: \(statusCode)")
//                    }
//                    do {
//                        try FileManager.default.copyItem(at: tempLocalUrl, to: destinationFileUrl)
//                        do {
//                            //Show UIActivityViewController to save the downloaded file
//                            let contents  = try FileManager.default.contentsOfDirectory(at: documentsUrl, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
//                            for indexx in 0..<contents.count {
//                                if contents[indexx].lastPathComponent == destinationFileUrl.lastPathComponent {
//                                    let activityViewController = UIActivityViewController(activityItems: [contents[indexx]], applicationActivities: nil)
//                                    DispatchQueue.main.async {
//                                        self.present(activityViewController, animated: true, completion: nil)
//                                    }
//
//                                }
//                            }
//                        }
//                        catch (let err) {
//                            print("error: \(err)")
//                        }
//                    } catch (let writeError) {
//                        print("Error creating a file \(destinationFileUrl) : \(writeError)")
//                    }
//                } else {
//                    print("Error took place while downloading a file. Error description: \(error?.localizedDescription ?? "")")
//                }
//            }
//            task.resume()

        } else {
            self.ShowAlert(message: "No doc to download".localized())
        }
        
        
    }
    
//    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
//        // File download finished, handle the downloaded file here
//        // The downloaded file is located at the temporary location 'location'
//
//        // Example: Move the file to the Documents directory
//        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
//        let destinationURL = documentsURL.appendingPathComponent(fileURL.lastPathComponent)
//
//        try? FileManager.default.removeItem(at: destinationURL)
//
//
//        do {
//            try FileManager.default.moveItem(at: location, to: destinationURL)
//            print("File downloaded successfully at \(destinationURL.absoluteString)")
//        } catch {
//            print("Error moving file: \(error)")
//        }
//
//        if let index = downloadTask.firstIndex(of: downloadTas) {
//            downloadTask.remove(at: index)
//        }
//
//        if downloadTask.isEmpty {
//            // All files downloaded, stop the loader
//            SwiftLoader.hide()
//        }
//
//    }
//
//        func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
//            // Calculate the download progress and update the progress view
//            let progress = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
////            progressView.progress = progress
//        }
//
//        func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
//            // File download completed or failed, stop the loader
////            loaderView.stopAnimating()
//            SwiftLoader.hide()
//        }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
            // File download finished, handle the downloaded file here
            // The downloaded file is located at the temporary location 'location'

            // Example: Move the file to the Documents directory
            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let destinationURL = documentsURL.appendingPathComponent(downloadTask.originalRequest?.url?.lastPathComponent ?? "")

            do {
                try FileManager.default.moveItem(at: location, to: destinationURL)
                DispatchQueue.main.async {
                    self.ShowAlert(message: "File downloaded successfully")
                }
                
                print("File downloaded successfully at \(destinationURL.absoluteString)")
            } catch {
                DispatchQueue.main.async {
                    self.ShowAlert(message: "Error moving file: \(error)")
                }
                print("Error moving file: \(error)")
            }

            if let index = downloadTasks.firstIndex(of: downloadTask) {
                downloadTasks.remove(at: index)
            }

            if downloadTasks.isEmpty {
                // All files downloaded, stop the loader
                SwiftLoader.hide()
            }
        }

        func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
            // Calculate the download progress and update the progress view
//            let progress = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
//            progressView.progress = progress
        }

        func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
            if let downloadTask = task as? URLSessionDownloadTask {
                if let index = downloadTasks.firstIndex(of: downloadTask) {
                    downloadTasks.remove(at: index)
                }

                if downloadTasks.isEmpty {
                    // All files downloaded or an error occurred, stop the loader
                    SwiftLoader.hide()
                }
            }
        }
    

    
    @objc func downloadAction(_ sender: UIButton) {
        
        let myHTTPUrl = self.downloadStr[sender.tag]
        savefile(urlString: myHTTPUrl,viewController: self)

    }
    
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
                    print("Successfully downloaded. Status code: \(statusCode)")
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

extension ContractDetailVC : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.downloadStr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = docTableView.dequeueReusableCell(withIdentifier: "ContractDocCell", for: indexPath) as! ContractDocCell
        cell.selectionStyle = .none
        cell.cellLbl.text = (self.downloadStr[indexPath.row] as! String)
//        let data = self.downloadStr[indexPath.row]
//        if let lastSlashIndex = data.lastIndex(of: "/") {
//            let fileName = String(data[data.index(after: lastSlashIndex)...])
//            cell.cellLbl.text = fileName          //            print("File Name: \(fileName)")
//        } else {
//            print("Invalid URL format")
//        }
        
       // cell.cellLbl.text = self.downloadStr[indexPath.row]
        
        
        cell.cellViewBtn.tag = indexPath.row
        cell.cellViewBtn.addTarget(self, action: #selector(viewAction(_:)), for: .touchUpInside)
        cell.cellDownloadBtn.tag = indexPath.row
        cell.cellDownloadBtn.addTarget(self, action: #selector(downloadAction(_:)), for: .touchUpInside)
        
        return cell
    }
    
    @objc func viewAction(_ sender: UIButton) {
        let filename: NSString = downloadStr[sender.tag] as! NSString
        let pathExtention = filename.pathExtension
        
        if pathExtention == "pdf" || pathExtention == "docx" || pathExtention == "doc"{
            
            let vc = ViewAttachmentsVC.instantiate(fromAppStoryboard: .home)
            let info = downloadStr[sender.tag]  as! String
            vc.attachmentStr = info
            self.presentVC(vc, animated: true, presentationStyle: .pageSheet)
            
//            if let url = URL(string:downloadStr[sender.tag] as! String) {
//                UIApplication.shared.open(url)
//            }
        }else{
            let vc = ViewImageVC.instantiate(fromAppStoryboard: .proposalStoryboard)
            vc.image = downloadStr[sender.tag] as! String
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true)
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
  
}


