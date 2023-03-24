//
//  PayNowView.swift
//  FutalaLake
//
//  Created by Abhayjeet Singh on 29/12/22.
//

import SwiftUI

struct PayNowView: View {
    @ObservedObject var paymentViewModel = PaymentViewModel()
    private var dicData = [String: Any]()
    init(data: [String: Any]) {
        self.dicData = data
    }
    var body: some View {
        ZStack {
            AppTheme.appThemeSkyBlue
            VStack {
                VStack(alignment: .leading, spacing: 20) {
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Select Payment Mode")
                            .font(.system(size: 25, weight: .medium, design: .default))
                            .foregroundColor(AppTheme.appThemeOrange)
                            .padding(.horizontal, 22)
                            .padding(.top, 22)
                            
                        
                        
                           // Credit card
                            Button {
                                //
                            } label: {
                                HStack {
                                    HStack{
                                        Image("card")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 50, height: 50)
                                            .padding(.horizontal, 10)
                                            .padding(.leading, 15)
                                        
                                        Color.white.frame(width: 7 / UIScreen.main.scale)
                                            .frame(width: 1, height: 40)
                                            .padding(.leading, 5)
                                        
                                        Text("Credit Card")
                                            .font(.system(size: 25, weight: .medium, design: .default))
                                            .foregroundColor(.white)

                                            .padding(.trailing)
                                            .padding(.leading, 10)
                                        Spacer()
                                        //
                                    }.frame(height: 55)
                                }
                            }
                            .frame(maxWidth: .infinity)
                            .background(AppTheme.appThemeBlue)
                            .cornerRadius(8)
                            
                            
                            //Debit Card
                            
                            Button {
                                //
                            } label: {
                                HStack {
                                    HStack{
                                        Image("card")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 50, height: 50)
                                            .padding(.horizontal, 10)
                                            .padding(.leading, 15)
                                        
                                        Color.white.frame(width: 7 / UIScreen.main.scale)
                                            .frame(width: 1, height: 40)
                                            .padding(.leading, 5)
                                        
                                        Text("Debit Card")
                                            .font(.system(size: 25, weight: .medium, design: .default))
                                            .foregroundColor(.white)

                                            .padding(.trailing)
                                            .padding(.leading, 10)
                                        Spacer()
                                        //
                                    }.frame(height: 55)
                                }
                            }
                            .frame(maxWidth: .infinity)
                            .background(AppTheme.appThemeBlue)
                            .cornerRadius(8)
                            
                            //Internet Banking
                            
                            Button {
                                //
                            } label: {
                                HStack {
                                    HStack{
                                        Image("bank_home")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 45, height: 45)
                                            .padding(.horizontal, 10)
                                            .padding(.leading, 15)
                                        
                                        Color.white.frame(width: 7 / UIScreen.main.scale)
                                            .frame(width: 1, height: 40)
                                            .padding(.leading, 5)
                                        
                                        Text("Internet Banking")
                                            .font(.system(size: 25, weight: .medium, design: .default))
                                            .foregroundColor(.white)

                                            .padding(.trailing)
                                            .padding(.leading, 10)
                                        Spacer()
                                        //
                                    }.frame(height: 55)
                                }
                            }
                            .frame(maxWidth: .infinity)
                            .background(AppTheme.appThemeBlue)
                            .cornerRadius(8)
                            
                           
                            // UPI
                            
                            
                            Button {
                                //
                            } label: {
                                HStack {
                                    HStack{
                                        Image("upi")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 45, height: 45)
                                            .padding(.horizontal, 10)
                                            .padding(.leading, 15)
                                        
                                        Color.white.frame(width: 7 / UIScreen.main.scale)
                                            .frame(width: 1, height: 40)
                                            .padding(.leading, 5)
                                        
                                        Text("UPI")
                                            .font(.system(size: 25, weight: .medium, design: .default))
                                            .foregroundColor(.white)

                                            .padding(.trailing)
                                            .padding(.leading, 10)
                                        Spacer()
                                        //
                                    }.frame(height: 55)
                                }
                            }
                            .frame(maxWidth: .infinity)
                            .background(AppTheme.appThemeBlue)
                            .cornerRadius(8)
                            .padding(.bottom, 30)
                            
                        }.padding(.horizontal)
                    }
                    .frame(maxWidth: .infinity)
                    .background(Color(UIColor(hexString: "#C0C5F7")))
                    .cornerRadius(5)
                .padding()
                
                
                
                Group {
                    Button {
                        paymentViewModel.makePayment(params: dicData)
                    } label: {
                        Text("Payment")
                        .modifier(CustomButtonModifiers())
                    }
                    
                    NavigationLink(isActive: $paymentViewModel.shouldMoveToQRScreen) {
                        PaymentSuccessAlertView(data: dicData, bookingId: paymentViewModel.bookingID )
                    } label: {
                        
                    }.navigationTitle("Payment")
                }
                
                
                
                
                
                
//                NavigationLink {
//                    PaymentSuccessAlertView()
//                } label: {
//                    Text("Pay Now")
//                        .modifier(CustomButtonModifiers())
//                }.navigationTitle("Payment")
                
                Spacer()
            }
            
            
            
            
            
            
            
            }
        
//        .navigationBarTitleDisplayMode(.inline)
//        .toolbar {
//            ToolbarItem(placement: .principal) {
//                VStack {
//                    Text("Success").font(.subheadline)
//                }.foregroundColor(.white)
//            }
//        }
//        
//        .toolbar { // <2>
//            ToolbarItem(placement: .navigationBarTrailing) {
//                TopNavItemView()
//            }
//        }
        
        
            
            
            
            

            
        
    }
}

struct PayNowView_Previews: PreviewProvider {
    static var previews: some View {
        PayNowView(data: [:])
    }
}
