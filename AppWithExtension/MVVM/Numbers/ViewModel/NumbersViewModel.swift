//
//  NumbersViewModel.swift
//  AppWithExtension
//
//  Created by Егор Чирков on 24.11.2022.
//

import Foundation
import Combine

struct ListItem: Identifiable{
    let id = UUID()
    let word: String
    let count: Int
}

class NumbersViewModel: ObservableObject{
    
    @Published var selection = 0
    
    @Published var items: [ListItem] = [ListItem]()
    
    @Published var itemsTop: [ListItem] = [ListItem]()
    
    @Published var searchText: String = ""
    
    private var globalAppData: GlobalAppData? = nil
    
    private var cancellable: Set<AnyCancellable> = []
    
    var segments: [String] = ["All", "Top"]
    
    func onDisappear(){
        cancellable.forEach {
            $0.cancel()
        }
        cancellable.removeAll()
    }
    
    func onAppear(for globalAppData: GlobalAppData){
        self.globalAppData = globalAppData
        
        debugPrint(globalAppData.repeatedWordsDict)
        
        fetchListItems()
        
        $searchText
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .receive(on: DispatchQueue.main)
            .sink { newValue in
                
                guard !newValue.isEmpty else {
                    self.fetchListItems()
                    return
                }
                
                let searchItems = self.items.filter({ $0.word.lowercased().contains(newValue.lowercased()) })
                self.items = searchItems
                self.itemsTop = searchItems.sorted(by: { $0.count > $1.count })
                
                globalAppData.searchHistory.append(newValue)
            }
            .store(in: &cancellable)
    }
    
    private func fetchListItems(){
        guard let globalAppData = globalAppData else {
            return
        }
        
        items.removeAll()
        
        let wordsDict = globalAppData.repeatedWordsDict
        
        for (key, value) in wordsDict {
            items.append(ListItem(word: key, count: value))
        }
        
        items.sort(by: { $0.word.lowercased() < $1.word.lowercased() })
        
        itemsTop = items.sorted(by: { $0.count > $1.count })
    }
}
