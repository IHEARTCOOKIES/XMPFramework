//
//  XMPWriter.m
//  XMPFramework
//
//  Created by Filip Busic on 8/11/18.
//

#import "XMPWriter.h"
#import "XMPWriter+Private.h"
#import "XMPReader+Private.h"
#import "XMPProperty+Private.h"
#import "XMPProperty+AutoResolving.h"

#warning don't forget to switch this to common NSError handling future logic
#define HANDLE_XMP_ERROR($e) if (error) { *error = [NSError errorWithDomain:[NSBundle mainBundle].bundleIdentifier code:100 userInfo:@{NSLocalizedDescriptionKey:[NSString stringWithFormat:@"Error: %s", $e.GetErrMsg()]}]; }

@implementation XMPWriter

#pragma mark - Private Getters
- (unsigned int)XMPDefaultOpenFlags {
  return kXMPFiles_OpenForUpdate;
}

#pragma mark - Public Methods
- (BOOL)setBool:(BOOL)value forKey:(NSString *)key {
  return [self setObject:@(value) forKey:key];
}
- (BOOL)setDouble:(double)value forKey:(NSString *)key {
  return [self setObject:@(value) forKey:key];
}
- (BOOL)setInteger:(NSInteger)value forKey:(NSString *)key {
  return [self setObject:@(value) forKey:key];
}
- (BOOL)setString:(NSString *)value forKey:(NSString *)key {
  return [self setObject:value forKey:key];
}
- (BOOL)setBool:(BOOL)value forKey:(NSString *)key error:(NSError *__autoreleasing *)error {
  return [self setObject:@(value) forKey:key error:error];
}
- (BOOL)setDouble:(double)value forKey:(NSString *)key error:(NSError *__autoreleasing *)error {
  return [self setObject:@(value) forKey:key error:error];
}
- (BOOL)setInteger:(NSInteger)value forKey:(NSString *)key error:(NSError *__autoreleasing *)error {
  return [self setObject:@(value) forKey:key error:error];
}
- (BOOL)setString:(NSString *)value forKey:(NSString *)key error:(NSError *__autoreleasing *)error {
  return [self setObject:value forKey:key error:error];
}
- (BOOL)setBool:(BOOL)value forKey:(NSString *)key withProperty:(XMPProperty *)property {
  return [self setObject:@(value) forKey:key withProperty:property];
}
- (BOOL)setDouble:(double)value forKey:(NSString *)key withProperty:(XMPProperty *)property {
  return [self setObject:@(value) forKey:key withProperty:property];
}
- (BOOL)setInteger:(NSInteger)value forKey:(NSString *)key withProperty:(XMPProperty *)property {
  return [self setObject:@(value) forKey:key withProperty:property];
}
- (BOOL)setString:(NSString *)value forKey:(NSString *)key withProperty:(XMPProperty *)property {
  return [self setObject:value forKey:key withProperty:property];
}
- (BOOL)setBool:(BOOL)value forKey:(NSString *)key withProperty:(XMPProperty *)property error:(NSError *__autoreleasing *)error {
  return [self setObject:@(value) forKey:key withProperty:property error:error];
}
- (BOOL)setDouble:(double)value forKey:(NSString *)key withProperty:(XMPProperty *)property error:(NSError *__autoreleasing *)error {
  return [self setObject:@(value) forKey:key withProperty:property error:error];
}
- (BOOL)setInteger:(NSInteger)value forKey:(NSString *)key withProperty:(XMPProperty *)property error:(NSError *__autoreleasing *)error {
  return [self setObject:@(value) forKey:key withProperty:property error:error];
}
- (BOOL)setString:(NSString *)value forKey:(NSString *)key withProperty:(XMPProperty *)property error:(NSError *__autoreleasing *)error {
  return [self setObject:value forKey:key withProperty:property error:error];
}
- (BOOL)synchronize {
  // 1. Close the file to save the changes to disk
  [self closeFile];
  
  // 2. Reopen the file
  return [self openFile:self.filePath];
}

