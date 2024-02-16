//
//  WhitelistView.swift
//  OwlBlock
//
//  Created by noNameDev on 22.10.2022.
//

import SwiftUI

struct WhitelistView: View {
    
    @EnvironmentObject var vm: ContentblockersViewModel
    @ObservedObject var blockerViewModel: ContentblockersViewModel
    @State private var editMode: EditMode = .inactive
    @State private var showAddSheet = Bool()
    @State private var textfieldString: String = .empty
    @Environment(\.presentationMode) var presentationMode
    @State private var showPremium = Bool()

    var body: some View {
        VStack {
            VStack(spacing: 12.0) {
                TextField("website.com", text: $textfieldString)
                    .font(.workSans(.Regular, style: .title))
                    .foregroundColor(Color.bRobinEggBlue)
                    .autocorrectionDisabled(true)
                    .autocapitalization(.none)
                    .keyboardType(.URL)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 25)
                        .fill(Color.bMintCream)
                        )
                    .background(RoundedRectangle(cornerRadius: 25)
                        .stroke(lineWidth: 1.0)
                        .fill(Color.bRobinEggBlue)
                        )
                    .shadow(color: Color.bRobinEggBlue.opacity(0.3),radius: 10)
                    .overlay(alignment: .trailing) {
                        Image(systemName: "plus")
                            .font(.title)
                            .foregroundColor(Color.bRobinEggBlue)
                            .padding()
                            .onTapGesture {
                                print("plus")
                                            if !Acquisitions.shared.isPaid {
                                            vm.addToList(type: .whitelist, textfieldString)
                                            } else {
                                                showPremium = true
                                            }
                            }
                    }
                
            }
            .padding(.horizontal)
            List {
                ForEach(blockerViewModel.whitelist, id: \.id) { item in
                    Text("\(item.title)")
                }
                .onDelete { blockerViewModel.deleteFromList(type: .whitelist, $0) }
            }
            .toolbar {
                EditButton()
                addButton
            }
            .environment(\.editMode, $editMode)
            .sheet(isPresented: $showAddSheet) {
//                WhitelistAddView(blockerViewModel: blockerViewModel)
            }
        }
        .sheet(isPresented: $showPremium) {
            SubscriptionView()
        }
    }
}

//#if DEBUG
struct WhitelistView_Previews: PreviewProvider {
    static var previews: some View {
        let blockerViewModel = ContentblockersViewModel()
        return NavigationView {
            WhitelistView(blockerViewModel: blockerViewModel)
                .navigationTitle("Whitelist")
        }
    }
}
//#endif

extension WhitelistView {
    
    private var addButton: some View {
        ZStack {
            if editMode == .inactive {
                Button {
                    showAddSheet = true
                } label: {
                    Image(systemName: "plus")
                        .resizable()
                        .scaledToFit()
                        .background(Color.white.opacity(0.001))
                }
            }
        }
    }
}
