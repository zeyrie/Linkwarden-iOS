//
//  TabBarView.swift
//  Linkwarden
//
//  Created by Abilash S on 01/04/24.
//

import SwiftUI

struct TabBarView: View {
    
    @ObservedObject var viewState: TabViewState
    
    var body: some View {
        TabView {
            ForEach(viewState.modulesList, id: \.id) { module in
                switch module {
                case .Bookmarks:
                    BookmarksView()
                        .tabItem {
                                module.tabIcon
                                Text(module.displayName)
                        }
                case .Collections:
                    CollectionsView()
                        .tabItem {
                                module.tabIcon
                                Text(module.displayName)
                        }
                case .Favourites:
                    FavouritesView()
                        .tabItem {
                                module.tabIcon
                                Text(module.displayName)
                        }
                case .Tags:
                    TagsView()
                        .tabItem {
                                module.tabIcon
                                Text(module.displayName)
                        }
                case .Settings:
                    SettingsView()
                        .tabItem {
                                module.tabIcon
                                Text(module.displayName)
                        }
                }
            }
        }
        .background(.red)
        .onAppear {
            viewState.viewOnAppearing()
        }
    }
}

#Preview {
    TabBarAssembler.getTabBar()
}
