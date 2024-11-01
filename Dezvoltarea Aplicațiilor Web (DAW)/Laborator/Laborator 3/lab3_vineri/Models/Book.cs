using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity;
using System.Linq;
using System.Web;

namespace lab3_vineri.Models
{
    public class Book
    {
        /*
         * Putem aplica mai multe atribute
         * [Key] marcheaza in mod explicit ca proprietatea trebuie sa fie o cheie primara PK
         * [Column("Book_id")] modifica numele coloanei din BD
         * [Key, Column("Book_ID")] putem pune mai multe atribute in interiorul []
         * 
         * By default, EF marcheaza BookId ca fiind un PK deoarece respecta "naming convention"
         */
        public int BookId { get; set; }

        // Validari
        //[MinLength(10), MaxLength(200)]
        /*[MinLength(10, ErrorMessage ="Title cannot be less than 10"),
            MaxLength(200, ErrorMessage ="Title cannot be more than 200")]*/
        public string Title { get; set; }
        public string Author { get; set; }
        public string Summary { get; set; }

        // many to many
        public virtual ICollection<Genre> Genres { get; set; }

        // one to many
        // Proprietatea PublisherId este marcata de EF ca fiind un FK (cheie externa) by default
        [Column("Publisher_Id")]
        public int PublisherId { get; set; }
        public virtual Publisher Publisher { get; set; }

        /*private int bookId;
        public int BookId
        {
            get { return bookId; }
            set { bookId = value; }
        }*/
    }
    public class DbCtx : DbContext
    {
        public DbCtx() : base("DbConnectionString")
        {
            Database.SetInitializer<DbCtx>(new Initp());
            //Database.SetInitializer<DbCtx>(new CreateDatabaseIfNotExists<DbCtx>());
            //Database.SetInitializer<DbCtx>(new DropCreateDatabaseIfModelChanges<DbCtx>());
            //Database.SetInitializer<DbCtx>(new DropCreateDatabaseAlways<DbCtx>());
        }
        public DbSet<Book> Books { get; set; }
        public DbSet<Genre> Genres { get; set; }
        public DbSet<Publisher> Publishers{ get; set; }
        public DbSet<ContactInfo> ContactsInfo { get; set; }
    }
    public class Initp : DropCreateDatabaseIfModelChanges<DbCtx>
    {
        protected override void Seed(DbCtx ctx)
        {
            ctx.Books.Add(new Book
            {
                Title = "The Atomic Times",
                Author = "Michael Harris",
                Publisher = new Publisher { Name = "HarperCollins", ContactInfo = new ContactInfo { PhoneNumber = "07123456789" } },
                Genres = new List<Genre> {
                    new Genre { Name = "Horror"}
                }           
            });
            ctx.Books.Add(new Book
            {
                Title = "In Defense of Elitism",
                Author = "Joel Stein",
                Publisher = new Publisher { Name = "Macmillan Publishers", ContactInfo = new ContactInfo { PhoneNumber = "07123458789" } },
                Genres = new List<Genre> {
                    new Genre { Name = "Humor"}
                }
            });
            ctx.Books.Add(new Book
            {
                Title = "The Canterbury Tales",
                Author = "Geoffrey Chaucer",
                Summary = "At the Tabard Inn, a tavern in Southwark, near London, the narrator joins a company of twenty-nine pilgrims. The pilgrims, like the narrator, are traveling to the shrine of the martyr Saint Thomas Becket in Canterbury. The narrator gives a descriptive account of twenty-seven of these pilgrims, including a Knight, Squire, Yeoman, Prioress, Monk, Friar, Merchant, Clerk, Man of Law, Franklin, Haberdasher, Carpenter, Weaver, Dyer, Tapestry-Weaver, Cook, Shipman, Physician, Wife, Parson, Plowman, Miller, Manciple, Reeve, Summoner, Pardoner, and Host. (He does not describe the Second Nun or the Nun’s Priest, although both characters appear later in the book.) The Host, whose name, we find out in the Prologue to the Cook’s Tale, is Harry Bailey, suggests that the group ride together and entertain one another with stories. He decides that each pilgrim will tell two stories on the way to Canterbury and two on the way back. Whomever he judges to be the best storyteller will receive a meal at Bailey’s tavern, courtesy of the other pilgrims. The pilgrims draw lots and determine that the Knight will tell the first tale.",
                Publisher = new Publisher { Name = "Scholastic", ContactInfo = new ContactInfo { PhoneNumber = "07113456789" } },
                Genres = new List<Genre> {
                    new Genre { Name = "Satire"},
                    new Genre { Name = "Fabilau"},
                    new Genre { Name = "Allegory"},
                    new Genre { Name = "Burlesque"}
                    }
            });
            ctx.Books.Add(new Book
            {
                Title = "Python Crash Course, 2nd Edition: A Hands-On, Project-Based Introduction to Programming",
                Author = "Eric Matthers",
                Publisher = new Publisher { Name = "Schol", ContactInfo = new ContactInfo { PhoneNumber = "07126656789" } },

                Genres = new List<Genre> {
                     new Genre { Name = "Programming" }
                }
            });
            
            ctx.SaveChanges();
            base.Seed(ctx);
        }
    }
}