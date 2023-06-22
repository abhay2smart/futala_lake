//
//  PaymentSuccessAlertView.swift
//  FutalaLake
//
//  Created by Abhayjeet Singh on 04/01/23.
//

import SwiftUI
import UIKit

struct PaymentSuccessAlertView: View {
    private var data: CheckOutModelData?
    @ObservedObject var paymentSuccessAlertViewModel = PaymentSuccessAlertViewModel()
    private var bookingId:String = ""
    
    init(data: CheckOutModelData, bookingId: String) {
        self.data = data
        self.bookingId = bookingId
        paymentSuccessAlertViewModel.getPaymentDetails(bookingID: bookingId)
    }
    var body: some View {
        ZStack {
            AppTheme.appThemeSkyBlue
            VStack {
                VStack(alignment: .center, spacing: 5) {
                    Group {
                        VStack(alignment: .center) {
                            Image("check_gif")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                            
                            
                            Text("Payment Successful")
                            .multilineTextAlignment(.center)
                                                .font(.system(size: 20, weight: .medium, design: .default))
                                                .foregroundColor(.black)
                                                .padding(.bottom, 5)
                            
                            Text("We've recieved your payment")
                            .multilineTextAlignment(.center)
                                                .font(.system(size: 20, weight: .regular, design: .default))
                                                .foregroundColor(.blue)
                                                .padding(.bottom, 5)
                        }
                        
                    }
                    
                    Divider()
                        .background(.black)
                        .frame(height: 3)
                        .padding(.vertical)
                    
                    Group {
                        HStack {
                            Spacer()
                            Text("Payment details")
                            .multilineTextAlignment(.center)
                                                .font(.system(size: 16, weight: .medium, design: .default))
                                                .foregroundColor(AppTheme.appThemeOrange)
                                                .padding(.bottom, 5)
                            Spacer()
                        }
                        
                        HStack {
                            Text("Payment Amount")
                            Spacer()
                            Text("₹ \(paymentSuccessAlertViewModel.totalAmt)")
                        }
                        .font(.system(size: 15, weight: .regular, design: .default))
                        .foregroundColor(.black)
                        .padding(.bottom, 5)
                        
                        Divider()
                        
                        HStack {
                            Text("Payment Date")
                            Spacer()
                            Text(Date.getCurrentDate())
                            
                        }
                            
                        .font(.system(size: 15, weight: .regular, design: .default))
                            .foregroundColor(.black)
                            .padding(.vertical, 5)
                        
                        Divider()
                        
                        HStack {
                            Text("Payment Method")
                            Spacer()
                            
                            Text("Internet Banking")
                            
                        }
                        .font(.system(size: 15, weight: .regular, design: .default))
                            .foregroundColor(.black)
                            .padding(.vertical, 5)
                        
                        Divider()
                        
                        HStack {
                            Text("Bank Trsanction ID")
                            Spacer()
                            
                            Text("\(paymentSuccessAlertViewModel.trsanctionId)")
                            
                        }
                        .font(.system(size: 15, weight: .regular, design: .default))
                            .foregroundColor(.black)
                            .padding(.vertical, 5)
                        
                        Divider()
                        
                        
                        HStack {
                            Text("Total Amount")
                            Spacer()
                            
                            Text("₹ \(paymentSuccessAlertViewModel.totalAmt)")
                            
                        }
                        .font(.system(size: 15, weight: .regular, design: .default))
                            .foregroundColor(.black)
                            .padding(.vertical, 5)
                        
                    }

                    //Divider()
                    
                    // Group is required if adding more items within the stack
                    

                }
                .padding()
                .background(Color(UIColor(hexString: "#C0C5F7")))
                .cornerRadius(10)
                .padding()
                
                
//                NavigationLink {
//                    QRView(data: self.data)
//                } label: {
//                    Text("Done")
//                        .modifier(CustomButtonModifiers())
//                }.navigationTitle("Success")
                
                
//                Group {
//
//                    Button {
//                        //
//                    } label: {
//                        Text("Done")
//                            .modifier(CustomButtonModifiers())
//                    }
//
//
//                    NavigationLink(isActive: paymentSuccessAlertViewModel.moveToQRView) {
//                        QRView(data: self.data, encriptedStandingData: paymentSuccessAlertViewModel.encriptedQRSeatString)
//                    } label: {
//
//                    }
//
//                }
                
                
                Group {
                    Button("View Ticket") {
                        paymentSuccessAlertViewModel.getQRData(bookingId: bookingId)
                    }.modifier(CustomButtonModifiers())
                    
                    NavigationLink(isActive: $paymentSuccessAlertViewModel.moveToQRView) {
                        //QRView(data: self.data, encriptedStandingData: paymentSuccessAlertViewModel.encriptedQRSeatString)
                        QRView(data: paymentSuccessAlertViewModel.qrModelData)
                    } label: {

                    }.navigationTitle("Success")
                    
                }
                
                Spacer()
            }
            
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text("Success").font(.subheadline)
                    }.foregroundColor(.white)
                }
            }
            if paymentSuccessAlertViewModel.isLoading {
                Loader()
            }
            
//            .toolbar { // <2>
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    TopNavItemView()
//                }
//            }
            
            
        }.onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                //paymentSuccessAlertViewModel.updatePaymentStatus(bookingId: bookingId)
            })
            
        }

    }
}

//struct PaymentSuccessAlertView_Previews: PreviewProvider {
//    static var previews: some View {
//        PaymentSuccessAlertView(data: [:], bookingId: "")
//    }
//}
