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
    public class GenFilm
    {
        [Key]
        public int GenId { get; set; }

        [Required, RegularExpression(@"^[A-Z]([a-z]+)$", ErrorMessage = "Genul Filmului trebuie să înceapă cu Majusculă și să conțină numai litere!")]
        public string Nume { get; set; }



        // many-to-many (1 Gen -> n Filme & 1 Film -> n Genuri)
        public virtual ICollection<Film> Filme { get; set; }


        // one-to-one (1 Gen -> 1 Guideline & 1 Guideline -> 1 Gen)
        [Required]
        public virtual Guideline Guideline { get; set; }
    }
}