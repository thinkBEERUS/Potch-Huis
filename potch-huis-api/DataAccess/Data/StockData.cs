using DataAccess.DBAccess;
using DataAccess.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Linq;

namespace DataAccess.Data;

public class StockData : IStockData
{
    private readonly ISqlDataAccess _db;

    public StockData(ISqlDataAccess db)
    {
        _db = db;
    }

    public Task<IEnumerable<StockModel>> GetAllStock(int pageNumber, int pageSize) =>
        _db.LoadData<StockModel, dynamic>("dbo.spStock_GetAll", new { pageNumber, pageSize});

    public Task<IEnumerable<int>> GetAllStockRows(string name) =>
        _db.LoadData<int, dynamic>("dbo.spGlobal_GetAll_Rows", new { DBname = name });

    public Task<IEnumerable<StockModel>> GetActiveStock() =>
        _db.LoadData<StockModel, dynamic>("dbo.spStock_GetActive", new { });

    public async Task<StockModel?> GetStock(string stockNumber) =>
        (await _db.LoadData<StockModel, dynamic>("dbo.spStock_Get",
            new { StockNumber = stockNumber })).FirstOrDefault();

    public Task InsertStock(StockModel stock) =>
        _db.SaveData("dbo.spStock_Insert", stock);

    public Task UpdateStock(StockModel stock) =>
        _db.SaveData("dbo.spStock_Update", stock);

    public Task DeleteStock(string stockNumber) =>
        _db.SaveData("dbo.spStock_Delete", new { StockNumber = stockNumber });
}
