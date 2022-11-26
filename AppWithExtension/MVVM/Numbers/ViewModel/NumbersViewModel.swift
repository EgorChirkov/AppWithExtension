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
    
    private var dispatchWorkItem: DispatchWorkItem? = nil
    
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
                
                self.fetchSearchResults(with: newValue)
                
            }
            .store(in: &cancellable)
    }
    
    private func fetchSearchResults(with query: String){
        
        dispatchWorkItem?.cancel()
        
        let workItem = DispatchWorkItem{ [weak self] in
            
            guard let self = self else {
                return
            }
            
            let searchItems = self.items.filter({ $0.word.lowercased().contains(query.lowercased()) })
            self.items = searchItems
            self.itemsTop = searchItems.sorted(by: { $0.count > $1.count })
            
            guard let globalAppData = self.globalAppData else {
                return
            }
            
            globalAppData.searchHistory.append(query)
        }
        
        dispatchWorkItem = workItem
        
        DispatchQueue.main.asyncAfter(deadline: .now(), execute: workItem)
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
