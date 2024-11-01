using Microsoft.SqlServer.Server;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using ProiectDAW.Models.MyValidations;

namespace ProiectDAW.Models
{
    public class Director
    {
        [Key]
        public int DirectorId { get; set; }

        [Required,
         MinLength(2, ErrorMessage = "Numele Directorului trebuie să aibă cel puțin 2 caractere!"),
         MaxLength(20, ErrorMessage = "Numele Directorului nu poate avea mai mult de 20 de caractere!"),
         RegularExpression(@"^(?=.{1,50}$)[a-zA-Z]+(?:[-'\s][a-zA-Z]+)*$", 
         ErrorMessage = "Numele trebuie să conțină doar litere și/sau: ' - ")]
        public string Nume { get; set; }

        [MinLength(2, ErrorMessage = "Prenumele Directorului trebuie să aibă cel puțin 2 caractere!"),
         MaxLength(20, ErrorMessage = "Prenumele Directorului nu poate avea mai mult de 30 de caractere!"),
         RegularExpression(@"^(?=.{1,50}$)[A-Z]([a-z]+)+(?:[-'\s][a-zA-Z]+)*$", 
         ErrorMessage = "Prenumele trebuie să înceapă cu majusculă și să conțină doar litere și/sau: ' - ")]
        public string Prenume { get; set; }

        [Required, 
         RegularExpression(@"^(?:(?:31(\/|-|\.)(?:0?[13578]|1[02]))\1|(?:(?:29|30)(\/|-|\.)(?:0?[13-9]|1[0-2])\2))(?:(?:1[6-9]|[2-9]\d)?\d{2})$|^(?:29(\/|-|\.)0?2\3(?:(?:(?:1[6-9]|[2-9]\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00))))$|^(?:0?[1-9]|1\d|2[0-8])(\/|-|\.)(?:(?:0?[1-9])|(?:1[0-2]))\4(?:(?:1[8-9]|[2-9]\d)?\d{2})$",
         ErrorMessage = "Format Dată Introdus Incorect sau Eroare An Bisect! (dd/mm/yy | dd.mm.yyyy | d-m-yyyy; yyyy >= 1900)")]
        public string DataNastere { get; set; }

        [VarstaValidator]
        public int Varsta { get; set; }



        // one-to-many (1 Director -> n Filme & 1 Film -> 1 Director)
        public virtual ICollection<Film> Filme { get; set; }
    }
}