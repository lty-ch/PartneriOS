import Foundation


protocol SetHeathInsuranceData{
    func setData(data:LeadInsuranceModel)
    func showMessage(msg:String)
}

protocol SetTravelInsuranceData{
    func setData(data:TravelModel)
    func showMessage(msg:String)
}

protocol SetBuildingInsuranceData{
    func setData(data:BuildingModel)
    func showMessage(msg:String)
}

protocol SetBuildingLegalProtectionData{
    func setData(data:BusinessLegalProModel)
    func showMessage(msg:String)
}

protocol SetCompanyThingsInsuranceData{
    func setData(data:CompanyThingsModel)
    func showMessage(msg:String)
}

protocol SetThirdPillarProtectionData{
    func setData(data:ThirdPillarModel)
    func showMessage(msg:String)
}
protocol SetAnimalProtectionData{
    func setData(data:AnimalModel)
    func showMessage(msg:String)
}
protocol HomeHoldRCProtectionData{
    func setData(data:HouseHoldRCModel)
    func showMessage(msg:String)
}
protocol HsousingRentalProtectionData{
    func setData(data:HousingRentalModel)
    func showMessage(msg:String)
}
protocol QuatationProtocolDelegate{
    func setData(data:QuatationModel)
    func showMessage(msg:String)
}
protocol LegalProtectionProtocolData{
    func setData(data:LegalProtectionModel)
    func showMessage(msg:String)
}
protocol MotorVehicleProtocolData{
    func setData(data:MotorVehicleModel)
    func showMessage(msg:String)
}

protocol ConstructionProtocolData{
    func setData(data:ConstructionModel)
    func showMessage(msg:String)
}

class LeadInsuranceViewModel {
    
    var delegate :SetHeathInsuranceData?
    var travelDelegate :SetTravelInsuranceData?
    var buildingDelegate :SetBuildingInsuranceData?
    var buildingLegalProtectionDelgate :SetBuildingLegalProtectionData?
    var thirdPillarDelgate :SetThirdPillarProtectionData?
    var companyThingsDelegate :SetCompanyThingsInsuranceData?
    var animalDelegate :SetAnimalProtectionData?
    var homeHoldRCDelegate :HomeHoldRCProtectionData?
    var houseRentalDelegate :HsousingRentalProtectionData?
    var quatationlDelegate :QuatationProtocolDelegate?
    var legalProtectionlDelegate :LegalProtectionProtocolData?
    var motorVehicleDelegate :MotorVehicleProtocolData?
    var constructionDelegate :ConstructionProtocolData?
    
    
    func HeathInsuranceApiCall(param:[String:Any]){
        SwiftLoader.show(animated: true)
        
        Services.shareInstance.postRequestApi(url: LTY_BASE_URL.BASE_URL_INSURANCE + LTY_END_POINT_URL.viewLeadDetail, method: "POST", passToken: true, expecting:LeadInsuranceModel.self, dataDict: param) { response
            
            in
            
            switch response {
                
            case .success(let result):
                SwiftLoader.hide()
                
                self.delegate?.setData(data: result)

            case .failure(let error):
                SwiftLoader.hide()
                self.delegate?.showMessage(msg: error.localizedDescription)
                
            }
            
        }
        
    }
    
    func TravelInsuranceApiCall(param:[String:Any]){
        SwiftLoader.show(animated: true)
        
        Services.shareInstance.postRequestApi(url: LTY_BASE_URL.BASE_URL_INSURANCE + LTY_END_POINT_URL.viewLeadDetail, method: "POST", passToken: true, expecting:TravelModel.self, dataDict: param) { response
            
            in
            
            switch response {
                
            case .success(let result):
                SwiftLoader.hide()
                
                self.travelDelegate?.setData(data: result)

            case .failure(let error):
                SwiftLoader.hide()
                self.travelDelegate?.showMessage(msg: error.localizedDescription)
                
            }
            
        }
        
    }
    
