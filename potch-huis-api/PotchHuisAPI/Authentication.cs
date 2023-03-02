using System.Security.Cryptography;
using System.Text;

namespace PotchHuisAPI;

public class Authentication
{
    public static byte[] GenerateSalt(int saltLength)
    {
        byte[] salt = new byte[saltLength];
        var number = RandomNumberGenerator.Create();
        number.GetBytes(salt);
        return salt;
    }

    public static string GenerateHash(string password, byte[] salt)
    {
        byte[] passwordBytes = Encoding.UTF8.GetBytes(password);
        byte[] saltedPasswordBytes = new byte[passwordBytes.Length + salt.Length];

        Buffer.BlockCopy(passwordBytes, 0, saltedPasswordBytes, 0, passwordBytes.Length);
        Buffer.BlockCopy(salt, 0, saltedPasswordBytes, passwordBytes.Length, salt.Length);

        byte[] hashedBytes = SHA256.Create().ComputeHash(saltedPasswordBytes);
        return Convert.ToBase64String(hashedBytes);
    }

    public static bool AuthenticateMember(string password, byte[] salt, string hashedPassword)
    {
        string computedHash = GenerateHash(password, salt);
        return string.Equals(computedHash, hashedPassword);
    }
}
