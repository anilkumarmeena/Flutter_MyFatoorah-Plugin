#import "FlutterMyfatoorahPlugin.h"
#import <flutter_myfatoorah/flutter_myfatoorah-Swift.h>

@implementation FlutterMyfatoorahPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterMyfatoorahPlugin registerWithRegistrar:registrar];
}
@end
