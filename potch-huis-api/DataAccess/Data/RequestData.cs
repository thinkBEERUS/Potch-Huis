﻿using DataAccess.DBAccess;
using DataAccess.Models;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Drawing;

namespace DataAccess.Data;

public class RequestData : IRequestData
{
    private readonly ISqlDataAccess _db;
    public RequestData(ISqlDataAccess db)
    {
        _db = db;
    }

    public Task<IEnumerable<RequestModel>> GetAllRequests(int pageNumber, int pageSize)
    {
        return _db.LoadData<RequestModel, dynamic>("dbo.spRequest_GetAll", new { PageNumber = pageNumber, PageSize = pageSize });
    }

    public Task<IEnumerable<RequestModel>> GetAllUnconfirmedRequests(int pageNumber, int pageSize)
    {
        return _db.LoadData<RequestModel, dynamic>("dbo.spRequest_GetAll_Unconfirmed", new { PageNumber = pageNumber, PageSize = pageSize });
    }

    public Task<IEnumerable<ReportModel.MonthlyRequests>> GetRequestMonthly(string name, int? months = null)
    {
        return _db.LoadData<ReportModel.MonthlyRequests, dynamic>("dbo.spReport_Monthly_Requests", new { ItemName = name, MonthsToInclude = months });
    }

    public Task<IEnumerable<int>> GetAllRows(string name) =>
        _db.LoadData<int, dynamic>("dbo.spGlobal_GetAll_Rows", new { DBname = name });

    public Task<IEnumerable<RequestModel>> GetRequest(string requestNumber) =>
        _db.LoadData<RequestModel, dynamic>("dbo.spRequest_Get", new { RequestNumber = requestNumber });

    public Task<IEnumerable<RequestModel>> GetRequestMember(string memberNumber, int pageNumber, int pageSize) =>
        _db.LoadData<RequestModel, dynamic>("dbo.spRequest_Get_Member", new { memberNumber, pageNumber, pageSize });

    public string InsertRequest(RequestModel request)
    {
        using (var connection = new SqlConnection("Data Source=(localdb)\\MSSQLLocalDB;Initial Catalog=Potch_Huis;Integrated Security=True;Connect Timeout=60;Encrypt=False;TrustServerCertificate=False;ApplicationIntent=ReadWrite;MultiSubnetFailover=False"))
        {
            connection.Open();
            using (var command = new SqlCommand("dbo.spRequest_Insert", connection))
            {
                command.CommandType = CommandType.StoredProcedure;

                var requestNumberParam = new SqlParameter("@RequestNumber", SqlDbType.NVarChar, 100);
                requestNumberParam.Direction = ParameterDirection.Output;

                command.Parameters.Add(requestNumberParam);
                command.Parameters.AddWithValue("@MemberNumber", request.MemberNumber);
                command.Parameters.AddWithValue("@Value", request.Value);
                command.Parameters.AddWithValue("@Received", request.Received);
                command.Parameters.AddWithValue("@Confirmed", request.Confirmed);

                command.ExecuteNonQuery();

                connection.Close();

                return requestNumberParam.Value as string ?? "NULL";                
            }
        }
    }


    public Task UpdateRequest(RequestModel request) =>
        _db.SaveData("dbo.spRequest_Update", request);

    public Task DeleteRequest(string requestNumber) =>
        _db.SaveData("dbo.spRequest_Delete", new { RequestNumber = requestNumber });

    public Task<IEnumerable<RequestedItemModel>> GetAllRequestedItems() =>
        _db.LoadData<RequestedItemModel, dynamic>("dbo.spRequested_Items_GetAll", new { });

    public Task<IEnumerable<RequestedItemModel>> GetRequestedItems(string requestNumber) =>
        _db.LoadData<RequestedItemModel, dynamic>("dbo.spRequested_Items_Get", new { RequestNumber = requestNumber });

    public Task<IEnumerable<RequestedItemModel>> GetRequestedItem(string requestedItem, string requestNumber) =>
    _db.LoadData<RequestedItemModel, dynamic>("dbo.spRequested_Item_Get", new { RequestedItem = requestedItem, RequestNumber = requestNumber });

    public Task InsertRequestedItem(RequestedItemModel requestedItem) =>
        _db.SaveData("dbo.spRequested_Items_Insert", requestedItem);

    public Task UpdateRequestedItem(RequestedItemModel requestedItem) =>
        _db.SaveData("dbo.spRequested_Items_Update", requestedItem);

    public Task DeleteRequestedItem(string requestedItemNumber, string requestNumber) =>
        _db.SaveData("dbo.spRequested_Items_Delete", new { RequestedItemNumber = requestedItemNumber, RequestNumber = requestNumber });
}
