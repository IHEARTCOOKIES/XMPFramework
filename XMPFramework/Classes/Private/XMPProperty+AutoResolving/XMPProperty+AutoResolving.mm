//
//  XMPProperty+AutoResolving.m
//  XMPFramework
//
//  Created by Filip Busic on 8/25/18.
//

#import "XMPProperty+AutoResolving.h"
#import "XMPProperty+Private.h"

@implementation XMPProperty (AutoResolving)

#pragma mark - Public Methods
- (BOOL)resolvePropertyInfoFromMeta:(SXMPMeta &)meta withError:(NSError *__autoreleasing *)error {
  BOOL resolvedSuccessfully = NO;
  
  std::string URI = self.URI.UTF8String ?: "";
  std::string prefix = self.prefix.UTF8String ?: "";
  
  // Try to resolve the URI if needed
  if (prefix.length() > 0 && URI.length() == 0) {
    try {
      meta.GetNamespaceURI(prefix.c_str(), &URI);
      self.URI = [NSString stringWithUTF8String:URI.c_str()];
    } catch (XMP_Error &e) {
      if (error) {
        *error = [NSError errorWithDomain:[NSBundle mainBundle].bundleIdentifier
                                     code:XMPFrameworkErrorCodeNamespaceURIFailedToResolve
                                 userInfo:@{NSLocalizedDescriptionKey:[NSString stringWithFormat:@"Internal XMP Error: %s", e.GetErrMsg()]}];
      }
    }
  }
  
  // Try to resolve the prefix if needed
  if (URI.length() > 0 && prefix.length() == 0) {
    try {
      meta.GetNamespacePrefix(URI.c_str(), &prefix);
      self.prefix = [NSString stringWithUTF8String:prefix.c_str()];
    } catch (XMP_Error &e) {
      if (error) {
        *error = [NSError errorWithDomain:[NSBundle mainBundle].bundleIdentifier
                                     code:XMPFrameworkErrorCodeNamespacePrefixFailedToResolve
                                 userInfo:@{NSLocalizedDescriptionKey:[NSString stringWithFormat:@"Internal XMP Error: %s", e.GetErrMsg()]}];
      }
    }
  }
  
  // Try to register them if they're not registered and our inputs are valid
  if (prefix.length() > 0 && URI.length() > 0) {
    if ((resolvedSuccessfully = (meta.GetNamespaceURI(prefix.c_str(), &URI) &&
                                 meta.GetNamespacePrefix(URI.c_str(), &prefix))) == NO) {
      if ((resolvedSuccessfully = meta.RegisterNamespace(URI.c_str(), prefix.c_str(), &prefix))) {
        // Update our prefix with the suggested namespace returned from `RegisterNamespace:`
        self.prefix = [NSString stringWithUTF8String:prefix.c_str()];
      }else{
        if (error) {
          *error = [NSError errorWithDomain:[NSBundle mainBundle].bundleIdentifier
                                       code:XMPFrameworkErrorCodeNamespaceFailedToRegister
                                   userInfo:@{NSLocalizedDescriptionKey:[NSString stringWithFormat:@"We tried to register namespace: %@ for prefix: %@ but failed.", self.URI, self.prefix]}];
        }
      }
    }
  }else{
    if (error) {
      *error = [NSError errorWithDomain:[NSBundle mainBundle].bundleIdentifier
                                   code:XMPFrameworkErrorCodeNamespaceInvalid
                               userInfo:@{NSLocalizedDescriptionKey:@"The prefix or URI was invalid."}];
    }
  }
  
  return resolvedSuccessfully;
}

@end
