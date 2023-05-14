using DataAccess.Models;

namespace DataAccess.Data
{
    public interface IRequestData
    {
        Task DeleteRequest(string requestNumber);
        Task DeleteRequestedItem(string requestedItemNumber, string requestNumber);
        Task<IEnumerable<RequestedItemModel>> GetAllRequestedItems();
        Task<IEnumerable<RequestModel>> GetAllRequests(int pageNumber, int pageSize);
        Task<IEnumerable<RequestModel>> GetAllUnconfirmedRequests(int pageNumber, int pageSize);
        Task<IEnumerable<int>> GetAllRows(string name);
        Task<IEnumerable<RequestModel>> GetRequest(string requestNumber);
        Task<IEnumerable<RequestModel>> GetRequestMember(string requestNumber, int pageNumber, int pageSize);
        Task<IEnumerable<RequestedItemModel>> GetRequestedItem(string requestedItem, string requestNumber);
        Task<IEnumerable<RequestedItemModel>> GetRequestedItems(string requestNumber);
        Task<IEnumerable<ReportModel.MonthlyRequests>> GetRequestMonthly(string name, int? months);
        string InsertRequest(RequestModel request);
        Task InsertRequestedItem(RequestedItemModel requestedItem);
        Task UpdateRequest(RequestModel request);
        Task UpdateRequestedItem(RequestedItemModel requestedItem);
    }
}