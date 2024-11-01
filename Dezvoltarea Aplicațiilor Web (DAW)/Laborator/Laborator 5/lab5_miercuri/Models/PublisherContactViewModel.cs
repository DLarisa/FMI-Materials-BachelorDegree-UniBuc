using lab3_miercuri.Models.MyValidation;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace lab3_miercuri.Models
{
    public class PublisherContactViewModel
    {
        [MinLength(2, ErrorMessage = "Publisher name cannot be less than 2!"),
       MaxLength(30, ErrorMessage = "Publisher name cannot be more than 30!")]
        public string Name { get; set; }

        [RegularExpression(@"^07(\d{8})$", ErrorMessage = "This is not a valid phone number!")]
        public string PhoneNumber { get; set; }

        [CNPValidator]
        public string CNP { get; set; }

        [Required, RegularExpression(@"^[1-9](\d{3})$", ErrorMessage = "This is not a valid year!")]
        public int BirthYear { get; set; }

        [Required, RegularExpression(@"^(0[1-9])|(1[012])$", ErrorMessage = "This is not a valid month!")]
        public string BirthMonth { get; set; }

        [Required, RegularExpression(@"^((0[1-9])|([12]\d)|(3[01]))$", ErrorMessage = "This is not a valid day number!")]
        public string BirthDay { get; set; }

        [Required]
        public Gender GenderType { get; set; }

        public bool Resident { get; set; }

        [Required]
        public int RegionId { get; set; }
    }
}