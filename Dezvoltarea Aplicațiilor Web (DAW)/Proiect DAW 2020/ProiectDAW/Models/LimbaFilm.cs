using Microsoft.SqlServer.Server;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ProiectDAW.Models
{
    public class LimbaFilm
    {
        [Key]
        public int LimbaId { get; set; }

        [Required, RegularExpression(@"^[A-Z]([a-z]+)$", ErrorMessage = "Limba Filmului trebuie să înceapă cu Majusculă și să conțină numai litere!"),
         MaxLength(20, ErrorMessage = "Numele nu poate avea mai mult de 20 de litere!")]
        public string Nume { get; set; }



        // one-to-many (1 Limbă -> n Filme & 1 Film -> 1 Limbă)
        public virtual ICollection<Film> Filme { get; set; }
    }
}