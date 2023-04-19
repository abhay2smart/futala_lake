//
//  MasterConfigViewModel.swift
//  FutalaLake
//
//  Created by Abhayjeet Singh on 19/04/23.
//

import Foundation
class MasterConfigViewModel: ObservableObject {
    private var dataKey = "MasterConfigViewModel"
    @Published var isLoading: Bool = false
    func fetchMasterConfigData() {
        isLoading = true
        let url = Constants.baseUrl + Constants.API.masterConfig
        
        
        APIService.shared.makeApiTypeRequest2(url: url, param: nil, methodType: .get, expecting: GlobResponseModel.self) { resultStatus, error, data  in
            
            DispatchQueue.main.async {
                self.isLoading = false
            }
            
            if !resultStatus {
                print("something went wrong:: SeatLayoutViewModel \(#line)")
                return
            }
            
            
            guard let data = data else {
                return
            }
            
            
            APIService.shared.parseModel(data: data, expecting: MasterConfigModel.self) { result, data in
                switch result {
                case .success(let respData):
                    print("success rawan")
                    if let data = respData.data{
                        self.preserveMasterData(data: data)
                    }
                    
                case .failure(let error):
                    print("Something went wrong \(self) @ \(#line)")
                }
            }
            
        }
        
    }
    
    
    func preserveMasterData(data: [MasterConfigData]) {
        UserDefaults.standard.setCodableObject(data, forKey: self.dataKey)
    }
    
    func getPreservedMasterData()->[MasterConfigData]? {
        if let retrievedCodableObject = UserDefaults.standard.codableObject(dataType: [MasterConfigData].self, key: self.dataKey) {
            return retrievedCodableObject
        }
        return nil
    }
}
