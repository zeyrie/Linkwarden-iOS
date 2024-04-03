//
//  LinkwardenApp.swift
//  Linkwarden
//
//  Created by Abilash S on 09/03/24.
//

import SwiftUI

@main
struct LinkwardenApp: App {
    
    @StateObject private var dataManager = DataManager.shared
    
    var body: some Scene {
        WindowGroup {
            ContainerView()
                .environment(\.managedObjectContext, dataManager.container.viewContext)
        }
    }
}

struct ContainerView: View {
    
    @ObservedObject var appState = LinkwardenAppState.shared
    
    var body: some View {
        ZStack {
            if appState.showLoading {
                // TODO: - ZVZV Try to show the replication of UILaunchScreen here, with a progress view that loads until the API is hit.
                ProgressView()
            }
            if appState.showLogin {
                LoginAssembler.getLoginPageView()
            }
            if appState.showHomepage {
                TabBarAssembler.getTabBar()
            }
        }
        .environmentObject(appState)
        .onAppear {
            Task {
                /// Check if the session is valid when the container is starts to appear.
                /// A valid session could be identified by hitting the API to get the user ID for the current session token that is stored in the cookie.
                if await appState.isSessionValid {
                    /// On the valid session, we will show the HomePage container view.
                    appState.showHomepage = true
                } else {
                    if !AppState.appLaunchFirstTime {
                        AppState.appLaunchFirstTime = true
                    } else {
                        // TODO: ZVZV Show Toast saying session in invalid, please loign again.
                    }
                    /// Otherwise will show the login page.
                    appState.showLogin = true
                }
                /// Turn off the progress view animation.
                appState.showLoading = false
            }
        }
    }
}