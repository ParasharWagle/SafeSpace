package com.islington.config;

import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;
import java.util.Base64;

/**
 * AESUtil — utility class for AES password encryption and decryption.
 * Uses a fixed 16-byte secret key for symmetric encryption.
 * Taught in Week 4 (AES password encryption).
 */
public class AESUtil {

    // Fixed 16-byte secret key for AES-128 encryption
    // In production this would be stored securely, but for coursework we use a constant
    private static final String SECRET_KEY = "SafeSpace1234567";

    // AES algorithm identifier
    private static final String ALGORITHM = "AES";

    /**
     * encrypt — takes a plain-text string and returns its AES-encrypted form
     * encoded in Base64 so it can be safely stored in the database.
     *
     * @param plainText the original password or text to encrypt
     * @return Base64-encoded encrypted string
     */
    public static String encrypt(String plainText) {
        try {
            // Create a secret key specification from our fixed key bytes
            SecretKeySpec keySpec = new SecretKeySpec(SECRET_KEY.getBytes("UTF-8"), ALGORITHM);

            // Initialise the Cipher in ENCRYPT mode
            Cipher cipher = Cipher.getInstance(ALGORITHM);
            cipher.init(Cipher.ENCRYPT_MODE, keySpec);

            // Perform the encryption on the plain text bytes
            byte[] encryptedBytes = cipher.doFinal(plainText.getBytes("UTF-8"));

            // Encode the encrypted bytes to a Base64 string for safe storage
            return Base64.getEncoder().encodeToString(encryptedBytes);

        } catch (Exception e) {
            // Log the error and throw a runtime exception with a friendly message
            e.printStackTrace();
            throw new RuntimeException("Error occurred while encrypting the data.");
        }
    }

    /**
     * decrypt — takes a Base64-encoded AES-encrypted string and returns
     * the original plain-text value.
     *
     * @param encryptedText the Base64-encoded encrypted string from the database
     * @return the original plain-text string
     */
    public static String decrypt(String encryptedText) {
        try {
            // Create a secret key specification from our fixed key bytes
            SecretKeySpec keySpec = new SecretKeySpec(SECRET_KEY.getBytes("UTF-8"), ALGORITHM);

            // Initialise the Cipher in DECRYPT mode
            Cipher cipher = Cipher.getInstance(ALGORITHM);
            cipher.init(Cipher.DECRYPT_MODE, keySpec);

            // Decode the Base64 string back to encrypted bytes
            byte[] decodedBytes = Base64.getDecoder().decode(encryptedText);

            // Perform the decryption to get original plain text bytes
            byte[] decryptedBytes = cipher.doFinal(decodedBytes);

            // Convert decrypted bytes back to a string
            return new String(decryptedBytes, "UTF-8");

        } catch (Exception e) {
            // Log the error and throw a runtime exception with a friendly message
            e.printStackTrace();
            throw new RuntimeException("Error occurred while decrypting the data.");
        }
    }
}
