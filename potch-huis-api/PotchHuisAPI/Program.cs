using DataAccess.DBAccess;
using PotchHuisAPI;

var MyAllowSpecificOrigins = "okay";

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddCors(options =>
{
    options.AddPolicy(name: MyAllowSpecificOrigins,
                      policy =>
                      {
                          policy.WithOrigins("http://localhost:3000", "http://localhost:3000/potch-huis-v1", "https://thinkbeerus.github.io").AllowAnyHeader().AllowAnyMethod();
                      });
});

builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();
builder.Services.AddSingleton<ISqlDataAccess, SqlDataAccess>();
builder.Services.AddSingleton<IMemberData, MemberData>();
builder.Services.AddSingleton<IStockData, StockData>();
builder.Services.AddSingleton<IDonationData, DonationData>();
builder.Services.AddSingleton<IRequestData, RequestData>();

var app = builder.Build();

if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseCors(MyAllowSpecificOrigins);

app.UseHttpsRedirection();

app.ConfigureApi();

app.Run();