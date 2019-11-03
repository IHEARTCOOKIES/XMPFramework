//
//  XMPWriter.h
//  XMPFramework
//
//  Created by Filip Busic on 8/11/18.
//

#import <XMPFramework/XMPReader.h>

NS_ASSUME_NONNULL_BEGIN
@interface XMPWriter : XMPReader

#pragma mark - Set Value For Key Methods

- (BOOL)setBool:(BOOL)value forKey:(NSString *)key;
- (BOOL)setDouble:(double)value forKey:(NSString *)key;
- (BOOL)setInteger:(NSInteger)value forKey:(NSString *)key;
- (BOOL)setString:(NSString *)value forKey:(NSString *)key;

#pragma mark - Set Value For Key w/ Error Methods

- (BOOL)setBool:(BOOL)value forKey:(NSString *)key error:(NSError *_Nullable __autoreleasing *)error;
- (BOOL)setDouble:(double)value forKey:(NSString *)key error:(NSError *_Nullable __autoreleasing *)error;
- (BOOL)setInteger:(NSInteger)value forKey:(NSString *)key error:(NSError *_Nullable __autoreleasing *)error;
- (BOOL)setString:(NSString *)value forKey:(NSString *)key error:(NSError *_Nullable __autoreleasing *)error;

#pragma mark - Set Value For Key w/ XMPProperty Methods

- (BOOL)setBool:(BOOL)value forKey:(NSString *)key withProperty:(XMPProperty *)property;
- (BOOL)setDouble:(double)value forKey:(NSString *)key withProperty:(XMPProperty *)property;
- (BOOL)setInteger:(NSInteger)value forKey:(NSString *)key withProperty:(XMPProperty *)property;
- (BOOL)setString:(NSString *)value forKey:(NSString *)key withProperty:(XMPProperty *)property;

#pragma mark - Set Value For Key w/ XMPProperty & Error Methods

- (BOOL)setBool:(BOOL)value forKey:(NSString *)key withProperty:(XMPProperty *)property error:(NSError *_Nullable __autoreleasing *)error;
- (BOOL)setDouble:(double)value forKey:(NSString *)key withProperty:(XMPProperty *)property error:(NSError *_Nullable __autoreleasing *)error;
- (BOOL)setInteger:(NSInteger)value forKey:(NSString *)key withProperty:(XMPProperty *)property error:(NSError *_Nullable __autoreleasing *)error;
- (BOOL)setString:(NSString *)value forKey:(NSString *)key withProperty:(XMPProperty *)property error:(NSError *_Nullable __autoreleasing *)error;

#pragma mark - Remove Methods

- (BOOL)removeValueForKey:(NSString *)key;
- (BOOL)removeValueForKey:(NSString *)key withProperty:(XMPProperty *)property;

#pragma mark - Synchronizing Methods

/**
 Attempts to synchronize the changes made to the XMP file to the referenced file on disk.

 @return Returns a YES for if the changes made were synced successfully.
 */
- (BOOL)synchronize;

@end
NS_ASSUME_NONNULL_END
