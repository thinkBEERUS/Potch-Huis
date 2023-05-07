using DataAccess.Models;

namespace DataAccess.Data
{
    public interface IStockData
    {
        Task DeleteStock(string stockNumber);
        Task<IEnumerable<StockModel>> GetActiveStock();
        Task<IEnumerable<StockModel>> GetAllStock(int pageNumber, int pageSize);
        Task<IEnumerable<int>> GetAllStockRows(string name);
        Task<StockModel?> GetStock(string stockNumber);
        Task InsertStock(StockModel stock);
        Task UpdateStock(StockModel stock);
    }
}