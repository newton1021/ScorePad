//
//  myStepper.swift
//  ScorePad
//
//  Created by Geoffrey Flynn on 4/8/24.
//

import SwiftUI

@ViewBuilder
func myStepper (_ title: String, value: Binding<Int>, calc: (Int) -> Int) -> some View {
    
    
    HStack {
        
        Stepper(title, value: value)
            .foregroundStyle(.purple).bold()
        Image(systemName: "\(value.wrappedValue).circle")
            .font(.headline)
            .foregroundStyle(Color.black)
        
        Text("\(calc(value.wrappedValue))")
            .frame(width: 100,alignment: .trailing)
    }
}


struct MyStepperView: View {
    @State private var testValue: Int = 0
    @State private var testValue2: Int = 0
    
    var body: some View {
        VStack {
            
            myStepper("7's", value: $testValue){$0 * 5000}
            myStepper("5's", value: $testValue2){$0 * 3000}
        }
        .padding()
    }
}

#Preview {
    MyStepperView()
}
