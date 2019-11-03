//
//  XMPReader+Private.h
//  XMPFramework
//
//  Created by Filip Busic on 8/18/18.
//

#import "XMPReader.h"
#import "AdobeXMPToolKit.h"

NS_PROTOCOL_REQUIRES_EXPLICIT_IMPLEMENTATION
@protocol XMPReaderProtocol <NSObject>
@property (nonatomic, assign, readonly) unsigned int XMPDefaultOpenFlags;
- (BOOL)openFile:(NSURL *)filePath;
- (void)closeFile;
@end

@interface XMPReader () <XMPReaderProtocol> {
  @protected
  SXMPFiles _XMPFile;
  SXMPMeta _metaData;
}
@end
