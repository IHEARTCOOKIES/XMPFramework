//
//  XMPReader.m
//  XMPFramework
//
//  Created by Filip Busic on 8/7/18.
//

#import "XMPReader.h"
#import "XMPReader+Private.h"

@interface XMPReader ()
@property (nonatomic, strong, readwrite) NSURL *filePath;
@end

@implementation XMPReader {
  SXMPFiles _XMPFile;
  SXMPMeta _metaData;
}

#pragma mark - Dealloc
- (void)dealloc {
  // Terminate instances
  SXMPFiles::Terminate();
  SXMPMeta::Terminate();
}

#pragma mark - Private Getters
- (unsigned int)XMPDefaultOpenFlags {
  return kXMPFiles_OpenForRead | kXMPFiles_OpenUseSmartHandler;
}

#pragma mark - Public Getters
- (NSData *)data {
  return [[NSFileManager defaultManager] contentsAtPath:self.filePath.path];
}

#pragma mark - Setters
- (void)setFilePath:(NSURL *)filePath {
  // Open the file
  _filePath = [self openFile:filePath] ? [filePath copy] : nil;
  
  // Close the file immediately if we're a reader, as there's no need to keep it open
  if ([self class] == [XMPReader class]) { [self closeFile]; }
}

#pragma mark - Designated Initializer(s)
- (instancetype)initWithFilePath:(NSURL *)filePath {
  BOOL initialized = SXMPMeta::Initialize() && SXMPFiles::Initialize(kXMP_NoOptions);
  if (initialized && (self = [super init])) {
    self.filePath = filePath;
  }
  return initialized ? self : nil;
}
- (instancetype)initWithData:(NSData *)data {
  NSURL *filePath = [NSURL URLWithString:[NSTemporaryDirectory() stringByAppendingString:[NSString stringWithFormat:@"XMPFramework_tmp_%.0f.innerTempXMP", [[NSDate date] timeIntervalSince1970]]]];
  BOOL writeSuccess = [data writeToURL:filePath atomically:YES];
  return writeSuccess ? [self initWithFilePath:filePath] : nil;
}

#pragma mark - Private Methods
- (BOOL)openFile:(NSURL *)filePath {
  BOOL openSuccessful = NO;
  if (filePath) {
    SXMPFiles XMPFile;
    SXMPMeta meta;
    
    // First, try to open the file with read only and a smart handler
    openSuccessful = XMPFile.OpenFile(filePath.path.UTF8String, kXMP_UnknownFile, self.XMPDefaultOpenFlags);
    
    // If we failed to open the file by using the options above, try opening with packet scanning
    if (openSuccessful == NO) { openSuccessful = XMPFile.OpenFile(filePath.path.UTF8String, kXMP_UnknownFile, kXMPFiles_OpenForUpdate | kXMPFiles_OpenUsePacketScanning); }
    
    // If we opened it successfully, get the XMP data. Else, print the path for the file that failed to open
    if (openSuccessful) {
      openSuccessful = XMPFile.GetXMP(&meta);
    }else{
      NSLog(@"Unable to open file for path: %@", filePath.path);
    }
    
    // Copy over variables if the opening was succssful
    _XMPFile = openSuccessful ? XMPFile : "";
    _metaData = openSuccessful ? meta : nil;
  }
  return openSuccessful;
}
- (void)closeFile {
  _XMPFile.CloseFile();
}

#pragma mark - Public Methods
- (NSString *)stringForKey:(NSString *)key {
  return [self stringForKey:key withPropertyName:[NSString stringWithUTF8String:kXMP_NS_XMP]];
}
- (NSString *)stringForKey:(NSString *)key withPropertyName:(NSString *)propertyName {
  std::string propertyValue = "";
  BOOL success = NO;
  try {
    // Create the xmp object and get the xmp data
    success = _metaData.GetProperty(propertyName.UTF8String, key.UTF8String, &propertyValue, NULL);
  } catch (XMP_Error &e) {
    NSLog(@"Read error: %s", e.GetErrMsg());
  }
  return success ? [NSString stringWithCString:propertyValue.c_str() encoding:[NSString defaultCStringEncoding]] : nil;
}

#ifdef DEBUG
#pragma mark - Debug Methods
- (void)dumpXMPData {
  _metaData.DumpObject(DumpCallback, stdout);
}

#pragma mark - Dump XMP Data Callback
static XMP_Status DumpCallback(void * refCon, XMP_StringPtr outStr, XMP_StringLen outLen) {
  XMP_Status status = 0;
  FILE *outFile = static_cast<FILE *>(refCon);
  size_t count = fwrite (outStr, 1, outLen, outFile);
  if (count != outLen) { status = errno; }
  return status;
}
#endif

@end
