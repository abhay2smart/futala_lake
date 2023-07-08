//
//  FileDownloadManager.swift
//  FutalaLake
//
//  Created by Abhayjeet Singh on 23/06/23.
//

import Foundation
import UIKit

class FileDownloadManager: NSObject {
//    private var fileUrlString: String //https://ffts.aurionpro.com:3001/pdf/ticket_2509eeae-9cf6-4aab-97ab-bcb9232a94bf.pdf
//    init(fileUrl: String) {
//        self.fileUrlString = fileUrl
//    }
    
    static func downloadPDF(bookingId: String, completion: @escaping ((URL?)->())) {
        let fileResourceUrl = "\(Constants.baseUrl)pdf/ticket_\(bookingId).pdf"
        print("actual remote file path \(fileResourceUrl)")
        guard let url = URL(string: fileResourceUrl) else { return }
        
        URLSession.shared.downloadTask(with: url) { (tempURL, response, error) in
            guard let tempURL = tempURL else {
                if let error = error {
                    completion(nil)
                    print("Download error: \(error.localizedDescription)")
                }
                return
            }
            
            
            
            let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            try? FileManager.default.removeItem(at: documentsPath)
            let destinationURL = documentsPath.appendingPathComponent("ticket_\(bookingId).pdf")
            print("temp path: \(documentsPath)")
            print("file path: \(destinationURL)")
            
            do {
                try FileManager.default.moveItem(at: tempURL, to: destinationURL)
                print("PDF file downloaded successfully!")
                
                // Call the sharePDF function after successful download
                //self.sharePDF(pdfURL: destinationURL)
                completion(destinationURL)
                
            } catch {
                completion(nil)
                print("Error saving file: \(error.localizedDescription)")
            }
        }.resume()
    }
    
    static func sharePDF(pdfURL: URL) {
        let activityViewController = UIActivityViewController(activityItems: [pdfURL], applicationActivities: nil)
        
        // Set WhatsApp as the default sharing app
        activityViewController.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.addToReadingList]
        
        // Present the activity view controller
        DispatchQueue.main.async {
            //UIApplication.shared.windows.first?.rootViewController?.present(activityViewController, animated: true, completion: nil)
            
            
            let allScenes = UIApplication.shared.connectedScenes
            let scene = allScenes.first { $0.activationState == .foregroundActive }
                                    
            if let windowScene = scene as? UIWindowScene {
                windowScene.keyWindow?.rootViewController?.present(activityViewController, animated: true)
            }
        }
        
    }

    
}
