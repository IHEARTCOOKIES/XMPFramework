//
//  XMPReader.m
//  XMPFramework
//
//  Created by Filip Busic on 8/7/18.
//

#import "XMPReader.h"
#import "AdobeXMPToolKit.h"

#define CHECK_IF_FILE_OPENED($returnVal) if (self.fileOpen == NO) { NSLog(@"The file: %@ was not open for reading/writing. Please make sure that `XMPReader:fileOpen` is equal to `YES` before calling any methods that requires the file to be opened.", self.filePath); return $returnVal; }

#define VERIFY_XMP_DATA($BOOL, $returnValue) if ($BOOL == NO) { NSLog(@"The current opened file has no XMP data available."); return $returnValue; }

@interface XMPReader ()
@property (nonatomic, copy, readwrite) NSURL *filePath;
@end

@implementation XMPReader {
  SXMPFiles _XMPFile;
}

#pragma mark - Dealloc
- (void)dealloc {
  // Close if opened
  _XMPFile.CloseFile();
  
  // Terminate instances
  SXMPFiles::Terminate();
  SXMPMeta::Terminate();
}

#pragma mark - Getters
- (NSData *)data {
  return [[NSFileManager defaultManager] contentsAtPath:self.filePath.path];
}

#pragma mark - Setters
- (void)setFilePath:(NSURL *)filePath {
  _filePath = filePath;
  if (filePath) { self.fileOpen = YES; }
  else{ self.fileOpen = NO; }
}
- (void)setFileOpen:(BOOL)fileOpen {
  if (self.filePath == nil) { NSLog(@"Unable to open file for path: %@", self.filePath.path); return; }
  if (fileOpen) {
    // First, try to open the file with read only and a smart handler
    BOOL openedFileSuccess = _XMPFile.OpenFile(self.filePath.path.UTF8String, kXMP_UnknownFile, kXMPFiles_OpenForRead | kXMPFiles_OpenUseSmartHandler);
    
    // If we failed to open the file by using the options above, try opening with packet scanning
    if (openedFileSuccess == NO) {
      openedFileSuccess = _XMPFile.OpenFile(self.filePath.path.UTF8String, kXMP_UnknownFile, kXMPFiles_OpenForUpdate | kXMPFiles_OpenUsePacketScanning);
    }
    if (openedFileSuccess == NO) { NSLog(@"Unable to open file for path: %@", self.filePath.path); }
    _fileOpen = openedFileSuccess;
  }else{
    _fileOpen = fileOpen;
    _XMPFile.CloseFile();
  }
}

#pragma mark - Designated Initializer(s)
- (instancetype)initWithFilePath:(NSURL *)filePath {
  BOOL initialized = SXMPMeta::Initialize() && SXMPFiles::Initialize(kXMP_NoOptions);
  if (initialized && (self = [super init])) {
    self.filePath = filePath;
  }
  return initialized && self.fileOpen ? self : nil;
}
- (instancetype)initWithData:(NSData *)data {
  NSURL *filePath = [NSURL URLWithString:[NSTemporaryDirectory() stringByAppendingString:[NSString stringWithFormat:@"XMPFramework_tmp_%.0f.innerTempXMP", [[NSDate date] timeIntervalSince1970]]]];
  BOOL writeSuccess = [data writeToURL:filePath atomically:YES];
  return writeSuccess ? [self initWithFilePath:filePath] : nil;
}

#pragma mark - Public Methods
- (NSString *)stringForKey:(NSString *)key {
  return [self stringForKey:key withPropertyName:[NSString stringWithUTF8String:kXMP_NS_XMP]];
}
- (NSString *)stringForKey:(NSString *)key withPropertyName:(NSString *)propertyName {
  CHECK_IF_FILE_OPENED(nil);
  std::string propertyValue = "";
  BOOL success = NO;
  try {
    // Create the xmp object and get the xmp data
    SXMPMeta meta;
    BOOL XMPExists = _XMPFile.GetXMP(&meta);
    VERIFY_XMP_DATA(XMPExists, nil);
    success = meta.GetProperty(propertyName.UTF8String, key.UTF8String, &propertyValue, NULL);
  } catch (XMP_Error & e) {
    NSLog(@"Read error: %s", e.GetErrMsg());
  }
  NSString *stringValue = [NSString stringWithCString:propertyValue.c_str() encoding:[NSString defaultCStringEncoding]];
  return success ? stringValue : nil;
}

#ifdef DEBUG
#pragma mark - Debug Methods
- (void)dumpXMPData {
  CHECK_IF_FILE_OPENED();
  SXMPMeta meta;
  BOOL XMPExists = _XMPFile.GetXMP(&meta);
  VERIFY_XMP_DATA(XMPExists, void());
  meta.DumpObject(DumpCallback, stdout);
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
