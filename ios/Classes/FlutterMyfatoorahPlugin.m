#import "FlutterMyfatoorahPlugin.h"
#import <MFSDK/MFSDK-Swift.h>

@implementation FlutterMyfatoorahPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {

  [[MFSettings shared] configureWithUsername:@"apiaccount@myfatoorah.com" password:@"api12345*" baseURL:@"https://apidemo.myfatoorah.com/"];
    
    // you can change color and title of nvgigation bar
    MFTheme* theme = [[MFTheme alloc] initWithNavigationTintColor:[UIColor whiteColor] navigationBarTintColor:[UIColor lightGrayColor] navigationTitle:@"Payment" cancelButtonTitle:@"Cancel"];
    [[MFSettings shared] setThemeWithTheme:theme];
    
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"flutter_myfatoorah"
            binaryMessenger:[registrar messenger]];
  FlutterMyfatoorahPlugin* instance = [[FlutterMyfatoorahPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"payment" isEqualToString:call.method]) {
    [self pay];
    result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
  } else {
    result(FlutterMethodNotImplemented);
  }
}

- (void) pay{
    [[MFInvoiceCreateStatus shared] setDelegate:self];
    double invoiceValue = 20.0;
    MFInvoice* invoice = [[MFInvoice alloc] initWithInvoiceValue:invoiceValue customerName: @"Test" countryCode: MFCountryKuwait displayCurrency:MFCurrencyKuwaiti_Dinar_KWD];
    invoice.customerEmail = @"a@b.com";// must be email
    invoice.customerMobile = @"mobile no";//Required
    invoice.customerCivilId = @"";
    invoice.customerBlock = @"";
    invoice.customerStreet = @"";
    invoice.customerHouseBuildingNo = @"";
    invoice.customerReference = @"";
    invoice.language = MFLanguageEnglish;
    invoice.sendInvoiceOption = MFInvoiceOptionSms;
    [[MFPaymentRequest shared] createInvoiceWithInvoice:invoice paymentMethod:MFPaymentMethodKnet apiLanguage:MFAPILanguageArabic];
}


- (void)didInvoiceCreateFailWithError:(MFFailResponse * _Nonnull)error { 
   // _errorCodeLabel.text = [NSString stringWithFormat:@"responseCode: %ld", (long)error.statusCode];
    // _textView.text = [NSString stringWithFormat:@"Error: %@", error.errorDescription];
}

- (void)didInvoiceCreateSucessWithTransaction:(MFTransaction * _Nonnull)transaction { 
   // _errorCodeLabel.text = @"Success";
    // _textView.text = [NSString stringWithFormat:@"result: %@", transaction];
}

- (void)didPaymentCancel { 
    //_errorCodeLabel.text = @"responseCode: -1";
    // _textView.text = @"Error: Payment Cancelled";
}
@end


