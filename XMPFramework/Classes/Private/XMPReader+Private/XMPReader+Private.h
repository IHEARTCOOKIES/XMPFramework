//
//  XMPReader+Private.h
//  XMPFramework
//
//  Created by Filip Busic on 8/18/18.
//

#import "AdobeXMPToolKit.h"

#define VERIFY_XMP_DATA($BOOL, $returnValue) if ($BOOL == NO) { NSLog(@"The current opened file has no XMP data available."); return $returnValue; }

NS_PROTOCOL_REQUIRES_EXPLICIT_IMPLEMENTATION
@protocol XMPReaderProtocol <NSObject>
@property (nonatomic, assign, readonly) unsigned int XMPDefaultOpenFlags;
@end

@interface XMPReader () <XMPReaderProtocol> {
  @protected
//  SXMPFiles _XMPFile;
}
@end
