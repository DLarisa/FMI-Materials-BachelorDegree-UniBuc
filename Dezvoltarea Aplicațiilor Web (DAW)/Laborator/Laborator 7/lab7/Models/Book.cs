using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;

namespace lab7.Models
{
    public class Book
    {
        public int BookId { get; set; }
        public string Title { get; set; }
        public string Author { get; set; }

    }
    public class DbCtx : DbContext
    {
        public DbCtx() : base("DbConnectionString")
        { 
            Database.SetInitializer<DbCtx>(new DropCreateDatabaseIfModelChanges<DbCtx>());
        }
        public DbSet<Book> Books { get; set; }
    }
}
