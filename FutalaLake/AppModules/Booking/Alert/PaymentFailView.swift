//
//  PaymentFailView.swift
//  FutalaLake
//
//  Created by Abhayjeet Singh on 12/05/23.
//

import SwiftUI

struct PaymentFailView: View {
    @EnvironmentObject var session: SessionManager
    private var data: CheckOutModelData?
    @ObservedObject var paymentSuccessAlertViewModel = PaymentSuccessAlertViewModel()
    private var bookingId:String = ""
    
    init(data: CheckOutModelData, bookingId: String) {
        self.data = data
        self.bookingId = bookingId
        paymentSuccessAlertViewModel.getPaymentDetails(bookingID: bookingId)
    }
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            AppTheme.appThemeSkyBlue
            VStack {
                VStack(alignment: .center, spacing: 5) {
                    Group {
                        VStack(alignment: .center) {
                            Image("failled")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                            
                            
                            Text("Payment Failed")
                            .multilineTextAlignment(.center)
                                                .font(.system(size: 20, weight: .medium, design: .default))
                                                .foregroundColor(.red)
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
                
                
                
                
                Spacer()
            }
            
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text("Failled").font(.subheadline)
                    }.foregroundColor(.white)
                }
            }
            
            Button {
                //
                self.session.moveToDashboard = true
            } label: {
                VStack(spacing: 5) {
                    ZStack {
                        Rectangle()
                            .fill(AppTheme.appThemeOrange)
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                        Text("Booking")
                            .multilineTextAlignment(.center)
                            .font(.system(size: 10, weight: .medium, design: .default))
                            .foregroundColor(.white)
                        
                    }
                    
                    
                }
            }.padding()
            
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

//struct PaymentFailView_Previews: PreviewProvider {
//    static var previews: some View {
//        PaymentFailView()
//    }
//}
