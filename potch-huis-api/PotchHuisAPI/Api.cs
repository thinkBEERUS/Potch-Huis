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
            app.MapPost("/Members", InsertMember);
            app.MapPut("/Members", UpdateMember);
            app.MapDelete("/Members", DeleteMember);
            //Auth
            app.MapGet("/Members/Auth", AuthenticateMember);
            app.MapPost("/Members/Auth", InsertPassword);
            app.MapPut("/Members/Auth", UpdatePassword);
            //Stock
            app.MapGet("/AllStock", GetAllStock);
            app.MapGet("/ActiveStock", GetActiveStock);
            app.MapGet("/Stock/{name}", GetStock);
            app.MapPost("/Stock", InsertStock);
            app.MapPut("/Stock", UpdateStock);
            app.MapDelete("/Stock", DeleteStock);
        }
        #endregion

        #region Members
        private static async Task<IResult> GetMembers(IMemberData data)
        {
            try
            {
                return Results.Ok(await data.GetMembers());
            }
            catch(Exception ex)
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
                return Results.Ok();
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
                return Results.Ok();
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
                return Results.Ok();
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
                if (results == null) return Results.NotFound();
                if (results.Salt != null && results.Hash != null)
                {
                    bool validMember = Authentication.AuthenticateMember(password, results.Salt, results.Hash);
                    if (!validMember) return Results.Text("Unable to Authenticate Member");
                    return Results.Ok("Member Authenticated");
                } else
                {
                    return Results.NotFound();
                }                
            }
            catch (Exception ex)
            {
                return Results.Problem(ex.Message);
            }
        }
        #endregion

        #region Stock
        private static async Task<IResult> GetAllStock(IStockData data)
        {
            try
            {
                return Results.Ok(await data.GetAllStock());
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

        private static async Task<IResult> GetStock(string name, IStockData data)
        {
            try
            {
                var results = await data.GetStock(name);
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
                return Results.Ok();
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
                return Results.Ok();
            }
            catch (Exception ex)
            {
                return Results.Problem(ex.Message);
            }
        }

        private static async Task<IResult> DeleteStock(string name, IStockData data)
        {
            try
            {
                await data.DeleteStock(name);
                return Results.Ok();
            }
            catch (Exception ex)
            {
                return Results.Problem(ex.Message);
            }
        }
        #endregion
    }
}
