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
    public class GenGuidelineViewModel
    {
        // Nume Gen Film
        [Required, RegularExpression(@"^[A-Z]([a-z]+)$", ErrorMessage = "Genul Filmului trebuie să înceapă cu Majusculă și să conțină numai litere!")]
        public string Nume { get; set; }

        // Vârstă Gen Film
        [Required,
         RegularExpression(@"^(?:[3-9]|1[0-9]|2[0-3])$",
         ErrorMessage = "Introduceți o Vârstă Validă! (3 - 23)")]
        public int Varsta { get; set; }

        // Mesaj în Funcție de Vârstă
        [MinLength(3, ErrorMessage = "Mesajul trebuie să aibă cel puțin 3 caractere!"),
         MaxLength(500, ErrorMessage = "Mesajul nu poate avea mai mult de 300 de caractere!")]
        public string Mesaj { get; set; }
    }
}