//
//  ContentView.swift
//  EvolveAssignment
//
//  Created by Ganpat Jangir on 29/11/24.
//

import SwiftUI

struct ContentView: View {
    @State var searchedText = ""
    private let adaptiveColumn = [
        GridItem(.adaptive(minimum: 170))
        ]
    private var data  = Array(1...20)
    var body: some View {
        ZStack {
            Color.black
            VStack(alignment: .leading) {
                HStack {
                    Text("Explore")
                        .foregroundStyle(.white)
                        .font(.largeTitle.bold())
                    Spacer()
                    HStack(spacing: 10) {
                        RoundedRectangle(cornerRadius: 19)
                            .foregroundStyle(Color(uiColor: UIColor(white: 114/255, alpha: 1)))
                            .frame(width: 38,height: 38)
                            .overlay {
                                Image(systemName: "heart.fill")
                                    .resizable()
                                    .foregroundStyle(.white)
                                    .frame(width: 20,height: 17)
                            }
                        RoundedRectangle(cornerRadius: 19)
                            .foregroundStyle(Color(uiColor: UIColor(white: 114/255, alpha: 1)))
                            .frame(width: 38,height: 38)
                            .overlay {
                                Image(systemName: "music.note")
                                    .resizable()
                                    .foregroundStyle(.white)
                                    .frame(width: 17,height: 17)
                            }
                    }
                }
                Text("Discover")
                    .font(.title.bold())
                    .foregroundStyle(.white)
                    .padding(.top, 30)
                RoundedRectangle(cornerRadius: 25)
                    .foregroundStyle(Color(uiColor: UIColor(red: 26/255, green: 27/255, blue: 29/255, alpha: 1)))
                    .frame(height: 50)
                    .overlay {
                        HStack(spacing: 10) {
                            Image(systemName: "magnifyingglass")
                                .resizable()
                                .frame(width: 19,height: 18.5)
                                .foregroundStyle(.white)
                            TextField("", text: $searchedText, prompt: Text("Search").foregroundStyle(Color(uiColor: UIColor(white: 114/255, alpha: 1))))
                                .tint(.white)
                                .foregroundStyle(.white)
                                .font(.title3)
                        }
                        .padding(.horizontal)
                    }
                    .padding(.vertical)
                
                ScrollView {
                    LazyVGrid(columns: adaptiveColumn, spacing: 13) {
                        ForEach(data, id: \.self) { item in
                            ItemView
                                .frame(width: 170,height: 190)
                                .foregroundColor(.white)
                        }
                    }
                    
                }
                
            }
            .padding(.horizontal)
            .padding(.top, 50)
        }
        .ignoresSafeArea()
    }
    
    private var ItemView: some View {
        VStack(alignment: .leading, spacing: 10) {
            Image("placeholder", bundle: .main)
                .resizable()
                .frame(height: 117)
                .cornerRadius(10)
            Text("Create healthier relationships")
                .font(.system(size: 17))
                .multilineTextAlignment(.leading)
                .lineLimit(2)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.leading,2)
            Text("5 sessions . 5-10 min")
                .font(.system(size: 14))
                .padding(.leading,2)
        }
    }
}

#Preview {
    ContentView()
}
