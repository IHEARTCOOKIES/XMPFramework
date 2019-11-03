//
//  XMPProperty.h
//  XMPFramework
//
//  Created by Filip Busic on 8/19/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface XMPProperty : NSObject <NSCopying>

#pragma mark - Convenience Constructor(s)

+ (nullable instancetype)propertyWithNamespaceURI:(NSString *)URI;
+ (nullable instancetype)propertyWithNamespacePrefix:(NSString *)prefix;

+ (nullable instancetype)propertyWithNamespaceURI:(NSString *)URI
                                  namespacePrefix:(NSString *)prefix;

#pragma mark - Unavailable Initializer(s)

- (nullable instancetype)init __attribute__((unavailable("Please use one of the designated initalizers.")));

#pragma mark - Initializer(s)

- (nullable instancetype)initWithNamespaceURI:(NSString *)URI;

- (nullable instancetype)initWithNamespacePrefix:(NSString *)prefix;

#pragma mark - Designated Initializer(s)

- (nullable instancetype)initWithNamespaceURI:(NSString *_Nullable)URI
                              namespacePrefix:(NSString *_Nullable)prefix NS_DESIGNATED_INITIALIZER;

#pragma mark - Instance Properties

@property (nullable, nonatomic, copy, readonly) NSString *URI;
@property (nullable, nonatomic, copy, readonly) NSString *prefix;

@property (nonatomic, assign, readonly) BOOL isValid;

@end
NS_ASSUME_NONNULL_END
