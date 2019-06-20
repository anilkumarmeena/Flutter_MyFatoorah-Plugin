#import "FlutterMyfatoorahPlugin.h"
#import <flutter_myfatoorah/flutter_myfatoorah-Swift.h>

@implementation FlutterMyfatoorahPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterMyfatoorahPlugin registerWithRegistrar:registrar];
}
@end

// #import "FlutterMyfatoorahPlugin.h"
// #import <MFSDK/MFSDK-Swift.h>

// FlutterEventSink sink;

// @implementation FlutterMyfatoorahPlugin
// + (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
//   [[MFSettings shared] configureWithUsername:@"apiaccount@myfatoorah.com" password:@"api12345*" baseURL:@"https://apidemo.myfatoorah.com/"];
//     // you can change color and title of nvgigation bar
//     MFTheme* theme = [[MFTheme alloc] initWithNavigationTintColor:[UIColor whiteColor] navigationBarTintColor:[UIColor lightGrayColor] navigationTitle:@"Payment" cancelButtonTitle:@"Cancel"];
//     [[MFSettings shared] setThemeWithTheme:theme];
    
//   FlutterMyfatoorahPlugin* payStreamHandler =
//       [[FlutterMyfatoorahPlugin alloc] init];

//   FlutterEventChannel* payChannel =
//       [FlutterEventChannel eventChannelWithName:@"paymentStream"
//                                 binaryMessenger:[registrar messenger]];
//   [payChannel setStreamHandler:payStreamHandler];

//   FlutterMethodChannel* channel = [FlutterMethodChannel
//       methodChannelWithName:@"flutter_myfatoorah"
//             binaryMessenger:[registrar messenger]];
//   FlutterMyfatoorahPlugin* instance = [[FlutterMyfatoorahPlugin alloc] init];
//   [registrar addMethodCallDelegate:instance channel:channel];
// }

// - (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
//   if ([@"payment" isEqualToString:call.method]) {
//       BOOL language = call.arguments[@"lang"];
//       NSString *name = call.arguments[@"name"];
//       NSNumber *price = call.arguments[@"price"];
//     [self pay: price:name:language];
//     result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
//   } else {
//     result(FlutterMethodNotImplemented);
//   }
// }

// - (void) pay:  (NSNumber *) mprice :(NSString *) mname : (BOOL)lang{
//     [[MFInvoiceCreateStatus shared] setDelegate:self];
//     double invoiceValue = [mprice doubleValue]; 
//     MFInvoice* invoice = [[MFInvoice alloc] initWithInvoiceValue:invoiceValue customerName: mname countryCode: MFCountryKuwait displayCurrency:MFCurrencyKuwaiti_Dinar_KWD];
//     invoice.customerEmail = @"a@b.com";// must be email
//     invoice.customerMobile = @"mobile no";//Required
//     invoice.customerCivilId = @"";
//     invoice.customerBlock = @"";
//     invoice.customerStreet = @"";
//     invoice.customerHouseBuildingNo = @"";
//     invoice.customerReference = @"";
//     invoice.language = MFLanguageEnglish;
//     invoice.sendInvoiceOption = MFInvoiceOptionSms;
//     [[MFPaymentRequest shared] createInvoiceWithInvoice:invoice paymentMethod:MFPaymentMethodKnet apiLanguage:MFAPILanguageArabic];
// }

// - (void)didInvoiceCreateFailWithError:(MFFailResponse * _Nonnull)error { 
//    sink([NSString stringWithFormat:@"Error: %@", error.errorDescription]);
// }

// - (void)didInvoiceCreateSucessWithTransaction:(MFTransaction * _Nonnull)transaction { 
//     NSDictionary *dict = [self dictionaryWithPropertiesOfObject: details];
//     NSLog(@"%@", dict);
//     sink([NSString stringWithFormat:@"result: %@", transaction]);
// }

// - (void)didPaymentCancel { 
//     sink(@"Error: Payment Cancelled");
// }

// - (FlutterError*)onListenWithArguments:(id)arguments eventSink:(FlutterEventSink)eventSink {
//       sink = eventSink;
//   return nil;
// }

// - (FlutterError*)onCancelWithArguments:(id)arguments {
//   return nil;
// }
// @end




