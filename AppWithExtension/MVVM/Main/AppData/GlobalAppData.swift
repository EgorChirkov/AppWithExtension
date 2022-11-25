//
//  GlobalAppData.swift
//  AppWithExtension
//
//  Created by Егор Чирков on 25.11.2022.
//

import Foundation

class GlobalAppData: ObservableObject{
    
    @Published var repeatedWordsDict: [String: Int] = [:]
    
    @Published var searchHistory: [String] = [String]()
}
