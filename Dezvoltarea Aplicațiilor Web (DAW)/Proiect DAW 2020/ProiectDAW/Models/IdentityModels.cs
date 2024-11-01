using System.Collections.Generic;
using System.Data.Entity;
using System.Security.Claims;
using System.Threading.Tasks;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;

namespace ProiectDAW.Models
{
    // You can add profile data for the user by adding more properties to your ApplicationUser class, please visit https://go.microsoft.com/fwlink/?LinkID=317594 to learn more.
    public class ApplicationUser : IdentityUser
    {
        public async Task<ClaimsIdentity> GenerateUserIdentityAsync(UserManager<ApplicationUser> manager)
        {
            // Note the authenticationType must match the one defined in CookieAuthenticationOptions.AuthenticationType
            var userIdentity = await manager.CreateIdentityAsync(this, DefaultAuthenticationTypes.ApplicationCookie);
            // Add custom user claims here
            return userIdentity;
        }
    }

    public class ApplicationDbContext : IdentityDbContext<ApplicationUser>
    {
        public ApplicationDbContext()
            : base("DefaultConnection", throwIfV1Schema: false)
        {
            Database.SetInitializer<ApplicationDbContext>(new Initp());
        }



        // Baza de Date
        public DbSet<Film> Filme { get; set; }
        public DbSet<Director> Directori { get; set; }
        public DbSet<LimbaFilm> LimbaFilme { get; set; }
        public DbSet<GenFilm> GenFilme { get; set; }
        public DbSet<Guideline> Guidelines { get; set; }



        public static ApplicationDbContext Create()
        {
            return new ApplicationDbContext();
        }


        // Inițializare Baza de Date
        public class Initp : DropCreateDatabaseAlways<ApplicationDbContext>
        {
            protected override void Seed(ApplicationDbContext context)
            {
                context.Filme.Add(new Film
                {
                    Nume = "Yesterday",
                    An = 2019,
                    Descriere = "A struggling musician realizes he's the only person on Earth who can remember The Beatles after waking up in an alternate timeline where they never existed.",
                    NrPremii = 1,
                    Director = new Director
                    {
                        Nume = "Boyle",
                        Prenume = "Danny",
                        DataNastere = "20/10/1956",
                        Varsta = 65
                    },
                    LimbaFilm = new LimbaFilm { Nume = "Engleza"},
                    GenFilme = new List<GenFilm>
                            {
                                new GenFilm {
                                    Nume = "Comedie",
                                    Guideline = new Guideline
                                    {
                                        Varsta = 14,
                                        Mesaj = "Este recomandata vizionarea filmului de catre copii alaturi de un adult."
                                    }
                                },
                                new GenFilm {
                                    Nume = "Muzical",
                                    Guideline = new Guideline
                                    {
                                        Varsta = 10,
                                        Mesaj = "Filmul poate fi vizionat si fara parinti."
                                    }
                                },
                                new GenFilm {
                                    Nume = "Fantezie",
                                    Guideline = new Guideline
                                    {
                                        Varsta = 12,
                                        Mesaj = "Unele scene pot contine violenta de limbaj."
                                    }
                                }
                            }
                });
                context.Filme.Add(new Film
                {
                    Nume = "Parasite (기생충)",
                    An = 2019,
                    Descriere = "Greed and class discrimination threaten the newly formed symbiotic relationship between the wealthy Park family and the destitute Kim clan.",
                    NrPremii = 275,
                    Director = new Director
                    {
                        Nume = "Bong",
                        Prenume = "Joon Ho",
                        DataNastere = "14/09/1969",
                        Varsta = 52
                    },
                    LimbaFilm = new LimbaFilm { Nume = "Coreana" },
                    GenFilme = new List<GenFilm>
                            {
                                new GenFilm {
                                    Nume = "Drama",
                                    Guideline = new Guideline
                                    {
                                        Varsta = 16,
                                        Mesaj = "Nu este recomandat pentru o audiență tânără, dar poate fi vizionat împreună cu un adult."
                                    }
                                },
                                new GenFilm {
                                    Nume = "Satira",
                                    Guideline = new Guideline
                                    {
                                        Varsta = 13,
                                        Mesaj = "Nu există nicio restricție, dar audiența tânără ar putea să nu savureze acest film datorită temelor prezentate."
                                    }
                                }
                            }
                });
                context.Filme.Add(new Film
                {
                    Nume = "La princesse de Montpensier",
                    An = 2010,
                    Descriere = "The film presents the romanticized love story between the young Henri de Guise and Mademoiselle de Mézière, forced to marry the Prince of Montpensier, following a political agreement between their fathers, the Marquis de Mézières and the Duke of Montpensier.",
                    NrPremii = 2,
                    Director = new Director
                    {
                        Nume = "Tavernier",
                        Prenume = "Bertrand",
                        DataNastere = "25/04/1941",
                        Varsta = 80
                    },
                    LimbaFilm = new LimbaFilm { Nume = "Franceza" },
                    GenFilme = new List<GenFilm>
                            {
                                new GenFilm {
                                    Nume = "Actiune",
                                    Guideline = new Guideline
                                    {
                                        Varsta = 15,
                                        Mesaj = "Filmul poate conține acțiuni care pot produce vătămări corporale."
                                    }
                                },
                                new GenFilm {
                                    Nume = "Istoric",
                                    Guideline = new Guideline
                                    {
                                        Varsta = 9,
                                        Mesaj = "Acest film abordează teme istorice și poate fi urmărit fără supervizia unui adult."
                                    }
                                }
                            }
                });


                context.SaveChanges();
                base.Seed(context);
            }
        }
    }
}