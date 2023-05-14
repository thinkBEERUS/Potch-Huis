using Microsoft.AspNetCore.Mvc;
using System.Runtime.CompilerServices;
using System.Text;

namespace PotchHuisAPI
{
    public static class Api
    {
        #region Endpoints
        public static void ConfigureApi(this WebApplication app)
        {
            //Members
            app.MapGet("/Members", GetMembers);
            app.MapGet("/Members/{memberNumber}", GetMember);
            app.MapGet("/Members/MemberNumber", GetMemberNumber);
            app.MapPost("/Members", InsertMember);
            app.MapPut("/Members", UpdateMember);
            app.MapDelete("/Members", DeleteMember);
            app.MapGet("/Members/Rows", GetAllMemberRows);
            //Auth
            app.MapGet("/Members/Auth", AuthenticateMember);
            app.MapPost("/Members/Auth", InsertPassword);
            app.MapPut("/Members/Auth", UpdatePassword);
            //Donations
            app.MapGet("/Donations/Confirmed", GetAllConfirmedDonation);
            app.MapGet("/Donations/Unconfirmed", GetAllUnconfirmedDonation);
            app.MapGet("/Donations/Donation", GetDonation);
            app.MapGet("/Donations/Member", GetDonationMember);
            app.MapPost("/Donations/Create", InsertDonation);
            app.MapPut("/Donations/Update", UpdateDonation);
            app.MapDelete("/Donations/Delete", DeleteDonation);
            app.MapGet("/Donations/Rows", GetAllDonationRows);
            //Requests
            app.MapGet("/Requests/Confirmed", GetAllConfirmedRequest);
            app.MapGet("/Requests/Unconfirmed", GetAllUnconfirmedRequests);
            app.MapGet("/Requests/Request", GetRequest);
            app.MapGet("/Requests/Member", GetRequestMember);
            app.MapPost("/Requests/Create", InsertRequest);
            app.MapPut("/Requests/Update", UpdateRequest);
            app.MapDelete("/Requests/Delete", DeleteRequest);
            app.MapGet("/Requests/Rows", GetAllRequestRows);
            //Requested Items
            app.MapGet("/Requests/Items", GetAllRequestedItems);
            app.MapGet("/Requests/ItemRequest/{requestNumber}", GetRequestedItems);
            app.MapGet("/Requests/Items/{requestedItemNumber}", GetRequestedItem);
            app.MapPost("/Requests/Items", InsertRequestedItem);
            app.MapPut("/Requests/Items", UpdateRequestedItem);
            app.MapDelete("/Requests/Items", DeleteRequestedItems);
            //Stock
            app.MapGet("/AllStock", GetAllStock);
            app.MapGet("/ActiveStock", GetActiveStock);
            app.MapGet("/Stock/{name}", GetStock);
            app.MapPost("/Stock", InsertStock);
            app.MapPut("/Stock", UpdateStock);
            app.MapDelete("/Stock", DeleteStock);
            app.MapGet("/Stock/Rows", GetAllStockRows);
            //Reporting
            app.MapGet("/Stock/Reporting/Requests/Monthly", GetMonthlyRequests);
            app.MapGet("/Members/Reporting/Donations/Monthly", GetMonthlyDonations);
        }


        #endregion

        #region Members
        private static async Task<IResult> GetAllMemberRows(IMemberData data)
        {
            try
            {
                return Results.Ok(await data.GetAllRows("Member"));
            }
            catch (Exception ex)
            {
                return Results.Problem(ex.Message);
            }
        }
        private static async Task<IResult> GetMembers(IMemberData data,int pageNumber, int pageSize)
        {
            try
            {
                return Results.Ok(await data.GetMembers(pageNumber, pageSize));
            }
            catch(Exception ex)
            {
                return Results.Problem(ex.Message);            
            }
        }

        private static async Task<IResult> GetMemberNumber(IMemberData data)
        {
            try
            {
                return Results.Ok(await data.GetMemberNumber());
            }
            catch (Exception ex)
            {
                return Results.Problem(ex.Message);
            }
        }

        private static async Task<IResult> GetMember(string memberNumber, IMemberData data)
        {
            try
            {
                var results = await data.GetMember(memberNumber);
                if (results == null) return Results.NotFound();
                return Results.Ok(results);
            }
            catch(Exception ex)
            {
                return Results.Problem(ex.Message);
            }
        }

