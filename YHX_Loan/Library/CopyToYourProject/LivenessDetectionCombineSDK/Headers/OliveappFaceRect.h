//
//  FaceRect.h
//  FaceVerificationSDK
//
//  Created by jqshen on 5/4/15.

//

#import <Foundation/Foundation.h>

@interface OliveappFaceRect : NSObject

@property CGRect faceRect;
- (id)initWithCGRect: (CGRect)faceRect;

@end