    func BuildingInsuranceApiCall(param:[String:Any]){
        SwiftLoader.show(animated: true)
        
        Services.shareInstance.postRequestApi(url: LTY_BASE_URL.BASE_URL_INSURANCE + LTY_END_POINT_URL.viewLeadDetail, method: "POST", passToken: true, expecting:BuildingModel.self, dataDict: param) { response
            
            in
            
            switch response {
                
            case .success(let result):
                SwiftLoader.hide()
                
                self.buildingDelegate?.setData(data: result)

            case .failure(let error):
                SwiftLoader.hide()
                self.buildingDelegate?.showMessage(msg: error.localizedDescription)
                
            }
            
        }
        
    }
    
    func leagalBusinessProtectionApiCall(param:[String:Any]){
        SwiftLoader.show(animated: true)
        
        Services.shareInstance.postRequestApi(url: LTY_BASE_URL.BASE_URL_INSURANCE + LTY_END_POINT_URL.viewLeadDetail, method: "POST", passToken: true, expecting:BusinessLegalProModel.self, dataDict: param) { response
            
            in
            
            switch response {
                
            case .success(let result):
                SwiftLoader.hide()
                
                self.buildingLegalProtectionDelgate?.setData(data: result)

            case .failure(let error):
                SwiftLoader.hide()
                self.buildingLegalProtectionDelgate?.showMessage(msg: error.localizedDescription)
                
            }
            
        }
        
    }
    
    func thirdPillarApiCall(param:[String:Any]){
        SwiftLoader.show(animated: true)
        
        Services.shareInstance.postRequestApi(url: LTY_BASE_URL.BASE_URL_INSURANCE + LTY_END_POINT_URL.viewLeadDetail, method: "POST", passToken: true, expecting:ThirdPillarModel.self, dataDict: param) { response
            
            in
            
            switch response {
                
            case .success(let result):
                SwiftLoader.hide()
                
                self.thirdPillarDelgate?.setData(data: result)

            case .failure(let error):
                SwiftLoader.hide()
                self.thirdPillarDelgate?.showMessage(msg: error.localizedDescription)
                
            }
            
        }
        
    }
    
    func CompanyThingsInsuranceApiCall(param:[String:Any]){
        SwiftLoader.show(animated: true)
        
        Services.shareInstance.postRequestApi(url: LTY_BASE_URL.BASE_URL_INSURANCE + LTY_END_POINT_URL.viewLeadDetail, method: "POST", passToken: true, expecting:CompanyThingsModel.self, dataDict: param) { response
            
            in
            
            switch response {
                
            case .success(let result):
                SwiftLoader.hide()
                
                self.companyThingsDelegate?.setData(data: result)

            case .failure(let error):
                SwiftLoader.hide()
                self.companyThingsDelegate?.showMessage(msg: error.localizedDescription)
                
            }
            
        }
        
    }
    
    func AnimalInsuranceApiCall(param:[String:Any]){
        SwiftLoader.show(animated: true)
        
        Services.shareInstance.postRequestApi(url: LTY_BASE_URL.BASE_URL_INSURANCE + LTY_END_POINT_URL.viewLeadDetail, method: "POST", passToken: true, expecting:AnimalModel.self, dataDict: param) { response
            
            in
            
            switch response {
                
            case .success(let result):
                SwiftLoader.hide()
                
                self.animalDelegate?.setData(data: result)

            case .failure(let error):
                SwiftLoader.hide()
                self.animalDelegate?.showMessage(msg: error.localizedDescription)
                
            }
            
        }
        
    }
    
