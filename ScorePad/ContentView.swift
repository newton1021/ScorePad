//
//  ContentView.swift
//  ScorePad
//
//  Created by Geoffrey Flynn on 3/19/24.
//

import SwiftUI

struct ContentView: View {
    @State var name: Int = 0
    @FocusState private var focusState: Bool
    var body: some View {
        
        TextField("Enter Name", value: $name, format: .number)
            .padding(20)
            .textFieldStyle(.roundedBorder)
            .keyboardType(.decimalPad)
            .submitLabel(.done)
            .focused($focusState)
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    if focusState {
                        Spacer()
                        Button{ focusState = false}
                        
                    label: {
                        Text("Done")
                    }
                    }
                }
            }
            .onTapGesture {
               
                focusState = true
            }
            
        
        Button("Submit"){
            focusState = false
        }
        .foregroundStyle(focusState ? .teal : .gray)
        ScrollView {
            ForEach(1...30, id: \.self){num in
                Text("Item \(num)")
                    .frame(width: 300)
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
