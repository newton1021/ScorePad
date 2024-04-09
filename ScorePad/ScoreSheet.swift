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
    @State private var headerNatural = 0
    @State private var headerDirty = 0
    @State private var countRed3s = 0
    @State private var countNaturals = 0
    @State private var countBlacks = 0
    @State private var cardCount = 0
    
    var total: Int {
        
        var sum: Int = 0
        
        sum += header7 * 5000
        sum += header5 * 3000
        sum += headerWild * 2500
        sum += headerNatural * 500
        sum += headerDirty * 300
        
        
        sum += countNaturals * 500
        sum += countBlacks * 300
        sum += red3calc(countRed3s)
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
                    myStepper("7's", value: $header7){$0 * 5000}
                    myStepper("5's", value: $header5){$0 * 3000}
                    myStepper("Wilds", value: $headerWild){$0 * 2500}
                    myStepper("Red", value: $headerNatural){ $0 > 0 ? 500 : 0}
                    myStepper("Black", value: $headerDirty){ $0 > 0 ? 500 : 0}
                    
                }
                Section("Conastas"){
                    
                    myStepper("Red 3", value: $countRed3s){red3calc($0)}
                    
                    myStepper("Natural", value: $countNaturals){$0 * 500}
                    myStepper("Blacks", value: $countBlacks) { $0 * 300 }
                    HStack{
                        Toggle("Went Out", isOn: $wentOut)
                        
                        Text(wentOut ? "200" : "0")
                        
                            .frame(width: 100,alignment: .trailing)
                        
                        
                        
                        HStack{
                            Text("Card Count" )
                            Spacer()
                            TextField("Card Count", value: $cardCount, format: .number)
                                .multilineTextAlignment(.trailing)
                                .frame(width: 100, alignment: .trailing)
                            
                        }
                        
                    }
                    
                    Section("Total"){
                        HStack{
                            Spacer()
                            Text("\(total)")
                                .font(.largeTitle).bold()
                                .frame(width: 150, alignment: .trailing)
                        }
                    }
                    
                    
                    
                    
                }
                .navigationTitle("Team 1")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
    
    
    
    func red3calc(_ cards: Int)-> Int {
        var cardCount = cards
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
