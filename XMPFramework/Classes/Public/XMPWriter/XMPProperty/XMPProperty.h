//
//  XMPProperty.h
//  XMPFramework
//
//  Created by Filip Busic on 8/19/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface XMPProperty : NSObject

- (instancetype _Nullable)init __attribute__((unavailable("Please use one of the designated initalizers.")));

- (instancetype)initWithNamespaceURI:(NSString *)URI;

- (instancetype)initWithNamespacePrefix:(NSString *)prefix;

- (instancetype)initWithNamespaceURI:(NSString *)URI
                     namespacePrefix:(NSString *_Nullable)prefix NS_DESIGNATED_INITIALIZER;

+ (instancetype)propertyWithNamespaceURI:(NSString *)URI;
+ (instancetype)propertyWithNamespacePrefix:(NSString *)prefix;

+ (instancetype)propertyWithNamespaceURI:(NSString *)URI
                         namespacePrefix:(NSString *_Nullable)prefix;

@property (nullable, nonatomic, copy, readonly) NSString *URI;
@property (nullable, nonatomic, copy, readonly) NSString *prefix;

@end
NS_ASSUME_NONNULL_END
