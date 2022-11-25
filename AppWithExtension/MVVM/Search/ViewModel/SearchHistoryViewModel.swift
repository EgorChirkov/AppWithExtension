//
//  SearchHistoryViewModel.swift
//  AppWithExtension
//
//  Created by Егор Чирков on 25.11.2022.
//

import Foundation

class SearchHistoryViewModel: ObservableObject{
    
    @Published var searchQueries: [String] = [String]()
    
    private var globalAppData: GlobalAppData? = nil
    
    func onAppear(for globalAppData: GlobalAppData){
        self.globalAppData = globalAppData
        
        fetchQueries()
    }
    
    private func fetchQueries(){
        guard let globalAppData = globalAppData else{
            return
        }
        
        searchQueries.removeAll()
        
        let queries = globalAppData.searchHistory
        
        for query in queries {
            searchQueries.append(query)
        }
    }
}
