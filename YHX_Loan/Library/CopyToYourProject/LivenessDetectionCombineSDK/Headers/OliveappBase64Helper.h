//
//  Base64Helper.h

//
//  Created by Jiteng Hao on 15/10/8.

//

#import <Foundation/Foundation.h>

@interface OliveappBase64Helper : NSObject

+ (NSString*) encode: (NSData*) data;

// NOTE: this code is not tested
+ (NSData*) decode: (NSString*) encoded;
                     
@end
