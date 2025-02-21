//
//  Router.swift
//  Memoire
//
//  Created by Risa on 19/02/25.
//

import Combine
import Foundation
import SwiftUI

class Router: ObservableObject {
    @Published var path = NavigationPath()
    
    enum Route: Equatable, Hashable {
        case start
        case deckInit
        case deckList
        case deckForm(deck: Deck)
        case gameplay(deck: Deck)
    }
    
    func navigate(to route: Route) {
        path.append(route)
    }
    
    func navigateBack() {
        path.removeLast()
    }
    
    func navigateToRoot() {
        path.removeLast(path.count)
    }
}
