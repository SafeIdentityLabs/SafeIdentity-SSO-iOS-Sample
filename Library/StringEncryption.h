#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>

#define kChosenCipherBlockSize	kCCBlockSizeAES128
#define kChosenCipherKeySize	kCCKeySizeAES128
#define kChosenDigestLength		CC_SHA1_DIGEST_LENGTH

NSString *EncryptString(NSString *plainSourceStringToEncrypt);
NSString *DecryptString(NSString *base64StringToDecrypt);

void testSymmetricEncryption();

NSData *enc(NSData *plainText, NSData *aSymmetricKey, CCOptions *pkcs7);

NSData *decrypt(NSData *plainText, NSData *aSymmetricKey, CCOptions *pkcs7);

NSData *doCipher(NSData *plainText, NSData *aSymmetricKey, CCOperation encryptOrDecrypt, CCOptions *pkcs7);

NSData *md5data(NSString *str);

NSString *base64EncodingWithLineLength(NSData* encData, unsigned int lineLength);