#pragma mark - Private Methods
- (BOOL)setObject:(NSObject *)value forKey:(NSString *)key {
  return [self setObject:value forKey:key error:nil];
}
- (BOOL)setObject:(NSObject *)value forKey:(NSString *)key error:(NSError *__autoreleasing *)error {
  return [self setObject:value forKey:key withProperty:[XMPProperty propertyWithNamespaceURI:[NSString stringWithUTF8String:kXMP_NS_XMP]] error:error];
}
- (BOOL)setObject:(NSObject *)value forKey:(NSString *)key withProperty:(XMPProperty *)property {
  return [self setObject:value forKey:key withProperty:property error:nil];
}
- (BOOL)setObject:(NSObject *)value forKey:(NSString *)key withProperty:(XMPProperty *)property error:(NSError *__autoreleasing *)error {
#warning not threadsafe... think about global/local mutex locks to solve this problem.
  
  SXMPMeta meta = _metaData;
  if ([property resolvePropertyInfoFromMeta:meta withError:error] == NO) {
#warning fix copy
    *error = [NSError errorWithDomain:[NSBundle mainBundle].bundleIdentifier
                                 code:100
                             userInfo:@{NSLocalizedDescriptionKey:@"The XMPProperty object was invalid. Please double check that you're using a valid URI/Prefix value."}];
    return NO; }
  
  // Set the value accordingly
  if ([value isKindOfClass:[NSNumber class]]) {
    NSNumber *num = (NSNumber *)value;
    const char *objCType = num.objCType;
    if (strcasecmp(objCType, @encode(typeof(Boolean))) == 0 ||
        strcasecmp(objCType, @encode(typeof(BOOL))) == 0 ||
        strcasecmp(objCType, @encode(typeof(bool))) == 0) {
      try {
        meta.SetProperty_Bool(property.URI.UTF8String, key.UTF8String, num.boolValue);
      } catch (XMP_Error &e) { HANDLE_XMP_ERROR(e); }
    }else if (strcasecmp(objCType, @encode(typeof(double))) == 0) {
      try {
        meta.SetProperty_Float(property.URI.UTF8String, key.UTF8String, num.doubleValue);
      } catch (XMP_Error &e) { HANDLE_XMP_ERROR(e); }
    }else if (strcasecmp(objCType, @encode(typeof(NSInteger))) == 0 ||
              strcasecmp(objCType, @encode(typeof(int))) == 0 ||
              strcasecmp(objCType, @encode(typeof(NSUInteger))) == 0) {
#if __LP64__ || (TARGET_OS_EMBEDDED && !TARGET_OS_IPHONE) || TARGET_OS_WIN32 || NS_BUILD_32_LIKE_64
      try {
        meta.SetProperty_Int64(property.URI.UTF8String, key.UTF8String, num.integerValue);
      } catch (XMP_Error &e) { HANDLE_XMP_ERROR(e); }
#else
      try {
        meta.SetProperty_Int(property.URI.UTF8String, key.UTF8String, num.integerValue);
      } catch (XMP_Error &e) { HANDLE_XMP_ERROR(e); }
#endif
    }else{
#warning implement proper error codes
      if (error) {
        *error = [NSError errorWithDomain:[NSBundle mainBundle].bundleIdentifier
                                     code:415
                                 userInfo:@{NSLocalizedDescriptionKey:[NSString stringWithFormat:@"The value type (%s) was not supported by: %@", objCType, [XMPWriter class]]}];
      }
    }
  }else if ([value isKindOfClass:[NSString class]]) {
    try {
      meta.SetProperty(property.URI.UTF8String, key.UTF8String, ((NSString *)value).UTF8String);
    } catch (XMP_Error &e) { HANDLE_XMP_ERROR(e); }
  }else{
#warning implement proper error codes
    *error = [NSError errorWithDomain:[NSBundle mainBundle].bundleIdentifier
                                 code:416
                             userInfo:@{NSLocalizedDescriptionKey:[NSString stringWithFormat:@"The value class (%@) was not supported by: %@", [value class], [XMPWriter class]]}];
  }
  
  BOOL setSuccessfully = _XMPFile.CanPutXMP(meta);
  if (setSuccessfully) {
#warning this only helps the saving bit... But if 3 threads have different info, the file will jump to all different conclusions, and not be properly thread safe
    @synchronized (self) { _XMPFile.PutXMP(meta); _metaData = meta; }
  }else{
    NSLog(@"Can't update!!!");
#warning implement proper error codes
    *error = [NSError errorWithDomain:[NSBundle mainBundle].bundleIdentifier
                                 code:100
                             userInfo:@{NSLocalizedDescriptionKey:[NSString stringWithFormat:@"Failed to set key: %@ for value: %@. The XMP file couldn't be updated for path: %@.", key, value, self.filePath]}];
  }
  
  return setSuccessfully && error ? *error == nil : YES;
}

@end
