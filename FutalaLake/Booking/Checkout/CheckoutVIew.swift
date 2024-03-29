//
//  CheckoutVIew.swift
//  FutalaLake
//
//  Created by Abhayjeet Singh on 03/01/23.
//

import SwiftUI

struct CheckoutVIew: View {
    var showDate:String = ""
    var showStartTime:String = ""
    var showEndTime:String = ""
    var ticketType:String = ""
    var seatNo:String = ""
    var totalSeat:String = ""
    var standing:String = ""
    var ticketFee:String = ""
    var tax:String = ""
    var totalAmt:String = ""
    var bookingFees: String = ""
    
    var dataDic = [String: Any]()
    
    @StateObject var checkoutViewModel = CheckoutViewModel()
    let bookingData:SubmitBookSeatModelData
    
    init(bookingData: SubmitBookSeatModelData, dataDic: [String: Any]) {
        self.bookingData = bookingData
        
        self.dataDic = dataDic
        self.dataDic["total"] = String(bookingData.total ?? 0)
        self.dataDic["showDate"]  = bookingData.showDate ?? ""
        
        self.showStartTime = CommonUtil.convertTimeTwentyFourIntoTwelve(time: bookingData.showStartTime ?? "") ?? ""
        
        self.showEndTime = CommonUtil.convertTimeTwentyFourIntoTwelve(time: bookingData.showEndTime ?? "") ?? ""
        
        self.showDate = bookingData.showDate ?? ""
        self.ticketType = bookingData.ticketType ?? ""
        self.seatNo = bookingData.seatNumber ?? ""
        self.totalSeat = String(bookingData.totalSeats ?? 0)
        self.ticketFee = String(bookingData.ticketFees ?? 0)
        self.totalAmt = String(bookingData.total ?? 0)
        self.bookingFees = String(bookingData.bookingFees ?? 0)
        self.tax = String(bookingData.tax ?? 0)
        self.standing = String(bookingData.quantityStading ?? 0)
    }
    var body: some View {
        ZStack(alignment: .bottom) {
            //AppTheme.appThemeSkyBlue
            VStack {
                VStack(spacing: 5) {
                    HStack {
                        Text("Date")
                        Spacer()
                        Text("Show Time")
                    }
                    .font(.system(size: 18, weight: .regular, design: .default))
                    .padding(.horizontal)
                    
                    HStack {
                        Text(CommonUtil.showDate(date: showDate))
                        Spacer()
                        Text(showStartTime)
                    }
                    .font(.system(size: 18, weight: .medium, design: .default))
                    .padding(.horizontal)
                    .padding(.vertical, 3)
                }.background(AppTheme.appThemeBlue)
                    .foregroundColor(AppTheme.appThemeRed)
                
                ScrollView {
                
                VStack(alignment: .leading, spacing: 5) {
                    
                    
                    Group {
                        
                        HStack {
                            Text("Start Time")
                            Spacer()
                            Text(showStartTime)
                            
                        }
                        
                        .font(.system(size: 15, weight: .regular, design: .default))
                        .foregroundColor(.black)
                        .padding(.vertical, 5)
                        
                        Divider()
                        
                        HStack {
                            Text("End Time")
                            Spacer()
                            Text(showEndTime)
                            
                        }
                        
                        .font(.system(size: 15, weight: .regular, design: .default))
                        .foregroundColor(.black)
                        .padding(.vertical, 5)
                        
                        Divider()
                        
                        HStack {
                            Text("Ticket Type")
                            Spacer()
                            
                            Text(ticketType)
                            
                        }
                        .font(.system(size: 15, weight: .regular, design: .default))
                        .foregroundColor(.black)
                        .padding(.vertical, 5)
                        
                        Divider()
                        
                        HStack {
                            Text("Seat no/NOS")
                            Spacer()
                            
                            Text(seatNo)
                            
                        }
                        .font(.system(size: 15, weight: .regular, design: .default))
                        .foregroundColor(.black)
                        .padding(.vertical, 5)
                        
                        Divider()
                        
                        
                        HStack {
                            Text("Total Seats")
                            Spacer()
                            
                            Text(totalSeat)
                            
                        }
                        .font(.system(size: 15, weight: .regular, design: .default))
                        .foregroundColor(.black)
                        .padding(.vertical, 5)
                        
                        
                    }
                    
                    Divider()
                    
                    Group {
                        
                        HStack {
                            Text("Standing")
                            Spacer()
                            
                            Text(standing)
                            
                        }
                        .font(.system(size: 15, weight: .regular, design: .default))
                        .foregroundColor(.black)
                        .padding(.vertical, 5)
                        
                        Divider()
                        
                    }
                    
                    // Group is required if adding more items within the stack
                    Group {
                        
                        HStack {
                            Text("Ticket Fees")
                            Spacer()
                            
                            Text("₹\(ticketFee)")
                            
                        }
                        .font(.system(size: 15, weight: .regular, design: .default))
                        .foregroundColor(.black)
                        .padding(.vertical, 5)
                        
                        Divider()
                        
                        HStack {
                            Text("Booking Fees")
                            Spacer()
                            
                            Text("₹\(bookingFees)")
                            
                        }
                        .font(.system(size: 15, weight: .regular, design: .default))
                        .foregroundColor(.black)
                        .padding(.vertical, 5)
                        
                        Divider()
                        
                        
                        HStack {
                            Text("Tax")
                            Spacer()
                            
                            Text("₹\(tax)")
                            
                        }
                        .font(.system(size: 15, weight: .regular, design: .default))
                        .foregroundColor(.black)
                        .padding(.vertical, 5)
                        
                        Divider()
                        
                        Group {
                            
                            
                            ForEach(0..<(self.bookingData.seatDetails?.count ?? 0)) { index in
                                
                                VStack {
                                    
                                    if bookingData.seatDetails?[index].seatInfo?.adultQuantity ?? 0 > 0 {
                                        HStack {
                                            Text("\(bookingData.seatDetails?[index].seatType ?? "") (A):")
                                                    Spacer()
                
                                            Text("\(bookingData.seatDetails?[index].seatInfo?.adultQuantity ?? 0) X \(bookingData.seatDetails?[index].seatInfo?.adultFare ?? 0)")
                
                                                }
                                                .font(.system(size: 15, weight: .regular, design: .default))
                                                .foregroundColor(.black)
                                                .padding(.vertical, 5)
                                        
                                        Divider()
                                    }
                                    
                                    
                                    
                                    
                                    
                                    
                                    if bookingData.seatDetails?[index].seatInfo?.childQuantity ?? 0 > 0 {
                                        HStack {
                                            Text("\(bookingData.seatDetails?[index].seatType ?? "") (C):")
                                                    Spacer()
                
                                            Text("\(bookingData.seatDetails?[index].seatInfo?.childQuantity ?? 0) X \(bookingData.seatDetails?[index].seatInfo?.childFare ?? 0)")
                
                                                
                                                .font(.system(size: 15, weight: .regular, design: .default))
                                                .foregroundColor(.black)
                                                .padding(.vertical, 5)
                                            }
                                        Divider()
                                            
                                        }
                                    
                                    }

                                    
                                    
                                        
                                }
                                
                            }
                            
                            
                            
                        }
                        
                        
                       // Divider()
                        
                        HStack {
                            Text("Total Amount")
                                .font(.system(size: 15, weight: .regular, design: .default))
                                .foregroundColor(.black)
                                .padding(.vertical, 5)
                            
                            Spacer()
                            
                            Text("₹\(totalAmt)")
                                .font(.system(size: 15, weight: .bold, design: .default))
                                .foregroundColor(.black)
                                .padding(.vertical, 5)
                            
                        }
                        
                    }
                }
                .padding()
                //.background(Color(UIColor(hexString: "#C0C5F7")))
                .background(
                    Rectangle()
                        .fill(.white)
                        .cornerRadius(12)
                        .shadow(
                            color: Color.gray.opacity(0.7),
                            radius: 8,
                            x: 0, y: 0)
                )
                
                .cornerRadius(10)
                .padding()
                .padding(.bottom, 100)
            }
            //.frame(height: UIScreen.main.bounds.height - 180)
                
            if checkoutViewModel.isLoading {
               Loader()
                    .padding(.bottom, 300)
            }
            
            
                
                Button {
                    checkoutViewModel.makeCheckout(params: dataDic)
                } label: {
                    Text("Checkout")
                    .modifier(CustomButtonModifiers())
                }.padding(.bottom)

                
                
                NavigationLink(isActive: $checkoutViewModel.shouldMoveToPaymentWebViewScreen) {
                    PaymentWebView(data: checkoutViewModel.checkOutModelData)
                } label: {
                    
                }.navigationTitle("Checkout")
                
            
                
                
            }.toast(message: checkoutViewModel.message, isShowing: $checkoutViewModel.shouldShowToast, duration: Toast.short)
            
            
            
            
        }
        
    
}

struct CheckoutVIew_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutVIew(bookingData: SubmitBookSeatModelData(from: nil), dataDic: [:])
    }
}
