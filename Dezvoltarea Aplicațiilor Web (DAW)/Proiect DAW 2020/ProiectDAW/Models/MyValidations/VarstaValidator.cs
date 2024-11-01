using Microsoft.SqlServer.Server;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using ProiectDAW.Models;
using System.Globalization;

namespace ProiectDAW.Models.MyValidations
{
    public class VarstaValidator: ValidationAttribute
    {
        protected override ValidationResult IsValid(object value, ValidationContext validationContext)
        {
            Director director = (Director)validationContext.ObjectInstance;
            
            int varsta = director.Varsta;
            string dataN = director.DataNastere;
            if(dataN == null) return new ValidationResult("Trebuie să introduceți data de naștere!");
            int anActual = @DateTime.Now.Year;
            int lungimeDataN = dataN.Length;

            string anS;  // iau anul din string
            int an, varstaCorecta; // pun anul din string in int; calculez cat tb sa fie varsta

            switch(lungimeDataN)
            {
                case 6:  //d-m-yy (19 = yy)
                    anS = dataN.Substring(4, 2);
                    an = int.Parse(anS);
                    varstaCorecta = anActual - (1900 + an);
                    if (varstaCorecta == varsta) return ValidationResult.Success;
                    break;
                case 7: // dd.m.yy || d.mm.yy
                    anS = dataN.Substring(5, 2);
                    an = int.Parse(anS);
                    varstaCorecta = anActual - (1900 + an);
                    if (varstaCorecta == varsta) return ValidationResult.Success;
                    break;
                case 8:  // dd/mm/yy
                    if (!Char.IsNumber(dataN[5]))
                    {
                        anS = dataN.Substring(6, 2);
                        an = int.Parse(anS);
                        varstaCorecta = anActual - (1900 + an);
                        if (varstaCorecta == varsta) return ValidationResult.Success;
                        break;
                    }
                    else  //d.m.yyyy
                    {
                        anS = dataN.Substring(4, 4);
                        an = int.Parse(anS);
                        varstaCorecta = anActual - an;
                        if (varstaCorecta == varsta) return ValidationResult.Success;
                        break;
                    }
                case 9:  // dd-m-yyyy || d-mm-yyyy  
                    anS = dataN.Substring(5, 4);
                    an = int.Parse(anS);
                    varstaCorecta = anActual - an;
                    if (varstaCorecta == varsta) return ValidationResult.Success;
                    break;
                case 10:  // dd/mm/yyyy
                    anS = dataN.Substring(6, 4);
                    an = int.Parse(anS);
                    varstaCorecta = anActual - an;
                    if (varstaCorecta == varsta) return ValidationResult.Success;
                    break;
            }

            return new ValidationResult("Vârsta introdusă nu este corectă!");
        }
    }
}