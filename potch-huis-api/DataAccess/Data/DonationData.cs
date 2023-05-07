using DataAccess.DBAccess;
using DataAccess.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
namespace DataAccess.Data;

public class DonationData : IDonationData
{
    private readonly ISqlDataAccess _db;
    public DonationData(ISqlDataAccess db)
    {
        _db = db;
    }

    public Task<IEnumerable<int>> GetAllRows(string name) =>
        _db.LoadData<int, dynamic>("dbo.spGlobal_GetAll_Rows", new { DBname = name });

    //public Task<IEnumerable<int>> GetAllConfirmedRows(string name) =>
    //_db.LoadData<int, dynamic>("dbo.spGlobal_GetAll_Rows", new { DBname = name });

    public Task<IEnumerable<DonationModel>> GetAllConfirmedDonation(int pageNumber = 1, int pageSize = 15) =>
        _db.LoadData<DonationModel, dynamic>("dbo.spDonation_GetAll_Confirmed", new { pageNumber, pageSize });
    public Task<IEnumerable<DonationModel>> GetAllUnconfirmedDonation(int pageNumber = 1, int pageSize = 15) =>
        _db.LoadData<DonationModel, dynamic>("dbo.spDonation_GetAll_Unconfirmed", new { pageNumber, pageSize });

    public Task<IEnumerable<DonationModel>> GetDonation(string donationNumber) =>
        _db.LoadData<DonationModel, dynamic>("dbo.spDonation_Get", new { donationNumber });

    public Task<IEnumerable<DonationModel>> GetMemberDonation(string memberNumber, int pageNumber = 1, int pageSize = 15) =>
        _db.LoadData<DonationModel, dynamic>("dbo.spDonation_Get_Member", new { memberNumber, pageNumber, pageSize });

    public Task InsertDonation(DonationModel donation) =>
        _db.SaveData("dbo.spDonation_Insert", donation);

    public Task UpdateDonation(DonationModel donation) =>
        _db.SaveData("dbo.spDonation_Update", donation);

    public Task DeleteDonation(string donationNumber) =>
        _db.SaveData("dbo.spDonation_Delete", new { donationNumber });
}
