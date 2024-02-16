import SwiftUI

struct BlockerView: View {
    @ObservedObject var subscription: SubscriptionVM
    @ObservedObject var blockerViewModel = ContentblockersViewModel()
    @State private var showTutorial = Bool()
    @State private var textfieldString: String = .empty
    @State private var showPremium = Bool()
    @State private var whiteListView = false
    
    var body: some View {
        ZStack {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    ConnectedButtonView()
                    
                    LazyVGrid(columns: Array(repeating: GridItem(), count: 2), spacing: 20) {
                        
                        BlockWebTrackersView()
                        
                        CookiesButtonView()
                        
                        BlockingAdsButtonView()
                        

                        BlockAdultButtonView()
                    }
                    .padding(.horizontal)
                    
                        WhiteListButtonView()
                            .padding(.horizontal)
                            .onTapGesture {
                                whiteListView.toggle()
                            }
                }
                .padding(.bottom, 100)
            }
            .opacity(!whiteListView ? 1 : 0)
            
            VStack {
                HStack {
                    Image(systemName: "chevron.backward.circle.fill")
                        .font(.title)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading)
                        .onTapGesture {
                            whiteListView.toggle()
                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        }
                    Text("Add Website")
                        .font(.workSans(.SemiBold, style: .title3))
                        .frame(maxWidth: .infinity, alignment: .center)
                    Image(systemName: "chevron.backward.circle.fill")
                        .font(.title)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .opacity(0)
                        
                        
                }
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
                                                    blockerViewModel.addToList(type: .whitelist, textfieldString)
                                                    textfieldString = .empty
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
                .listStyle(.inset)
                
            }
            .opacity(whiteListView ? 1 : 0)
        }
        .onReceive(blockerViewModel.$showTutorialSheet) { showTutorial = $0 }
        .sheet(isPresented: $showTutorial) {
            blockerViewModel.hideTutorial()
        } content: {
            TutView()
        }
        .environmentObject(blockerViewModel)
        .sheet(isPresented: $showPremium) {
            SubscriptionView()
        }
    }
}

#Preview {
    BlockerView(subscription: SubscriptionVM(), blockerViewModel: ContentblockersViewModel())
}


