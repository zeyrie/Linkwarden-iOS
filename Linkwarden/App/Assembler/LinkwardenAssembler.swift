//
//  LinkwardenAssembler.swift
//  Linkwarden
//
//  Created by Abilash S on 24/03/24.
//

import Foundation

struct LinkwardenAssembler {
    
    /// Session Usecase
    /// - Returns: Returns the usecase that is required to retrieve the user id for the current session token.
    static func getSessionDetailUsecase() -> GetSessionDetailUsecase {
        let networkService = GetSessionDetailsNetworkService()
        let datamanager = GetSessionDetailDataManager(networkService: networkService)
        return GetSessionDetailUsecase(dataManager: datamanager)
    }
    
    /// Returns the Container View for the app.
    /// - Returns: Container View that holds the login view and the tab bar, and acts as the base view for the whole app.
    static func getContainerView() -> ContainerView {
        var appState = LinkwardenAppState.shared
        let view = ContainerView(appState: appState)
        appState.containerView = view
        return view
    }
    
}
