using DataAccess.DBAccess;
using DataAccess.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess.Data;

public class MemberData : IMemberData
{
    private readonly ISqlDataAccess _db;

    public MemberData(ISqlDataAccess db)
    {
        _db = db;
    }

    public Task<IEnumerable<MemberModel>> GetMembers() =>
        _db.LoadData<MemberModel, dynamic>("dbo.spMember_GetAll", new { });

    public async Task<MemberModel?> GetMember(string memberNumber) =>
        (await _db.LoadData<MemberModel, dynamic>("dbo.spMember_Get",
            new { MemberNumber = memberNumber })).FirstOrDefault();

    public Task InsertMember(MemberModel member) =>
        _db.SaveData("dbo.spMember_Insert", member);

    public Task UpdateMember(MemberModel member) =>
        _db.SaveData("dbo.spMember_Update", member);

    public Task DeleteMember(string memberNumber) =>
        _db.SaveData("dbo.spMember_Delete", new { MemberNumber = memberNumber });

    public async Task<PasswordModel?> GetPassword(string memberNumber) =>
    (await _db.LoadData<PasswordModel, dynamic>("dbo.spPassword_Get",
        new { MemberNumber = memberNumber })).FirstOrDefault();

    public Task InsertPassword(PasswordModel password) =>
        _db.SaveData("dbo.spPassword_Insert", password);

    public Task UpdatePassword(PasswordModel password) =>
        _db.SaveData("dbo.spPassword_Update", password);
}
