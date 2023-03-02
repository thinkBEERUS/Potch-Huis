using DataAccess.Models;

namespace DataAccess.Data
{
    public interface IMemberData
    {
        Task DeleteMember(string memberNumber);
        Task<MemberModel?> GetMember(string memberNumber);
        Task<IEnumerable<MemberModel>> GetMembers();
        Task<PasswordModel?> GetPassword(string memberNumber);
        Task InsertMember(MemberModel member);
        Task InsertPassword(PasswordModel password);
        Task UpdateMember(MemberModel member);
        Task UpdatePassword(PasswordModel password);
    }
}