//
//  NSString+Hash.h
//
//  Created by Tom Corwine on 5/30/12..
//

@interface NSString (Hash)

@property (readonly, nonatomic, copy) NSString *md5String;
@property (readonly, nonatomic, copy) NSString *sha1String;
@property (readonly, nonatomic, copy) NSString *sha256String;
@property (readonly, nonatomic, copy) NSString *sha512String;

- (NSString *)hmacSHA1StringWithKey:(NSString *)key;
- (NSString *)hmacSHA256StringWithKey:(NSString *)key;
- (NSString *)hmacSHA512StringWithKey:(NSString *)key;

@end