    func HouseHoldRCApiCall(param:[String:Any]){
        SwiftLoader.show(animated: true)
        
        Services.shareInstance.postRequestApi(url: LTY_BASE_URL.BASE_URL_INSURANCE + LTY_END_POINT_URL.viewLeadDetail, method: "POST", passToken: true, expecting:HouseHoldRCModel.self, dataDict: param) { response
            
            in
            
            switch response {
                
            case .success(let result):
                SwiftLoader.hide()
                
                self.homeHoldRCDelegate?.setData(data: result)

            case .failure(let error):
                SwiftLoader.hide()
                self.homeHoldRCDelegate?.showMessage(msg: error.localizedDescription)
                
            }
            
        }
        
    }
    
    func HousingRentalApiCall(param:[String:Any]){
        SwiftLoader.show(animated: true)
        
        Services.shareInstance.postRequestApi(url: LTY_BASE_URL.BASE_URL_INSURANCE + LTY_END_POINT_URL.viewLeadDetail, method: "POST", passToken: true, expecting:HousingRentalModel.self, dataDict: param) { response
            
            in
            
            switch response {
                
            case .success(let result):
                SwiftLoader.hide()
                
                self.houseRentalDelegate?.setData(data: result)

            case .failure(let error):
                SwiftLoader.hide()
                self.houseRentalDelegate?.showMessage(msg: error.localizedDescription)
                
            }
            
        }
        
    }
    
    func QuatationApiCall(param:[String:Any]){
        SwiftLoader.show(animated: true)
        
        Services.shareInstance.postRequestApi(url: LTY_BASE_URL.BASE_URL_INSURANCE + LTY_END_POINT_URL.viewLeadDetail, method: "POST", passToken: true, expecting:QuatationModel.self, dataDict: param) { response
            
            in
            
            switch response {
                
            case .success(let result):
                SwiftLoader.hide()
                
                self.quatationlDelegate?.setData(data: result)

            case .failure(let error):
                SwiftLoader.hide()
                self.quatationlDelegate?.showMessage(msg: error.localizedDescription)
                
            }
            
        }
        
    }
    
    func LegalProtectionApiCall(param:[String:Any]){
        SwiftLoader.show(animated: true)
        
        Services.shareInstance.postRequestApi(url: LTY_BASE_URL.BASE_URL_INSURANCE + LTY_END_POINT_URL.viewLeadDetail, method: "POST", passToken: true, expecting:LegalProtectionModel.self, dataDict: param) { response
            
            in
            
            switch response {
                
            case .success(let result):
                SwiftLoader.hide()
                
                self.legalProtectionlDelegate?.setData(data: result)

            case .failure(let error):
                SwiftLoader.hide()
                self.houseRentalDelegate?.showMessage(msg: error.localizedDescription)
                
            }
            
        }
        
    }
    
    func MotorVehicleApiCall(param:[String:Any]){
        SwiftLoader.show(animated: true)
        
        Services.shareInstance.postRequestApi(url: LTY_BASE_URL.BASE_URL_INSURANCE + LTY_END_POINT_URL.viewLeadDetail, method: "POST", passToken: true, expecting:MotorVehicleModel.self, dataDict: param) { response
            
            in
            
            switch response {
                
            case .success(let result):
                SwiftLoader.hide()
                
                self.motorVehicleDelegate?.setData(data: result)

            case .failure(let error):
                SwiftLoader.hide()
                self.houseRentalDelegate?.showMessage(msg: error.localizedDescription)
                
            }
            
        }
        
    }
    
    func constructionApiCall(param:[String:Any]){
        SwiftLoader.show(animated: true)
        
        Services.shareInstance.postRequestApi(url: LTY_BASE_URL.BASE_URL_INSURANCE + LTY_END_POINT_URL.viewLeadDetail, method: "POST", passToken: true, expecting:ConstructionModel.self, dataDict: param) { response
            
            in
            
            switch response {
                
            case .success(let result):
                SwiftLoader.hide()
                
                self.constructionDelegate?.setData(data: result)

            case .failure(let error):
                SwiftLoader.hide()
                self.constructionDelegate?.showMessage(msg: error.localizedDescription)
                
            }
            
        }
        
    }
}

