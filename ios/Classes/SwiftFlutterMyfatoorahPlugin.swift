import Flutter
import UIKit
import MFSDK


public class SwiftFlutterMyfatoorahPlugin: NSObject, FlutterPlugin, UINavigationControllerDelegate,MFInvoiceCreateStatusDelegate {

    var results : FlutterResult!
    var navigationController: UINavigationController!

    override init(){
        super.init()
    }

 public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_myfatoorah", binaryMessenger: registrar.messenger())
    let instance = SwiftFlutterMyfatoorahPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
    
  }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
      results = result
      if(call.method.elementsEqual("payment"))
        {
            let arguments = call.arguments as! NSDictionary

         MFInvoiceCreateStatus.shared.delegate = self
         MFSettings.shared.configure(username: arguments["cred_email"] as! String, password: arguments["cred_pass"] as! String, baseURL:arguments["cred_url"] as! String)
         let them = MFTheme(navigationTintColor: .white, navigationBarTintColor: .lightGray, navigationTitle: "Payment", cancelButtonTitle: "Cancel")
         MFSettings.shared.setTheme(theme: them)
        let invoice = MFInvoice(invoiceValue: arguments["price"] as! Double, customerName: arguments["name"] as! String, countryCode: .kuwait, displayCurrency: .Kuwaiti_Dinar_KWD)
        invoice.customerEmail = "a@b.com"// must be email
        invoice.customerMobile = "mobile no"//Required
        invoice.customerCivilId = ""
        invoice.customerBlock = ""
        invoice.customerStreet = ""
        invoice.customerHouseBuildingNo = ""
        invoice.customerReference = ""
        invoice.language = .arabic
        invoice.sendInvoiceOption = .sms
        invoice.apiCustomFileds = ""
        MFPaymentRequest.shared.createInvoice(invoice: invoice, paymentMethod: .all, apiLanguage: .english)
        }

    }
    public func didInvoiceCreateSucess(transaction: MFTransaction) {
       let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(transaction)

            if let jsonString = String(data: jsonData, encoding: .utf8) {
                results(jsonString)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    public func didInvoiceCreateFail(error: MFFailResponse) {
        var errorDescription = error.errorDescription as String
        var statusCode  = String(error.statusCode)
        let dict : Dictionary = ["Error": errorDescription, "responseCode": statusCode]
        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(dict)

            if let jsonString = String(data: jsonData, encoding: .utf8) {
                results(jsonString)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    public func didPaymentCancel() {
        let dict : Dictionary = ["Error": "Payment Cancelled"]
        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(dict)

            if let jsonString = String(data: jsonData, encoding: .utf8) {
                results(jsonString)
            }
        } catch {
            print(error.localizedDescription)
        }
    }


}