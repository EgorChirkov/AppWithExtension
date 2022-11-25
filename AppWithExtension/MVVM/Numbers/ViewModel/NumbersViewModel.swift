//
//  NumbersViewModel.swift
//  AppWithExtension
//
//  Created by Егор Чирков on 24.11.2022.
//

import Foundation

struct ListItem: Identifiable{
    let id = UUID()
    let word: String
    let count: Int
}

class NumbersViewModel: ObservableObject{
    
    @Published var selection = 0
    
    @Published var items: [ListItem] = [ListItem]()
    
    @Published var itemsTop: [ListItem] = [ListItem]()
    
    var segments: [String] = ["All suffix", "Top"]
    
    private var globalAppData: GlobalAppData? = nil
    
    func onAppear(for globalAppData: GlobalAppData){
        self.globalAppData = globalAppData
        
        print(globalAppData.repeatedWordsDict)
        fetchListItems()
    }
    
    private func fetchListItems(){
        guard let globalAppData = globalAppData else {
            return
        }
        
        let wordsDict = globalAppData.repeatedWordsDict
        
        for (key, value) in wordsDict {
            items.append(ListItem(word: key, count: value))
        }
        
        itemsTop = items.sorted(by: { $0.count > $1.count })
        
    }
    
}
