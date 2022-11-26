//
//  SearchHistoryViewModel.swift
//  AppWithExtension
//
//  Created by Егор Чирков on 25.11.2022.
//

import Foundation

struct SearchQueryItem: Identifiable{
    let id = UUID()
    let query: String
}

class SearchHistoryViewModel: ObservableObject{
    
    @Published var searchQueries: [SearchQueryItem] = [SearchQueryItem]()
    
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
            searchQueries.append(SearchQueryItem(query: query))
        }
    }
}