        private static async Task<IResult> InsertMember(MemberModel member, IMemberData data)
        {
            try
            {
                await data.InsertMember(member);
                return Results.Ok(await data.GetMembers(1, 10));
            }
            catch (Exception ex)
            {
                return Results.Problem(ex.Message);
            }
        }

        private static async Task<IResult> UpdateMember(MemberModel member, IMemberData data)
        {
            try
            {
                await data.UpdateMember(member);
                return Results.Ok(await data.GetMembers(1, 10));
            }
            catch (Exception ex)
            {
                return Results.Problem(ex.Message);
            }
        }

        private static async Task<IResult> DeleteMember(string memberNumber, IMemberData data)
        {
            try
            {
                await data.DeleteMember(memberNumber);
                return Results.Ok(await data.GetMembers(1, 10));
            }
            catch (Exception ex)
            {
                return Results.Problem(ex.Message);
            }
        }
        #endregion

        #region Authentication
        private static async Task<IResult> InsertPassword(string password, string memberNumber, IMemberData data)
        {
            try
            {
                var salt = Authentication.GenerateSalt(16);
                var Hash = Authentication.GenerateHash(password, salt);
                await data.InsertPassword(new PasswordModel { Salt = salt, Hash = Hash.ToString(), MemberNumber = memberNumber });
                return Results.Ok();
            }
            catch (Exception ex)
            {
                return Results.Problem(ex.Message);
            }
        }

        private static async Task<IResult> UpdatePassword(string password, string memberNumber, IMemberData data)
        {
            try
            {
                var salt = Authentication.GenerateSalt(16);
                var Hash = Authentication.GenerateHash(password, salt);
                await data.UpdatePassword(new PasswordModel { Salt = salt, Hash = Hash.ToString(), MemberNumber = memberNumber });
                return Results.Ok("Member Updated");
            }
            catch (Exception ex)
            {
                return Results.Problem(ex.Message);
            }
        }


        private static async Task<IResult> AuthenticateMember(string memberNumber, string password, IMemberData data)
        {
            try
            {
                var results = await data.GetPassword(memberNumber);

                if (results == null)
                    return Results.Unauthorized();

                if (results.Salt != null && results.Hash != null)
                {
                    bool validMember = Authentication.AuthenticateMember(password, results.Salt, results.Hash);

                    if (!validMember)
                        return Results.Json(new { error = "Unable to Authenticate Member" });

                    return Results.Json(new { message = "Member Authenticated", memberNumber });
                }
                else
                    return Results.Problem();
            }
            catch (Exception ex)
            {
                return Results.Problem(ex.Message);
            }
        }
        #endregion

        #region Donations
        private static async Task<IResult> GetAllDonationRows(IDonationData data)
        {
            try
            {
                return Results.Ok(await data.GetAllRows("Donation"));
            }
            catch (Exception ex)
            {
                return Results.Problem(ex.Message);
            }
        }

        private static async Task<IResult> GetAllConfirmedDonation(IDonationData data, int pageNumber, int pageSize)
        {
            try
            {
                return Results.Ok(await data.GetAllConfirmedDonation(pageNumber, pageSize));
            }
            catch (Exception ex)
            {
                return Results.Problem(ex.Message);
            }
        }

        private static async Task<IResult> GetAllUnconfirmedDonation(IDonationData data, int pageNumber, int pageSize)
        {
            try
            {
                return Results.Ok(await data.GetAllUnconfirmedDonation(pageNumber, pageSize));
            }
            catch (Exception ex)
            {
                return Results.Problem(ex.Message);
            }
        }

        private static async Task<IResult> GetDonation(string donationNumber, IDonationData data)
        {
            try
            {
                var results = await data.GetDonation(donationNumber);
                if (results == null) return Results.NotFound();
                return Results.Ok(results);
            }
            catch (Exception ex)
            {
                return Results.Problem(ex.Message);
            }
        }

        private static async Task<IResult> GetDonationMember(string memberNumber, IDonationData data)
        {
            try
            {
                var results = await data.GetMemberDonation(memberNumber);
                if (results == null) return Results.NotFound();
                return Results.Ok(results);
            }
            catch (Exception ex)
            {
                return Results.Problem(ex.Message);
            }
        }

