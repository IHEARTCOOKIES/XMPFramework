//
//  XMPReader.m
//  XMPFramework
//
//  Created by Filip Busic on 8/7/18.
//

#import "XMPReader.h"
#import "XMPReader+Private.h"

/** Attempts to read a primitive type for the specified key. */
#define READ_PRIMITIVE_FOR_KEY($key, $property, $varType, $nullifier, $meta, $accessor) ({ \
$varType *propValue = new $varType($nullifier); BOOL success = NO; \
try { success = $meta.$accessor($property.URI.UTF8String, $key.UTF8String, propValue, NULL); } catch (XMP_Error &e) { HANDLE_XMP_ERROR(e); } \
$varType returnValue = *propValue; delete propValue; \
success ? returnValue : $nullifier; })

/** Attempts to read an object for the specified key. */
#define READ_OBJECT_FOR_KEY($key, $property, $varType, $nullifier, $meta, $accessor) ({ \
$varType propValue = $nullifier; BOOL success = NO; \
try { success = $meta.$accessor($property.URI.UTF8String, $key.UTF8String, &propValue, NULL); } catch (XMP_Error &e) { HANDLE_XMP_ERROR(e); } \
success ? propValue : $nullifier; })

@interface XMPReader ()
@property (nonatomic, strong, readwrite) NSURL *filePath;
@end

@implementation XMPReader

#pragma mark - Dealloc
- (void)dealloc {
  // Terminate instances if the fileURL is valid
  if (self.filePath.isFileURL) {
    SXMPFiles::Terminate();
    SXMPMeta::Terminate();
  }
}

#pragma mark - Private Getters
- (unsigned int)XMPDefaultOpenFlags {
  return kXMPFiles_OpenForRead;
}

#pragma mark - Public Getters
- (NSData *)data {
  return [[NSFileManager defaultManager] contentsAtPath:self.filePath.path];
}

#pragma mark - Setters
- (void)setFilePath:(NSURL *)filePath {
  // Open the file
  _filePath = [self openFile:filePath] ? [filePath copy] : nil;
  
  // Close the file immediately if we're only attempting to read it, as there's no need to keep it open
  if (self.XMPDefaultOpenFlags & kXMPFiles_OpenForRead) { [self closeFile]; }
}

#pragma mark - Designated Initializer(s)
- (instancetype)initWithFilePath:(NSURL *)filePath {
  BOOL initialized = filePath.isFileURL ? SXMPMeta::Initialize() && SXMPFiles::Initialize(kXMP_NoOptions) : NO;
  if (initialized && (self = [super init])) {
    self.filePath = filePath;
  }
  return initialized ? self : nil;
}
- (instancetype)initWithData:(NSData *)data {
  NSURL *filePath = nil;
  BOOL validData = data.length > 0, writeSuccess = NO;
  if (validData) {
    filePath = [NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"XMPFramework_tmp_%.0f.innerTempXMP", [[NSDate date] timeIntervalSince1970]]]];
    NSError *error = nil;
    writeSuccess = [data writeToURL:filePath options:NSDataWritingAtomic error:&error];
    if (error) { NSLog(@"Error: %@", error); }
  }
  return writeSuccess ? [self initWithFilePath:filePath] : nil;
}

