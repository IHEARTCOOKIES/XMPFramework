//
//  XMPProperty+AutoResolving.h
//  XMPFramework
//
//  Created by Filip Busic on 8/25/18.
//

#import "XMPProperty.h"
#import "AdobeXMPToolKit.h"

@interface XMPProperty (AutoResolving)
- (BOOL)resolvePropertyInfoFromMeta:(SXMPMeta &)meta withError:(NSError *__autoreleasing *)error;
@end
