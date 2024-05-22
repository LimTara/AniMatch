//
//  ContentView.swift
//  AniMatch
//
//  Created by Tara Lim on 28/3/2024.
//

import SwiftUI
struct ContentView: View {
    
    @State var characterList: [String] = ["Gon", "Kaori", "Mikasa", "Mononoke", "Mustang", "Nishinoya", "SpiritedAway", "Tomioka"]
    @State var computerSlot: String = ""
    @State var playerSlot: String = ""
    @State var resultText: String = ""
    @State var restartButton: Bool = false
    @State var wins: Int = 0
    @State var attempts: Int = 0
    @State var showAlert: Bool = false
    
    func restartGame() {
        for _ in characterList {
            let computerRandom = Int.random(in: 0..<characterList.count)
            computerSlot = characterList[computerRandom]
            
            let playerRandom = Int.random(in: 0..<characterList.count)
            playerSlot = characterList[playerRandom]
        }
        
        if computerSlot == playerSlot {
            resultText = "✅ Correct Match ✅"
            restartButton = true
        } else {
            resultText = ""
            restartButton = false
        }
    }
    
    func newCharacter(character: inout String) {
        while attempts < 30 && character != computerSlot {
            
            let randomInt = Int.random(in: 0..<characterList.count)
            character = characterList[randomInt]
            
            if computerSlot == character {
                resultText = "✅ Correct Match ✅"
                restartButton = true
                wins += 1
                attempts += 1
            } else {
                attempts += 1
                return resultText = "❌ Incorrect Match ❌"
            }
        }
        if attempts == 30 {
            showAlert = true
        }
    }
    
    var body: some View {
        ZStack {
            Image("Background")
            
            VStack {
                HStack {
                    Image(systemName: "bolt.horizontal.fill")
                    Text("AniMatch")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .fontDesign(.rounded)
                    Image(systemName: "bolt.horizontal.fill")
                }
                
                Text("Click 'SWITCH' to match the required image")
                    .font(.headline)
                    .fontWeight(.medium)
                    .fontDesign(.rounded)
                
                Text("Maximum attempts is 30!")
                    .font(.headline)
                    .fontWeight(.medium)
                    .fontDesign(.rounded)
                
                Image(computerSlot)
                        .resizable()
                        .frame(width: 200, height: 200)
                        .padding()
                
                Text(resultText)
                    .font(.title2)
                    .fontWeight(.bold)
                    .fontDesign(.rounded)
                    .foregroundColor(.black)
                
                Text("Wins to Attempts: \(wins) : \(attempts)")
                    .font(.title2)
                    .fontWeight(.bold)
                    .fontDesign(.rounded)
                    .foregroundColor(.black)
                
                if restartButton == true {
                    Button(action: {
                        restartGame()
                    }, label: {
                        Text("NEXT ROUND")
                            .frame(width: 200, height: 30)
                            .font(.title3)
                            .fontWeight(.semibold)
                            .fontDesign(.rounded)
                            .foregroundColor(.black)
                            .background(.red)
                            .cornerRadius(20)
                    })
                } else {
                    Text("")
                        .frame(height: 30)
                }
                
                Image(playerSlot)
                        .resizable()
                        .frame(width: 200, height: 200)
                        .padding()
                
                Button(action: {
                    newCharacter(character: &playerSlot)
                }, label: {
                    Text("SWITCH")
                        .frame(width: 100, height: 50)
                        .font(.title3)
                        .fontWeight(.semibold)
                        .fontDesign(.rounded)
                        .foregroundColor(.black)
                        .background(.red)
                        .cornerRadius(20)
                        .padding(.top)
                })
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("You reached the maximum tries"),
                        message: Text("Come again tomorrow to play!"),
                        dismissButton: .default(Text("OK"))
                    )}

            }
            .padding()
            .onAppear{
                restartGame()
            }
        }
    }
}
#Preview {
    ContentView()
}
