//
//  XMPWriter.m
//  XMPFramework
//
//  Created by Filip Busic on 8/11/18.
//

#import "XMPWriter.h"
#import "XMPReader+Private.h"
#import "XMPProperty+Private.h"

#warning A lot more setters exist... Check out SetPropertyDate, SetPropertyInt, etc.

#define CHECK_IF_FILE_OPENED($returnVal) if (self.fileOpen == NO) { NSLog(@"The file: %@ was not open for reading/writing. Please make sure that `XMPReader:fileOpen` is equal to `YES` before calling any methods that requires the file to be opened.", self.filePath); return $returnVal; }


#define IS_VALID_NSSTRING(property) (property != nil && [property isKindOfClass:[NSString class]] && [property stringByReplacingOccurrencesOfString:@" " withString:@""].length > 0 )

@implementation XMPWriter

//#pragma mark - Private Getters
//- (unsigned int)XMPDefaultOpenFlags {
//  return kXMPFiles_OpenForUpdate | kXMPFiles_OpenUseSmartHandler;
//}
//
//#pragma mark - Public Methods
//- (void)setString:(NSString *)string forKey:(NSString *)key {
//  [self setString:string forKey:key withProperty:[XMPProperty propertyWithNamespaceURI:[NSString stringWithUTF8String:kXMP_NS_XMP]]];
//}
//- (void)setString:(NSString *)string forKey:(NSString *)key withProperty:(XMPProperty *)property {
//  CHECK_IF_FILE_OPENED();
//  
//  BOOL success = NO;
//  try {
//    // Create the xmp object and get the xmp data
//    SXMPMeta meta;
//    BOOL XMPExists = _XMPFile.GetXMP(&meta);
//    
//    std::string URI = property.URI.UTF8String ?: "";
//    
//    // Try to resolve the URI
//    if (IS_VALID_NSSTRING(property.prefix) && IS_VALID_NSSTRING(property.URI) == NO) {
//      meta.GetNamespaceURI(property.prefix.UTF8String, &URI);
//      property.URI = [NSString stringWithUTF8String:URI.c_str()];
//    }
//    
//    std::string prefix = property.prefix.UTF8String ?: "";
//    
//    // Try to resolve the prefix
//    if (IS_VALID_NSSTRING(property.URI) && IS_VALID_NSSTRING(property.prefix) == NO) {
//      meta.GetNamespacePrefix(property.URI.UTF8String, &prefix);
//      property.prefix = [NSString stringWithUTF8String:prefix.c_str()];
//    }
//    
//    BOOL URIRegistered = meta.GetNamespaceURI(property.prefix.UTF8String, &URI);
//    BOOL prefixRegistered = meta.GetNamespacePrefix(property.URI.UTF8String, &prefix);
//    
////    if (nameSpacePrefix.length() <= 0 || nameSpacePrefix != property.prefix.UTF8String) {
////      NSLog(@"Failed to set: %@ for key: %@. Reason: Use `setString:forKey:propertyName:prefix:` when you're trying to add a value for a non-existing namespace.", string, key);
////      return;
////    }
//    
//    if ((URIRegistered && prefixRegistered) == NO) {
//      
//      if (IS_VALID_NSSTRING(property.prefix) == NO || IS_VALID_NSSTRING(property.URI) == NO) {
//#warning either are invalid... can't register namespace
//        NSLog(@"");
//        return;
//      }
//      
//      std::string registeredPrefix = "";
//      BOOL registeredSuccessfully = meta.RegisterNamespace(URI.c_str(), prefix.c_str(), &registeredPrefix);
//      property.prefix = [NSString stringWithUTF8String:registeredPrefix.c_str()];
//      
//      if (registeredSuccessfully == NO) {
//        NSLog(@"We tried to recover and register namespace: %@ for prefix: %@ but failed. Please try again with a proper namespace/prefix.", property.URI, property.prefix);
//      }
//    }
//    
//    meta.SetProperty(URI.c_str(), key.UTF8String, string.UTF8String);
//    
//    BOOL canUpdate = _XMPFile.CanPutXMP(meta);
//    
//    if (canUpdate) {
//      _XMPFile.PutXMP(meta);
//    }else{
//      NSLog(@"Can't update!!!");
//    }
//    
//  } catch (XMP_Error &e) {
//    NSLog(@"Read error: %s", e.GetErrMsg());
//  }
//}
//- (BOOL)synchronize {
//  // 1. Close the file to save the changes to disk
//  self.fileOpen = NO;
//  
//  // 2. Reopen the file
//  self.fileOpen = YES;
//  
//  return self.fileOpen;
//}

@end
