//
//  ContentView.swift
//  Clock
//
//  Created by Quinn Butcher on 7/31/20.
//  Copyright © 2020 Quinn Butcher. All rights reserved.
//

import SwiftUI
import Foundation

//BOTTOM BOX


struct swipe : View {
        
////////////////////////////////////////////////////////////////////////////////////////////////
    var body : some View {
        VStack {
            
               Text("Swipe up to See more")
                .fontWeight(.heavy)
                .foregroundColor(Color.black)
                .multilineTextAlignment(.center)
                .frame(width: 600)
            
            Text("")
                
            Text("Swipe Down to See Clock")
            .fontWeight(.heavy)
                .foregroundColor(Color.black)
                .padding([.top,.bottom],15)
                .frame(width: 600)
        }
            .background(Color.white)

    }
}


////////////////////////////////////////////////////////////////////////////////////////////////


//VIEWER


struct ContentView: View {
    
    @State private var rotation = 0.0
    @State var moveAlongPath = false
    @State var moveAlongPath1 = false
    @State var isDragging: Bool = false

       var drag: some Gesture {
           DragGesture()
               .onChanged { _ in self.isDragging = true }
        
//               .onEnded { _ in self.isDragging = false }
       }
    

     
    
    @State var now = Date()
    

    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    let date = Date()
    let calendar = Calendar.current
    lazy var hour = calendar.component(.hour, from: date)
    lazy var minutes = calendar.component(.minute, from: date)
    
    
    func minValue() -> Int {
        var mutatableSelf = self
        return mutatableSelf.minutes
    }
    func hrValue() -> Int {
        var mutatableSelf = self
        return mutatableSelf.hour
    }

    
    // images
    
    var body: some View {
        


        VStack {
            //DATE
            
            Text("\(now)")
                .font(.title)
                .fontWeight(.black)
                .foregroundColor(Color.black)
                .multilineTextAlignment(.center)
                .padding(.top, 100.0)
                .frame(width: 400)
                .onReceive(timer) { input in
                self.now = input

                    
            }
            ZStack {
                //Circel
                Circle()
                    .fill(Color.red)
                    .opacity(0.3)
                    .frame(width: 400, height: 400)
                Circle()
                    .scale(0.05)
                    .stroke(Color.blue, lineWidth: 3)
                    .opacity(0.5)
                
                
                
                //test for drag capabilities
//                Circle()
//                    .fill(self.isDragging ? Color.red : Color.blue)
//                    .frame(width: 100, height: 100, alignment: .center)
//                    .gesture(drag)
                
                
                    
                    Rectangle()
                        //minute hand
                        .stroke(Color.blue, lineWidth: 3)
                        
                        .border(Color.blue)
                        .frame(width: 4, height: 150)
                        
                        .offset(y: -75)
                     .rotationEffect(.degrees((Double(minValue()) * 6)))
                      .rotationEffect(.degrees(moveAlongPath ? 360 : 0))
                        .animation(Animation.linear(duration: 3600)
                            .repeatForever(autoreverses: false))
                        .onAppear(){
                            self.moveAlongPath.toggle()
                            
                    }
                        //hour hand
                    Rectangle()
                    .stroke(Color.blue, lineWidth: 5)
                    .border(Color.blue)
                    .frame(width: 4, height: 75)
                    .offset(y: -40)
                        .rotationEffect(.degrees((Double(hrValue()) + (0.01 * Double(minValue()))) * 30))
                        .rotationEffect(.degrees(moveAlongPath1 ? 360 : 0))
                    .animation(Animation.linear(duration: 43200).repeatForever(autoreverses: false))
                    .onAppear(){
                        self.moveAlongPath1.toggle()

                    }

            }
            //working on!!!!!
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


            
           // swipe().padding(15).cornerRadius(37).offset(y : 70)
             //   .offset(y: self.isDragging ? -400 : 0)
               // .gesture(drag)
            


                }
            
        .padding()
        .foregroundColor(.white)
        .background(LinearGradient(gradient: Gradient(colors: [.green, .blue, .white]), startPoint: .top, endPoint: .bottom))
        .edgesIgnoringSafeArea(.all)
        
                        }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


