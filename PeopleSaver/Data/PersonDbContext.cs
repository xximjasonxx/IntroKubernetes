using Microsoft.EntityFrameworkCore;

namespace PeopleSaver.Data
{
    public class PersonDbContext : DbContext, IContext
    {
        public DbSet<Person> People { get; set; }

        public PersonDbContext(DbContextOptions<PersonDbContext> options)
            : base(options)
        {
            
        }
    }

    public interface IContext
    {
        DbSet<Person> People { get; }

        Task<int> SaveChangesAsync(CancellationToken token = default);
    }
}