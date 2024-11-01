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
    public class Film
    {
        [Key]
        public int FilmId { get; set; }

        [Required,
         MinLength(3, ErrorMessage = "Titlul Filmului trebuie să aibă cel puțin 3 caractere!"),
         MaxLength(150, ErrorMessage = "Titlul Filmului nu poate avea mai mult de 150 de caractere!")]
        public string Nume { get; set; }

        [RegularExpression(@"^((19[2-9][0-9])|(20[0-1][0-9]))$",
         ErrorMessage = "Introduceți un An valid (1920 - 2019)")]  // vezi dacă poți să pui exemplul corect în căsuță înainte să scrie omul în ea
        public int An { get; set; }

        [MaxLength(1000, ErrorMessage = "Descrierea Filmului nu poate avea mai mult de 500 de caractere!")]
        public string Descriere { get; set; }

        [RegularExpression(@"^(\d|\d{2}|\d{3})$",
         ErrorMessage = "Introduceți un Nr valid de Premii (0 - 999)")]
        public int NrPremii { get; set; }



        // one-to-many (1 Film -> 1 Director & 1 Director -> n Filme)
        [ForeignKey("Director")]
        public int DirectorId { get; set; }
        public virtual Director Director { get; set; }
        [NotMapped]   // dropdown list
        public IEnumerable<SelectListItem> DirectorList { get; set; }


        //// one-to-many(1 Film -> 1 Limbă & 1 Limbă -> n Filme)
        [ForeignKey("LimbaFilm")]
        public int LimbaId { get; set; }
        public virtual LimbaFilm LimbaFilm { get; set; }
        [NotMapped]   // dropdown list
        public IEnumerable<SelectListItem> LimbaFilmList { get; set; }


        //// many-to-many (1 Film -> n Genuri & 1 Gen -> n Filme)
        public virtual ICollection<GenFilm> GenFilme { get; set; }
        [NotMapped]   // Lista de CheckBox-uri
        public List<CheckBoxViewModel> GenFilmList { get; set; }
    }
}