#pragma mark - Public Methods
- (BOOL)boolForKey:(NSString *)key {
  return [self boolForKey:key error:nil];
}
- (double)doubleForKey:(NSString *)key {
  return [self doubleForKey:key error:nil];
}
- (NSInteger)integerForKey:(NSString *)key {
  return [self integerForKey:key error:nil];
}
- (NSString *)stringForKey:(NSString *)key {
  return [self stringForKey:key error:nil];
}
- (BOOL)boolForKey:(NSString *)key error:(NSError *__autoreleasing *)error {
  return [self boolForKey:key withProperty:[XMPProperty propertyWithNamespaceURI:[NSString stringWithUTF8String:kXMP_NS_XMP]] error:error];
}
- (double)doubleForKey:(NSString *)key error:(NSError *__autoreleasing *)error {
  return [self doubleForKey:key withProperty:[XMPProperty propertyWithNamespaceURI:[NSString stringWithUTF8String:kXMP_NS_XMP]] error:error];
}
- (NSInteger)integerForKey:(NSString *)key error:(NSError *__autoreleasing *)error {
  return [self integerForKey:key withProperty:[XMPProperty propertyWithNamespaceURI:[NSString stringWithUTF8String:kXMP_NS_XMP]] error:error];
}
- (NSString *)stringForKey:(NSString *)key error:(NSError *__autoreleasing *)error {
  return [self stringForKey:key withProperty:[XMPProperty propertyWithNamespaceURI:[NSString stringWithUTF8String:kXMP_NS_XMP]] error:error];
}
- (BOOL)boolForKey:(NSString *)key withProperty:(XMPProperty *)property {
  return [self boolForKey:key withProperty:property error:nil];
}
- (double)doubleForKey:(NSString *)key withProperty:(XMPProperty *)property {
  return [self doubleForKey:key withProperty:property error:nil];
}
- (NSInteger)integerForKey:(NSString *)key withProperty:(XMPProperty *)property {
  return [self integerForKey:key withProperty:property error:nil];
}
- (NSString *)stringForKey:(NSString *)key withProperty:(XMPProperty *)property {
  return [self stringForKey:key withProperty:property error:nil];
}
- (BOOL)boolForKey:(NSString *)key withProperty:(XMPProperty *)property error:(NSError *__autoreleasing *)error {
  return READ_PRIMITIVE_FOR_KEY(key, property, bool, NO, _metaData, GetProperty_Bool);
}
- (double)doubleForKey:(NSString *)key withProperty:(XMPProperty *)property error:(NSError *__autoreleasing *)error {
  return READ_PRIMITIVE_FOR_KEY(key, property, double, 0, _metaData, GetProperty_Float);
}
- (NSInteger)integerForKey:(NSString *)key withProperty:(XMPProperty *)property error:(NSError *__autoreleasing *)error {
#if __LP64__ || (TARGET_OS_EMBEDDED && !TARGET_OS_IPHONE) || TARGET_OS_WIN32 || NS_BUILD_32_LIKE_64
  return READ_PRIMITIVE_FOR_KEY(key, property, XMP_Int64, 0, _metaData, GetProperty_Int64);
#else
  return READ_PRIMITIVE_FOR_KEY(key, property, XMP_Int32, 0, _metaData, GetProperty_Int);
#endif
}
- (nullable NSString *)stringForKey:(NSString *)key withProperty:(XMPProperty *)property error:(NSError *__autoreleasing *)error {
  std::string propVal = READ_OBJECT_FOR_KEY(key, property, std::string, "", _metaData, GetProperty);
  return propVal.length() > 0 ? [NSString stringWithCString:propVal.c_str() encoding:[NSString defaultCStringEncoding]] : nil;
}

#pragma mark - Private Methods
- (BOOL)openFile:(NSURL *)filePath {
  BOOL openSuccessful = NO;
  if (filePath) {
    SXMPFiles XMPFile;
    SXMPMeta meta;
    
    // First, try to open the file with read only and a smart handler
    openSuccessful = XMPFile.OpenFile(filePath.path.UTF8String, kXMP_UnknownFile, self.XMPDefaultOpenFlags | kXMPFiles_OpenUseSmartHandler);
    
    // If we failed to open the file, then try opening with packet scanning
    if (openSuccessful == NO) { openSuccessful = XMPFile.OpenFile(filePath.path.UTF8String, kXMP_UnknownFile, self.XMPDefaultOpenFlags | kXMPFiles_OpenUsePacketScanning); }
    
    // If we opened it successfully, get the XMP data. Else, print the path for the file that failed to open
    if (openSuccessful) {
      openSuccessful = XMPFile.GetXMP(&meta);
    }else{
      NSLog(@"Unable to open file for path: %@", filePath.path);
    }
    
    // Copy over variables if we opened the file successfully
    _XMPFile = openSuccessful ? XMPFile : "";
    _metaData = openSuccessful ? meta : NULL;
  }
  return openSuccessful;
}
- (void)closeFile {
  _XMPFile.CloseFile();
}

@end
