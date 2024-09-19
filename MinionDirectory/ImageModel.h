//
//  ImageModel.h
//  MinionDirectory
//
//  Created by Zareenah Murad on 9/18/24.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ImageModel : NSObject

+(ImageModel*)sharedInstance;
// flipped module: update so all properties except sharedInstance are private
-(UIImage*)getImageWithName:(NSString*)name;
-(UIImage*)getImageWithIndex:(NSInteger)index;
-(NSInteger)numberOfImages;
-(NSString*)getImageNameForIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