        private static async Task<IResult> InsertDonation(DonationModel donation, IDonationData data)
        {
            try
            {
                await data.InsertDonation(donation);
                return Results.Json(new { message = "Donation Created" });
            }
            catch (Exception ex)
            {
                return Results.Problem(ex.Message);
            }
        }

        private static async Task<IResult> UpdateDonation(DonationModel donation, IDonationData data)
        {
            try
            {
                await data.UpdateDonation(donation);
                return Results.Json(new { message = "Donation Updated" });
            }
            catch (Exception ex)
            {
                return Results.Problem(ex.Message);
            }
        }

        private static async Task<IResult> DeleteDonation(string donationNumber, IDonationData data)
        {
            try
            {
                await data.DeleteDonation(donationNumber);
                return Results.Json(new { message = "Donation Deleted!" });
            }
            catch (Exception ex)
            {
                return Results.Problem(ex.Message);
            }
        }
        #endregion

        #region Requests
        private static async Task<IResult> GetAllRequestRows(IRequestData data)
        {
            try
            {
                return Results.Ok(await data.GetAllRows("Request"));
            }
            catch (Exception ex)
            {
                return Results.Problem(ex.Message);
            }
        }

        private static async Task<IResult> GetAllConfirmedRequest(IRequestData data, int pageNumber, int pageSize)
        {
            try
            {
                return Results.Ok(await data.GetAllRequests(pageNumber, pageSize));
            }
            catch (Exception ex)
            {
                return Results.Problem(ex.Message);
            }
        }

        private static async Task<IResult> GetAllUnconfirmedRequests(IRequestData data, int pageNumber, int pageSize)
        {
            try
            {
                return Results.Ok(await data.GetAllUnconfirmedRequests(pageNumber, pageSize));
            }
            catch (Exception ex)
            {
                return Results.Problem(ex.Message);
            }
        }

        private static async Task<IResult> GetRequest(string requestNumber, IRequestData data)
        {
            try
            {
                var results = await data.GetRequest(requestNumber);
                if (results == null) return Results.NotFound();
                return Results.Ok(results);
            }
            catch (Exception ex)
            {
                return Results.Problem(ex.Message);
            }
        }

        private static async Task<IResult> GetRequestMember(string memberNumber, int pageNumber, int pageSize, IRequestData data)
        {
            try
            {
                var results = await data.GetRequestMember(memberNumber, pageNumber, pageSize);
                if (results == null) return Results.NotFound();
                return Results.Ok(results);
            }
            catch (Exception ex)
            {
                return Results.Problem(ex.Message);
            }
        }

        private static IResult InsertRequest(RequestModel request, IRequestData data)
        {
            try
            {
                var requestNumber = data.InsertRequest(request);
                return Results.Json(new { message = "R_" + requestNumber });
            }
            catch (Exception ex)
            {
                return Results.Problem(ex.Message);
            }
        }

        private static async Task<IResult> UpdateRequest(RequestModel request, IRequestData data)
        {
            try
            {
                await data.UpdateRequest(request);
                return Results.Json(new { message = "Request Updated" });
            }
            catch (Exception ex)
            {
                return Results.Problem(ex.Message);
            }
        }

        private static async Task<IResult> DeleteRequest(string requestNumber, IRequestData data)
        {
            try
            {
                await data.DeleteRequest(requestNumber);
                return Results.Json(new { message = "Request Deleted" });
            }
            catch (Exception ex)
            {
                return Results.Problem(ex.Message);
            }
        }
        #endregion

        #region Requested Items
        private static async Task<IResult> GetAllRequestedItems(IRequestData data)
        {
            try
            {
                return Results.Ok(await data.GetAllRequestedItems());
            }
            catch (Exception ex)
            {
                return Results.Problem(ex.Message);
            }
        }

        private static async Task<IResult> GetRequestedItem(string requestedItemNumber, string requestNumber, IRequestData data)
        {
            try
            {
                var results = await data.GetRequestedItem(requestedItemNumber, requestNumber);
                if (results == null) return Results.NotFound();
                return Results.Ok(results);
            }
            catch (Exception ex)
            {
                return Results.Problem(ex.Message);
            }
        }

