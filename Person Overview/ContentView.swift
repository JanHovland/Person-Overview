//
//  ContentView.swift
//  Person Overview
//
//  Created by Jan Hovland on 23/11/2019.
//  Copyright © 2019 Jan Hovland. All rights reserved.
//
//
//
// Mark, Cmd + click starts: https://www.youtube.com/watch?v=S41g3E6tkbQ
// Email Authentication in SwiftUI - Email Login In SwiftUI - Firebase Email Authentication in SwiftUI
// Bundle identier for the project is: com.janhovland.Person-Overview (- is a space)
// Bundle identier in Firebase: Person-Overview to register the app
//
// Download GoogleService-Info.plist
// Copy that to the project
//
// Say where Xcode-bate.app or Xcode.app is
// sudo xcode-select --switch /Applications/Xcode-beta.app/Contents/Developer
//
// pod init Generates "Podfile"
//
/*
# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'

target 'signupfirebase' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Person Overview
  
  pod 'Firebase/Core'
  pod 'Firebase/Auth'
  pod 'Firebase/Database'
  pod 'Firebase/Storage'

end
*/

/*
pod install

Analyzing dependencies
Adding spec repo `trunk` with CDN `https://cdn.cocoapods.org/`
Downloading dependencies
Installing Firebase (6.13.0)
Installing FirebaseAnalytics (6.1.6)
Installing FirebaseAuth (6.4.0)
Installing FirebaseAuthInterop (1.0.0)
Installing FirebaseCore (6.4.0)
Installing FirebaseCoreDiagnostics (1.1.2)
Installing FirebaseCoreDiagnosticsInterop (1.1.0)
Installing FirebaseDatabase (6.1.2)
Installing FirebaseInstanceID (4.2.7)
Installing FirebaseStorage (3.4.2)
Installing GTMSessionFetcher (1.3.0)
Installing GoogleAppMeasurement (6.1.6)
Installing GoogleDataTransport (3.2.0)
Installing GoogleDataTransportCCTSupport (1.2.2)
Installing GoogleUtilities (6.3.2)
Installing leveldb-library (1.22)
Installing nanopb (0.3.9011)
Generating Pods project
Integrating client project

[!] Please close any current Xcode sessions and use `Person Overview.xcworkspace` for this project from now on.
Pod installation complete! There are 4 dependencies from the Podfile and 17 total pods installed.

[!] Automatically assigning platform `iOS` with version `13.2` on target `Person Overview` because no platform was specified. Please specify a platform for this target in your Podfile. See `https://guides.cocoapods.org/syntax/podfile.html#platform`.

*/

import SwiftUI
import Firebase

struct ContentView: View {
    
    @State var email = ""
    @State var password = ""
    @State var shown = false
    @State var msg = ""
    
    var body: some View {
        
        VStack {
            
            TextField("eMail", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .padding()
            
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            HStack {
                Button(action: {
                    
                    if self.email.count == 0, self.password.count == 0 {
                        self.msg = "Fill the content"
                        self.shown.toggle()
                        return
                    }
                    DispatchQueue.main.async {
                        Auth.auth().signIn(withEmail: self.email, password: self.password) { (result, error) in
                            
                            if error != nil {
                                print((error!.localizedDescription) as Any)
                                self.msg = error!.localizedDescription
                                self.shown.toggle()
                                return
                            }
                            
                            self.msg = "Success"
                            self.shown.toggle()
                        }
                        
                    }
                    
                }) {
                    Text("Signin")
                }
                
                Button(action: {
                    
                    if self.email.count == 0, self.password.count == 0 {
                        self.msg = "Fill the content"
                        self.shown.toggle()
                        return
                    }
                    DispatchQueue.main.async {
                        Auth.auth().createUser(withEmail: self.email, password: self.password) { (result, error) in
                            
                            if error != nil {
                                print((error!.localizedDescription) as Any)
                                self.msg = error!.localizedDescription
                                self.shown.toggle()
                                return
                            }
                            
                            self.msg = "Created Successfully"
                            self.shown.toggle()
                            
                        }
                    }
                    
                }) {
                    Text("Signup")
                }
            }
            .alert(isPresented: $shown) {
                return Alert(title: Text(self.msg))
            }
            
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
