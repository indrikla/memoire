//
//  RootView.swift
//  Memoire
//
//  Created by Risa on 19/02/25.
//

import Combine
import Foundation
import SwiftUI

struct RootView: View {
    @StateObject private var router = Router()

    var body: some View {
        NavigationStack(path: $router.path) {
            StartView()
            
                .toolbar(.hidden)
                .navigationDestination(for: Router.Route.self) { route in
                    switch route {
                    case .start:
                        StartView()
                    case .deckInit:
                        DeckInitView()
                    case .deckList:
                        DeckListView()
                    case let .deckForm(deck):
                        DeckFormView(deck: deck, deckFormViewModel: DeckFormViewModel(dataService: .shared))
                    case let .gameplay(deck):
                        GameplayView(deck: deck)
                    }
                }
        }
        .environmentObject(router)
    }
}

#Preview {
    RootView()
}

