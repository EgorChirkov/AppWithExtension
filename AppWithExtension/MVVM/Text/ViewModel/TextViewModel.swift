//
//  TextViewModel.swift
//  AppWithExtension
//
//  Created by Егор Чирков on 24.11.2022.
//

import Foundation
import Combine

//struct SuffixSequence: Sequence{
//    func makeIterator() -> some IteratorProtocol {
//        return SuffixIterator()
//    }
//}
//
//struct SuffixIterator: IteratorProtocol{
//    typealias Element = String
//
//    func next() -> Element? {
//        <#code#>
//    }
//}

class TextViewModel: ObservableObject{
    
    @Published var text: String = ""
    
    @Published var words: [String] = [String]()
    
    private var cancellable: Set<AnyCancellable> = []
    
    private var globalAppData: GlobalAppData? = nil
    
    func onAppear(for globalAppData: GlobalAppData){
        self.globalAppData = globalAppData
        
        $text
            .receive(on: DispatchQueue.main)
            .sink { newValue in
                
                self.words = newValue.components(separatedBy: " ")
                
            }
            .store(in: &cancellable)
        
        $words
            .receive(on: DispatchQueue.main)
            .sink { newValue in
                
                self.fetchCount()
            }
            .store(in: &cancellable)
    }
    
    func onDisappear(){
        cancellable.forEach {
            $0.cancel()
        }
        cancellable.removeAll()
    }
    
    private func fetchCount(){
        
        guard let globalAppData = globalAppData else {
            return
        }
        
        globalAppData.repeatedWordsDict = words.reduce(into: [:]) { counts, word in counts[word, default: 0] += 1 }
    }
}
