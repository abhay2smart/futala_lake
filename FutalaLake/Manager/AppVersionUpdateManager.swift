//
//  NewUpdateManager.swift
//  FutalaLake
//
//  Created by Abhayjeet Singh on 14/06/23.
//

import Firebase
import FirebaseDatabase
final class AppVersionUpdateManager {
    static let shared = AppVersionUpdateManager()
    private init() {}
    
    func checkForUpdate(completion:@escaping(Bool)->()) {
        let ref = Database.database().reference().child("minAppVersion") // minAppVersion Fibase database
        ref.observe(.value) { snapshot in
            //print("Abhay--> \(snapshot.value.)")
            let versionDic = snapshot.value as? [String: String] ?? [:]
            let updatedRemoteVersion = Double(versionDic["version"] ?? "0") ?? 0
            guard let bundleInfo = Bundle.main.infoDictionary,
                let currentLocalVersion = bundleInfo["CFBundleShortVersionString"] as? String
                //let identifier = bundleInfo["CFBundleIdentifier"] as? String,
                //let url = URL(string: "http://itunes.apple.com/lookup?bundleId=\(identifier)")
                else {
                    print("some thing wrong")
                    completion(false)
                    return
            }
            
            let currentLocalVersionDouble = Double(currentLocalVersion) ?? 0
            
            print("updatedRemoteVersion -> \(updatedRemoteVersion) , currentLocalVersionDouble-> \(currentLocalVersionDouble) ")

            if updatedRemoteVersion > currentLocalVersionDouble {
                completion(true)
            }
            
        }
    }
}




