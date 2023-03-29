//
//  HistoryViewModel.swift
//  FutalaLake
//
//  Created by Abhayjeet Singh on 27/03/23.
//

import Foundation

class HistoryViewModel: ObservableObject {
    @Published var historyData:[HistoryData] = [HistoryData]()
    @Published var isLoading:Bool = false
    
    func fetchHistory() {
        isLoading = true
        let url = Constants.baseUrl + Constants.API.userHistory
                
                APIService.shared.makeApiTypeRequest2(url: url, param: nil, methodType: .get, expecting: GlobResponseModel.self) { resultStatus, error, data  in
                    
                    DispatchQueue.main.async {
                        self.isLoading = false
                    }
                    
                    if !resultStatus {
                        print("something went wrong:: HistoryModel \(#line)")
                        return
                    }
                    
                    
                    guard let data = data else {
                        return
                    }
                    
                    
                    APIService.shared.parseModel(data: data, expecting: HistoryModel.self) { result, data in
                        
                        switch result {
                            case .success(let respData):
                            if let dataArr = respData.data {
                                DispatchQueue.main.async {
                                    self.historyData = dataArr
                                    print("parsed342\(dataArr.count)")
                                }
                                
                            }
                            
                            case .failure(let error):
                                print("Something went wrong DateTimeSelectionViewModel@\(#line)")
                        }
                    }
                    
                    
                }

    }
}
