using DataAccess.Models;

namespace DataAccess.Data
{
    public interface IDonationData
    {
        Task DeleteDonation(string memberNumber);
        Task<IEnumerable<DonationModel>> GetAllConfirmedDonation(int pageNumber = 1, int pageSize = 15);
        Task<IEnumerable<int>> GetAllRows(string name);
        Task<IEnumerable<DonationModel>> GetAllUnconfirmedDonation(int pageNumber = 1, int pageSize = 15);
        Task<IEnumerable<DonationModel>> GetDonation(string donationNumber);
        Task<IEnumerable<DonationModel>> GetMemberDonation(string memberNumber, int pageNumber = 1, int pageSize = 15);
        Task InsertDonation(DonationModel donation);
        Task UpdateDonation(DonationModel donation);
    }
}