using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace ProiectDAW.Models
{
    public class CheckBoxViewModel
    {
        [Key] // PK al Genului de Film
        public int Id { get; set; }

        // Numele Genului de Film
        [Required, RegularExpression(@"^[A-Z]([a-z]+)$", ErrorMessage = "Genul Filmului trebuie să înceapă cu Majusculă și să conțină numai litere!")]
        public string Nume { get; set; }

        // Dacă este sau nu
        public bool Checked { get; set; }
    }
}