//
//  ScoreSheet.swift
//  ScorePad
//
//  Created by Geoffrey Flynn on 3/19/24.
//

import SwiftUI

enum ScoreItem: Int {
    case header7
    case header5
    
    func value() -> Int {
        switch self {
        case .header7:
            return self.rawValue * 5000
        case .header5:
            return self.rawValue * 3000
//        default:
//            return 0
        }
    }
    
    func label() -> String{
        switch self {
        case .header7:
            return "7's"
        case .header5:
            return "5's"
//        default:
//            return ""
        }
    }
    
}


struct ScoreSheet: View {
    @State private var wentOut = false //this will need to be determined before
    @State private var header7 = 0
    @State private var header5 = 0
    @State private var headerWild = 0
    @State private var headerNatural = false
    @State private var headerDirty = false
    @State private var countRed3s = ""
    @State private var countNaturals = ""
    @State private var countBlacks = ""
    @State private var cardCount = ""
    
    var total: Int {
        
        var sum: Int = 0
        
        sum += header7 * 5000
        sum += header5 * 3000
        sum += headerWild * 2500
        sum += headerNatural ? 500 : 0
        sum += headerDirty ?  300 : 0
        
        
        sum += (Int(countRed3s) ?? 0) * 500
        sum += (Int(countBlacks) ?? 0) * 300
        sum += red3calc()
        sum += wentOut ? 200 : 0
        
        
        return sum
    }
    
    
    var body: some View {
        NavigationStack {
            Form {
              
                    HStack{
                        Text("Previous Score")
                        Spacer()
                        Text("\(13500)")
                    }
                 
                
                Section("Header"){
                    //myStepper(value: $header7)
                    
                    VStack(alignment: .trailing){
                        myStepper("7's", value: $header7){$0 * 5000}
                        myStepper("5's", value: $header5){$0 * 3000}
                        myStepper("Wilds", value: $headerWild){$0 * 2500}
                        
                        HStack{
                            Toggle("Red", isOn: $headerNatural)
                            Text("\(headerNatural ? 500 : 0)")
                                .frame(width: 100,alignment: .trailing)
                        }
                        HStack{
                            Toggle("Black", isOn: $headerDirty)
                            Text("\(headerDirty ? 300 : 0)")
                                .frame(width: 100,alignment: .trailing)
                        }
                    }
                }
                Section("Conastas"){
                    //myStepper("Red 3", value: $countRed3s){$0 * 5000}
                    HStack{
                        Text("Red 3")
                        TextField("Num of Red 3s",text: $countRed3s)
                            .padding(.horizontal, 60)
                        Text("\(red3calc())")
                    }
                    HStack{
                        Text("Naturals")
                        TextField("Num of Red Conastas",text: $countNaturals)
                            .padding(.horizontal, 30)
                        Text("\((Int(countNaturals) ?? 0) * 500)")
                    }
                    HStack{
                        Text("Black Conastas")
                        TextField("Number",text: $countBlacks)
                            .padding(.horizontal, 30)
                        Text("\((Int(countBlacks) ?? 0) * 300)")
                    }
                    HStack{
                        Toggle("Went Out", isOn: $wentOut)
                        
                        Text(wentOut ? "200" : "0")
                            
                            .frame(width: 100,alignment: .trailing)
                            
                    }
                    
                    HStack{
                        Text("Card Count" )
                        Spacer()
                        TextField("Card Count", text: $cardCount)
                            .multilineTextAlignment(.trailing)
                            .frame(width: 100, alignment: .trailing)
                            
                    }
                       
                }
                
                Section("Total"){
                    HStack{
                        Spacer()
                        Text("\(total)")
                            .font(.title).bold()
                            .frame(width: 100, alignment: .trailing)
                    }
                }
                .navigationTitle("Team 1")
                
                
                
            }
            .navigationBarTitleDisplayMode(.inline)
            
            
        }
        
        
        
    }
    
 
    
    func red3calc()-> Int {
        var cardCount = Int(countRed3s) ?? 0
        var total = 0
        
        while cardCount > 7 {
            total += 1000
            cardCount -= 7
        }
        total += cardCount * 100
        
        return total
    }
}

#Preview {
    ScoreSheet()
}
