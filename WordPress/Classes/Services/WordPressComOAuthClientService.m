#import "WordPressComOAuthClientService.h"
#import "WordPressComOAuthClient.h"

@implementation WordPressComOAuthClientService

- (void)authenticateWithUsername:(NSString *)username
                        password:(NSString *)password
                 multifactorCode:(NSString *)multifactorCode
                         success:(void (^)(NSString *authToken))success
                needsMultiFactor:(void (^)())needsMultifactor
                         failure:(void (^)(NSError *error))failure
{
    WordPressComOAuthClient *client = [WordPressComOAuthClient client];
    [client authenticateWithUsername:username password:password multifactorCode:multifactorCode success:success failure:^(NSError *error) {
        if (error.code == WordPressComOAuthErrorNeedsMultifactorCode) {
            needsMultifactor();
        } else {
            failure(error);
        }
    }];
}

@end
