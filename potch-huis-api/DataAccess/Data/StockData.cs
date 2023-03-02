using DataAccess.DBAccess;
using DataAccess.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess.Data;

public class StockData : IStockData
{
    private readonly ISqlDataAccess _db;

    public StockData(ISqlDataAccess db)
    {
        _db = db;
    }

    public Task<IEnumerable<StockModel>> GetAllStock() =>
    _db.LoadData<StockModel, dynamic>("dbo.spStock_GetAll", new { });

    public Task<IEnumerable<StockModel>> GetActiveStock() =>
    _db.LoadData<StockModel, dynamic>("dbo.spStock_GetActive", new { });

    public async Task<StockModel?> GetStock(string name) =>
        (await _db.LoadData<StockModel, dynamic>("dbo.spStock_Get",
            new { Name = name })).FirstOrDefault();

    public Task InsertStock(StockModel stock) =>
        _db.SaveData("dbo.spStock_Insert", stock);

    public Task UpdateStock(StockModel stock) =>
        _db.SaveData("dbo.spStock_Update", stock);

    public Task DeleteStock(string name) =>
        _db.SaveData("dbo.spStock_Delete", new { Name = name });
}
