using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace lab2.Controllers
{
    public class ExercisesController : Controller
    {
        public ContentResult SearchSequence(string word, string sentence)
        {
            string message = "Sentence " + sentence + " contians the word " + word + "!";
            string errorMessage = "Sentence " + sentence + " does NOT contian the word " + word + "!";
            string missingParameterMessage = "A parameter is missing!";

            if (word != null && sentence != null)
            {
                if (sentence.Contains(word))
                {
                    return Content(message);
                }
                return Content(errorMessage);
            }
            return Content(missingParameterMessage);
        }

        public ActionResult SearchSequenceOptional(string word, string? sentence)
        {
            ViewBag.message = "Sentence " + sentence + " contians the word " + word + "!";

            if(sentence == null)
            {
                return HttpNotFound("A parameter is missing!");
            }
            if (!sentence.Contains(word))
            {
                ViewBag.message = "Sentence " + sentence + " does not contian the word " + word + "!";
            }

            return View();
        }

        //[Route("Exercises/Ex3/{number:regex(^\\d{2,6}[02468]$)}")]
        [Route("Exercises/Ex3/{number:regex(^[1-9](\\d{1,5})[02468]$)}")]
        public string NumberRegexParser(int? number)
        {
            return "The input number is: " + number.ToString();
        }

        [Route("Parser/Ex4/{input:regex(^(a+)(b+)$)}")]
        public string RegexParser(string? input)
        {
            return "The input is: " + input;
        }

    }
}