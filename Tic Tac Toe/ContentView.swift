//
//  ContentView.swift
//  Tic Tac Toe
//
//  Created by Tyler Berlin on 10/2/24.
//

import SwiftUI

struct ContentView: View {
    @State private var moves = Array(repeating: "", count: 9)
    @State private var xTurn = true
    @State private var gameOver = false
    @State private var winMessage = ""
    var body: some View {
        VStack {
            Text("Tic Tac Toe")
                .font(.title).bold()
            LazyVGrid(columns: Array(repeating: GridItem(.fixed(120)), count: 3), content:{
                ForEach(0..<9) { index in
                    ZStack{
                        Color.blue
                        Color.white
                            .opacity(moves[index] == "" ? 1: 0)
                        Text(moves[index])
                            .font(.system(size: 90))
                            .fontWeight(.heavy)
                    }
                    .frame(width: 120, height: 120, alignment: .center)
                    .cornerRadius(30)
                    .onTapGesture {
                        withAnimation(.default){
                            if moves[index] == ""{
                                moves[index] = xTurn ? "X" : "O"
                                xTurn.toggle()
                            }
                        }
                    }
                    .rotation3DEffect(
                        .degrees(moves[index] == "" ? 180 : 0), axis: (x: 0.0, y: 1.0, z: 0.0)
                    )
                }
            })
        }
        .preferredColorScheme(.dark)
        .alert(isPresented: $gameOver) {
            Alert(title: Text(winMessage), dismissButton: .destructive(Text("Play again"),
                                                                       action: {
                withAnimation{
                    moves = Array(repeating: "", count: 9)
                    gameOver = false
                }
            }))
        }
        .onChange(of: moves) { oldValue, newValue in
            checkForWinner()
        }
    }
    
    private func checkForWinner(){
        //Vertacle
        checkLine(a: 0, b: 1, c: 2)
        checkLine(a: 3, b: 4, c: 5)
        checkLine(a: 6, b: 7, c: 8)
        //Horizontal
        checkLine(a: 0, b: 3, c: 6)
        checkLine(a: 1, b: 4, c: 8)
        checkLine(a: 2, b: 6, c: 8)
        //Angle
        checkLine(a: 0, b: 4, c: 8)
        checkLine(a: 2, b: 4, c: 6)
        
        if !(gameOver || moves.contains("")){
            winMessage = "Cat's Game"
            gameOver = true
        }
    }
    
    private func checkLine(a: Int, b: Int, c: Int){
        if moves[a] != "" && moves[a] == moves[b] && moves[b] == moves[c] {
            winMessage = "\(moves[a]) is the winner!"
            gameOver = true
        }
    }
}

#Preview {
    ContentView()
}