        private static async Task<IResult> GetRequestedItems(string requestNumber, IRequestData data)
        {
            try
            {
                var results = await data.GetRequestedItems(requestNumber);
                if (results == null) return Results.NotFound();
                return Results.Ok(results);
            }
            catch (Exception ex)
            {
                return Results.Problem(ex.Message);
            }
        }

        private static async Task<IResult> InsertRequestedItem(RequestedItemModel requestedItem, IRequestData data)
        {
            try
            {
                await data.InsertRequestedItem(requestedItem);
                var requestNumber = requestedItem.RequestNumber ?? throw new Exception("Invalid Request Number!");
                return Results.Ok(await data.GetRequestedItems(requestNumber));
            }
            catch (Exception ex)
            {
                return Results.Problem(ex.Message);
            }
        }

        private static async Task<IResult> UpdateRequestedItem(RequestedItemModel requestedItem, IRequestData data)
        {
            try
            {
                await data.UpdateRequestedItem(requestedItem);
                var requestNumber = requestedItem.RequestNumber ?? throw new Exception("Invalid Request Number!");
                return Results.Ok(await data.GetRequestedItems(requestNumber));
            }
            catch (Exception ex)
            {
                return Results.Problem(ex.Message);
            }
        }

        private static async Task<IResult> DeleteRequestedItems(string requestedItemNumber, string requestNumber, IRequestData data)
        {
            try
            {
                await data.DeleteRequestedItem(requestedItemNumber, requestNumber);
                return Results.Ok(await data.GetRequestedItems(requestNumber));
            }
            catch (Exception ex)
            {
                return Results.Problem(ex.Message);
            }
        }
        #endregion   

        #region Stock
        private static async Task<IResult> GetAllStock(IStockData data, int pageNumber, int pageSize)
        {
            try
            {
                return Results.Ok(await data.GetAllStock(pageNumber, pageSize));
            }
            catch (Exception ex)
            {
                return Results.Problem(ex.Message);
            }
        }

        private static async Task<IResult> GetAllStockRows(IStockData data)
        {
            try
            {
                return Results.Ok(await data.GetAllStockRows("Stock"));
            }
            catch (Exception ex)
            {
                return Results.Problem(ex.Message);
            }
        }

        private static async Task<IResult> GetActiveStock(IStockData data)
        {
            try
            {
                var results = await data.GetActiveStock();
                if (results == null) return Results.NotFound();
                return Results.Ok(results);
            }
            catch (Exception ex)
            {
                return Results.Problem(ex.Message);
            }
        }

        private static async Task<IResult> GetStock(string stockNumber, IStockData data)
        {
            try
            {
                var results = await data.GetStock(stockNumber);
                if (results == null) return Results.NotFound();
                return Results.Ok(results);
            }
            catch (Exception ex)
            {
                return Results.Problem(ex.Message);
            }
        }

        private static async Task<IResult> InsertStock(StockModel stock, IStockData data)
        {
            try
            {
                await data.InsertStock(stock);
                return Results.Ok(await data.GetAllStock(1, 15));
            }
            catch (Exception ex)
            {
                return Results.Problem(ex.Message);
            }
        }

        private static async Task<IResult> UpdateStock(StockModel stock, IStockData data)
        {
            try
            {
                await data.UpdateStock(stock);
                return Results.Ok(await data.GetAllStock(1, 15));
            }
            catch (Exception ex)
            {
                return Results.Problem(ex.Message);
            }
        }

        private static async Task<IResult> DeleteStock(string stockNumber, IStockData data)
        {
            try
            {
                await data.DeleteStock(stockNumber);
                return Results.Ok(await data.GetAllStock(1, 15));
            }
            catch (Exception ex)
            {
                return Results.Problem(ex.Message);
            }
        }
        #endregion

        #region Reporting
        private static async Task<IResult> GetMonthlyRequests(string name, int? months, IRequestData data)
        {
            try
            {
                return Results.Ok(await data.GetRequestMonthly(name, months));
            }
            catch (Exception ex)
            {
                return Results.Problem(ex.Message);
            }
        }

        private static async Task<IResult> GetMonthlyDonations(string memberNumber, string year, IMemberData data)
        {
            try
            {
                return Results.Ok(await data.GetDonationsMonthly(memberNumber, year));
            }
            catch (Exception ex)
            {
                return Results.Problem(ex.Message);
            }
        }
        #endregion
    }
}
