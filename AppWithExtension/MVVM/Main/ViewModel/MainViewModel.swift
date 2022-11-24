//
//  MainViewModel.swift
//  AppWithExtension
//
//  Created by Егор Чирков on 24.11.2022.
//

import Foundation

class MainViewModel: ObservableObject{
    
    @Published var selection: Int = 0
    
    func onOpenFromWidget(with url: URL){
        guard let host = url.host else{
            return
        }
        
        print(host)
        
        if host.contains("home"){
            selection = 0
        }
        
        if host.contains("settings"){
            selection = 1
        }
    }
}
