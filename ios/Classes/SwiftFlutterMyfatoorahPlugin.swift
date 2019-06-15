import Flutter
import UIKit
import MFSDK

public class SwiftFlutterMyfatoorahPlugin: NSObject, FlutterPlugin, MFInvoiceCreateStatusDelegate {
  public static func register(with registrar: FlutterPluginRegistrar) {
    MFSettings.shared.configure(username: "apiaccount@myfatoorah.com", password: "api12345*", baseURL: "https://apidemo.myfatoorah.com/")
    
    // You can change title and color of navigation bar, also title and color of dismiss button
    let them = MFTheme(navigationTintColor: .white, navigationBarTintColor: .lightGray, navigationTitle: "Payment", cancelButtonTitle: "Cancel")
    
    MFSettings.shared.setTheme(theme: them)
    
    
    let channel = FlutterMethodChannel(name: "flutter_myfatoorah", binaryMessenger: registrar.messenger())
    let instance = SwiftFlutterMyfatoorahPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }
    
    func setupPayment() {
        //1- Create invoice model like this:
        
        /// - Parameters:
        ///   - invoiceValue: Invoice amount the customer will pay
        ///   - customerName: Your customer name
        ///   - countryCode: Your country code
        ///   - displayCurrency: Currency will be displayed for the user
        let invoice = MFInvoice(invoiceValue: 20, customerName: "Test", countryCode: .kuwait, displayCurrency: .Kuwaiti_Dinar_KWD)
        
        
        
        //2- Create Card model with card info you get from the user:
        /// - Parameters:
        ///   - cardExpiryMonth: Card expiry month 2 digits
        ///   - cardExpiryYear: Card expiry year 2 digits
        ///   - cardSecurityCode: Card security code 3 digits
        ///   - cardNumber: Card number
        let card = MFCard(cardExpiryMonth: "05", cardExpiryYear: "21", cardSecurityCode: "100",cardNumber: "54123458888888889")
        
        
        //3- Pass them to createInvoice method and wait the response from the SDK :
        /// - Parameters:
        ///   - invoice: Invoice model
        ///   - card: Card model
        ///   - apiLanguage: Language you prefer for getting msg from the API
        MFPaymentRequest.shared.createInvoice(invoice: invoice, card: card, apiLanguage: .english)
    }
    
    //MFOrder status Delegate methods
    func didInvoiceCreateSucess(transaction: MFTransaction) {
        print( "Success")
        print("result: \(transaction)")
        
    }
    
    func didInvoiceCreateFail(error: MFFailResponse) {
        print("responseCode: \(error.statusCode)")
        print( "Error: \(error.errorDescription)")
        
    }
    
    func didPaymentCancel() {
        print("Error: Payment Cancelled")
        
    }
}
