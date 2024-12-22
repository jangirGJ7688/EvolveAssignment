//
//  ContentView.swift
//  EvolveAssignment
//
//  Created by Ganpat Jangir on 29/11/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct ContentView: View {
    
    @StateObject var viewModel: HomeViewModel = HomeViewModel()
    
    private let adaptiveColumn = [
        GridItem(.adaptive(minimum: 150), spacing: 15, alignment: .top)
    ]
    
    init() {
        UIScrollView.appearance().indicatorStyle = .white
//        UIScrollView.appearance().tintColor = UIColor.red
    }
    var body: some View {
        ZStack {
            Color.black
            VStack(alignment: .leading) {
                HStack {
                    Text("Explore")
                        .foregroundStyle(.white)
                        .font(.custom(Fonts.Poppins_Medium, size: 26))
                    Spacer()
                    HStack(spacing: 10) {
                        RoundedRectangle(cornerRadius: 19)
                            .foregroundStyle(Color.white.opacity(0.2))
                            .frame(width: 38,height: 38)
                            .overlay {
                                Image(systemName: "heart.fill")
                                    .resizable()
                                    .foregroundStyle(.white)
                                    .frame(width: 20,height: 17)
                            }
                        RoundedRectangle(cornerRadius: 19)
                            .foregroundStyle(Color.white.opacity(0.2))
                            .frame(width: 38,height: 38)
                            .overlay {
                                Image("music")
                                    .resizable()
                                    .foregroundStyle(.white)
                                    .frame(width: 17,height: 17)
                            }
                    }
                }
                Text("Discover")
                    .font(.custom(Fonts.Poppins_SemiBold, size: 22))
                    .foregroundStyle(.white)
                    .padding(.top, 30)
                RoundedRectangle(cornerRadius: 22)
                    .foregroundStyle(Color(uiColor: UIColor(red: 26/255, green: 27/255, blue: 29/255, alpha: 1)))
                    .frame(height: 44)
                    .overlay {
                        HStack(spacing: 10) {
                            Image(systemName: "magnifyingglass")
                                .resizable()
                                .frame(width: 19,height: 18.5)
                                .foregroundStyle(.white)
                            TextField("", text: $viewModel.searchedText, prompt: Text("Search").foregroundStyle(Color(uiColor: UIColor(white: 114/255, alpha: 1))))
                                .tint(.white)
                                .foregroundStyle(.white)
                                .font(.custom(Fonts.Poppins_Regular, size: 16))
                                .autocorrectionDisabled()
                                .textInputAutocapitalization(.never)
                        }
                        .padding(.horizontal)
                    }
                
                if self.viewModel.searchedText == "" {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(viewModel.filterKeywords, id: \.id) { item in
                                FilterItemView(title: item.title ?? "", isSelected: viewModel.filerSelected == item.title)
                                    .onTapGesture {
                                        viewModel.filerSelected = item.title ?? "All"
                                    }
                            }
                        }
                    }
                    .padding(.vertical)
                }
                
                
                if self.viewModel.isAPICallInProgress == true {
                    VStack(alignment: .center) {
                        Spacer()
                        HStack {
                            Spacer()
                            ProgressView("Loading...")
                                .progressViewStyle(.circular)
                                .controlSize(.large)
                                .foregroundColor(.pink)
                                .tint(.pink)
                            Spacer()
                        }
                        Spacer()
                    }
                }else {
                    if self.viewModel.bottomItems.isEmpty {
                        NoItemView()
                    }else {
                        ScrollView(showsIndicators: true) {
                            LazyVGrid(columns: adaptiveColumn) {
                                ForEach(viewModel.bottomItems, id: \.id) { item in
                                    getItemView(item: item)
                                        .task {
                                            if self.viewModel.hasReachedLast(item) {
                                                // Fetch Next Page Data
                                            }
                                        }
                                }
                            }
                            .padding(.horizontal, 10)
                        }
                        .padding(.horizontal, -20)
                    }
                }
            }
            .padding(.horizontal)
            .padding(.top, 50)
        }
        .ignoresSafeArea()
    }
    
    private func getItemView(item: ItemModel) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            WebImage(url: URL(string: item.thumbImage ?? "")) { image in
                image
            } placeholder: {
                Image("placeholder")
            }
            .resizable()
            .scaledToFit()
            .cornerRadius(10)
            .frame(width: .infinity,height: UIScreen.main.bounds.width / 3)
            Text(item.title ?? "")
                .font(.custom(Fonts.Poppins_Medium, size: 16))
                .foregroundStyle(.white)
                .multilineTextAlignment(.leading)
                .lineLimit(nil)
                .fixedSize(horizontal: false, vertical: true)
            HStack {
                Text((item.sessions ?? ""))
                    .font(.custom(Fonts.Poppins_Regular, size: 14))
                Circle()
                    .frame(width: 4,height: 4)
                Text(item.description)
                    .font(.custom(Fonts.Poppins_Regular, size: 14))
            }
            .foregroundStyle(Color.gray)
            Spacer()
        }
        .frame(maxWidth: .infinity)
    }
    
    private func FilterItemView(title: String, isSelected: Bool) -> some View{
        HStack {
            Text(title)
                .font(.custom(Fonts.Poppins_Regular, size: 15))
                .foregroundStyle(.white)
            if isSelected {
                Image(systemName: "checkmark")
                    .resizable()
                    .frame(width: 13, height: 8)
                    .foregroundStyle(.white)
            }
        }
        .padding(.vertical)
        .padding(.horizontal, 30)
        .background(content: {
            Color.white.opacity(isSelected ? 0.4 : 0.2)
        })
        .frame(height: 44)
        .cornerRadius(22)
    }
}

#Preview {
    ContentView()
}
