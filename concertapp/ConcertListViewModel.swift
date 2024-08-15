//
//  ConcertListViewModel.swift
//  concertapp
//
//  Created by Adriaan Vander Elst on 10/08/2024.
//

import SwiftUI

class ConcertListViewModel: ObservableObject {
    typealias Concert = ConcertList.Concert
    
    private var concertList = ConcertList()
    
    var concerts: [Concert] {
        concertList.concerts
    }
    
}
