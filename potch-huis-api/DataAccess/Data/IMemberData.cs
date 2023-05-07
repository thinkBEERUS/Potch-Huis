using DataAccess.Models;

namespace DataAccess.Data
{
    public interface IMemberData
    {
        Task DeleteMember(string memberNumber);
        Task<IEnumerable<int>> GetAllRows(string name);
        Task<MemberModel?> GetMember(string memberNumber);
        Task<IEnumerable<string>> GetMemberNumber();
        Task<IEnumerable<MemberModel>> GetMembers(int pageNumber, int pageSize);
        Task<PasswordModel?> GetPassword(string memberNumber);
        Task<IEnumerable<ReportModel.MonthlyDonations>> GetDonationsMonthly(string memberNumber, string year);
        Task InsertMember(MemberModel member);
        Task InsertPassword(PasswordModel password);
        Task UpdateMember(MemberModel member);
        Task UpdatePassword(PasswordModel password);
    }
}