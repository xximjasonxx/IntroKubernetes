
using Azure.Identity;
using Microsoft.EntityFrameworkCore;
using PeopleSaver.Data;

var builder = WebApplication.CreateBuilder(args);
var options = new DefaultAzureCredentialOptions
{
    ManagedIdentityClientId = builder.Configuration["ManagedIdentityClientId"],
    ExcludeEnvironmentCredential = true,
    ExcludeSharedTokenCacheCredential = true,
    ExcludeVisualStudioCredential = true,
    ExcludeVisualStudioCodeCredential = true
};

builder.Configuration.AddAzureKeyVault(new Uri($"https://{builder.Configuration["VaultName"]}.vault.azure.net/"), new DefaultAzureCredential(options));

// Add services to the container.
builder.Services.AddControllersWithViews();
builder.Services.AddDbContext<IContext, PersonDbContext>(options =>
{
    var connectionString = builder.Configuration["ConnectionString"];
    options.UseSqlServer(connectionString);
});

var app = builder.Build();

if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Home/Error");
    app.UseHsts();
}

app.UseHttpsRedirection();
app.UseStaticFiles();

app.UseRouting();

app.UseAuthorization();

app.MapControllerRoute(
    name: "default",
    pattern: "{controller=Home}/{action=Index}/{id?}");

app.Run();
