//
//  XMPReader.h
//  XMPFramework
//
//  Created by Filip Busic on 8/7/18.
//

#import <Foundation/Foundation.h>
#import <XMPFramework/XMPProperty.h>

NS_ASSUME_NONNULL_BEGIN
@interface XMPReader : NSObject

/** Unavailable initializer(s). */
- (instancetype)init __attribute__((unavailable("Please use one of the designated initializers.")));

/**
 Designated initializer that'll open the file provided through the `filePath` parameter.
 
 @param filePath The path to the file.
 @return Returns a valid instance if the file could be opened.
 */
- (nullable instancetype)initWithFilePath:(NSURL *)filePath NS_DESIGNATED_INITIALIZER;

/** Equivalent to calling saving the data to a temporary location and calling `initWithFilePath:`. */
- (nullable instancetype)initWithData:(NSData *)data;

#pragma mark - Get Value For Key Methods

- (BOOL)boolForKey:(NSString *)key;
- (double)doubleForKey:(NSString *)key;
- (NSInteger)integerForKey:(NSString *)key;
- (nullable NSString *)stringForKey:(NSString *)key;

#pragma mark - Get Value For Key w/ Error Methods

- (BOOL)boolForKey:(NSString *)key error:(NSError *_Nullable __autoreleasing *)error;
- (double)doubleForKey:(NSString *)key error:(NSError *_Nullable __autoreleasing *)error;
- (NSInteger)integerForKey:(NSString *)key error:(NSError *_Nullable __autoreleasing *)error;
- (nullable NSString *)stringForKey:(NSString *)key error:(NSError *_Nullable __autoreleasing *)error;

#pragma mark - Get Value For Key w/ XMPProperty Methods

- (BOOL)boolForKey:(NSString *)key withProperty:(XMPProperty *)property;
- (double)doubleForKey:(NSString *)key withProperty:(XMPProperty *)property;
- (NSInteger)integerForKey:(NSString *)key withProperty:(XMPProperty *)property;
- (nullable NSString *)stringForKey:(NSString *)key withProperty:(XMPProperty *)property;

#pragma mark - Get Value For Key w/ XMPProperty & Error Methods

- (BOOL)boolForKey:(NSString *)key withProperty:(XMPProperty *)property error:(NSError *_Nullable __autoreleasing *)error;
- (double)doubleForKey:(NSString *)key withProperty:(XMPProperty *)property error:(NSError *_Nullable __autoreleasing *)error;
- (NSInteger)integerForKey:(NSString *)key withProperty:(XMPProperty *)property error:(NSError *_Nullable __autoreleasing *)error;
- (nullable NSString *)stringForKey:(NSString *)key withProperty:(XMPProperty *)property error:(NSError *_Nullable __autoreleasing *)error;

/** A NSData representation of the file that we're referencing. */
@property (nonnull, nonatomic, copy, readonly) NSData *data;

/** A reference to the file that we initialized with. If the `initWithData:` initializer was used, this will point to a temporary file. */
@property (nonnull, nonatomic, strong, readonly) NSURL *filePath;

@end
NS_ASSUME_NONNULL_END
