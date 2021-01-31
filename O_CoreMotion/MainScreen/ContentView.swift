//
//  ContentView.swift
//  O_CoreMotion
//
//  Created by olivier robin on 30/01/2021.
//

import SwiftUI

// TODO : I could try to have only one vieWModel, for all "View"
// it would be a global variable. or ???
// To be investigated



// copyright overlay : just for fun :o)

struct CopyrightOverlay: View {
    var body: some View {
        ZStack {
            Text("Olivier Robin - ©2021")
                .font(.callout).padding(16).foregroundColor(.white)
        }.background(Color.blue)
        .opacity(0.7).cornerRadius(16.0).padding(16)
    }
}

// Roll overlay

struct RollOverlay: View {
    
    @ObservedObject var viewModel: ViewModel

    init() {
        viewModel = ViewModel()
        viewModel.startMotionManager()
    }

    var body: some View {
        ZStack {
            Text("Roll : " + viewModel.angle_Roll_Y)
                .font(.callout).padding(8).foregroundColor(.white)
        }.background(Color.blue)
        .opacity(0.7).cornerRadius(5).padding(8)

    }
}

// pitch overlay

struct PitchOverlay: View {
    
    @ObservedObject var viewModel: ViewModel

    init() {
        viewModel = ViewModel()
        viewModel.startMotionManager()
    }

    var body: some View {
        ZStack {
            Text("Pitch : " + viewModel.angle_Roll_Y)
                .font(.callout).padding(8).foregroundColor(.white)
        }.background(Color.blue)
        .opacity(0.7).cornerRadius(5).padding(8)

    }
}

// yaw overlay

struct YawOverlay: View {
    
    @ObservedObject var viewModel: ViewModel

    init() {
        viewModel = ViewModel()
        viewModel.startMotionManager()
    }

    var body: some View {
        ZStack {
            Text("Yaw : " + viewModel.angle_Roll_Y)
                .font(.callout).padding(8).foregroundColor(.white)
        }.background(Color.blue)
        .opacity(0.7).cornerRadius(5).padding(8)

    }
}


// Main view, containing image, text, and 4 overlay

struct ContentView: View {
    
    @ObservedObject var viewModel: ViewModel
    
    init() {
        viewModel = ViewModel()
        viewModel.startGetActivity_Pedometer()
    }
    
    var body: some View {
        
        
        VStack {

            Spacer()

            Text("display motion, pedometer, activity of your device").padding(20).foregroundColor(.black)

            Image("motion").resizable()
                .aspectRatio(contentMode: .fit).padding(50)
                .overlay(RollOverlay(), alignment: .top)
                .overlay(PitchOverlay(), alignment: .trailing)
                .overlay(YawOverlay(), alignment: .leading)


            Spacer()
            
            Text("Activity status : " + viewModel.activityStatusText ).foregroundColor(.black)
            //.padding(20)

            Text("Pedometer distance : " + viewModel.pedometerDistanceText ).foregroundColor(.black)
            Text("Pedometer nb steps : " + viewModel.pedometerNbStepsText ).foregroundColor(.black)

            CopyrightOverlay()
            

        }.background(Color.white)
        .onAppear {
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
