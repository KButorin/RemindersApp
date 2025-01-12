//
//  Delay .swift
//  RemindersApp
//
//  Created by ESSIP on 24.08.2024.
//

import Foundation

class Delay {
    private var seconds: Double
    var workItem: DispatchWorkItem?
    
    init(seconds: Double = 1.5) {
        self.seconds = seconds
    }
    
    func performWork(_ work: @escaping() -> ()){
        workItem = DispatchWorkItem(block: {
            work()
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: workItem!)
    }
    
    func cancel(){
        workItem?.cancel()
    }
    
}
