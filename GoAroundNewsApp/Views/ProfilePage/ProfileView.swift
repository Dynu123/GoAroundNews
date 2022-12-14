//
//  ProfileView.swift
//  GoAroundNewsApp
//
//  Created by Dyana Varghese on 22/12/22.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var loginVM: LoginViewModel
    @AppStorage("appTheme") private var isDarkModeOn = false
    @StateObject var profileVM = ProfileViewModel(networkService: NetworkService())
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 30) {
                HStack {
                    Image("avatar")
                        .resizable()
                        .frame(width: 100, height: 100)
                    VStack(alignment: .leading, spacing: 10) {
                        Text(LocalStorage.user?.name ?? "")
                            .font(.system(.title, design: .rounded, weight: .bold))
                            .foregroundColor(.primary)
                        Text(LocalStorage.user?.email ?? "")
                            .font(.system(.subheadline, design: .rounded, weight: .bold))
                            .foregroundColor(.secondary)
                    }
                }
                Divider()
                NavigationLink {
                    ChangePasswordView().environmentObject(profileVM)
                } label: {
                    HStack {
                        Text("Change password")
                            .foregroundColor(.primary)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .resizable()
                            .frame(width: 10, height: 15)
                            .tint(.primary)
                    }
                }
                Divider()
                CountryListView()
                Divider()
                Toggle("Dark mode", isOn: $isDarkModeOn)
                    .tint(.accentColor)
                Divider()
                Button("Logout") {
                    LocalStorage.user = nil
                    loginVM.isUserLoggedIn = false
                    loginVM.showHome = false
                    loginVM.credential = Credential()
                }
                Spacer()
            }
            .navigationTitle("Settings")
            .padding(16)
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
