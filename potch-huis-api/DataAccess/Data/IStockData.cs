using DataAccess.Models;

namespace DataAccess.Data
{
    public interface IStockData
    {
        Task DeleteStock(string name);
        Task<IEnumerable<StockModel>> GetActiveStock();
        Task<IEnumerable<StockModel>> GetAllStock();
        Task<StockModel?> GetStock(string name);
        Task InsertStock(StockModel stock);
        Task UpdateStock(StockModel stock);
    }
}