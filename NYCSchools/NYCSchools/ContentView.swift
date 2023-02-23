//
//  ContentView.swift
//  NYCSchools
//
//  Created by Parth Tamane on 22/02/23.
//

import SwiftUI
import SODAKit

struct ContentView: View {
    
    @State var schoolInfo = [SchoolInfo]()
    
    var body: some View {
        
        NavigationView {
            VStack {
                List(schoolInfo, id: \.self) { Text("\($0.dbn): \($0.school_name)") }
            }.onAppear {
                Task {
                    do {
                        schoolInfo = try await APIHelper().getSchoolDetails()
                    } catch {
                        NSLog("Failed to download school info: \(error)")
                    }
                }
            }
            .navigationBarTitle(Text("School List"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
