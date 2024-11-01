using System;
using System.Collections.Generic;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using ProiectDAW.Models;

namespace ProiectDAW.Controllers
{
    [Authorize(Roles = "Admin")]
    public class GenFilmController : Controller
    {
        private ApplicationDbContext db = new ApplicationDbContext();

        // GET: GenFilm
        public ActionResult Index()
        {
            List<GenFilm> genuri = db.GenFilme.ToList();
            ViewBag.GenFilme = genuri;

            return View();
        }


        // Create
        [HttpGet]
        public ActionResult New()
        {
            GenGuidelineViewModel gg = new GenGuidelineViewModel();
            return View(gg);
        }
        [HttpPost]
        public ActionResult New(GenGuidelineViewModel gg)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    Guideline guideline = new Guideline
                    {
                        Varsta = gg.Varsta,
                        Mesaj = gg.Mesaj,
                    };
                    db.Guidelines.Add(guideline);

                    GenFilm gen = new GenFilm
                    {
                        Nume = gg.Nume,
                        Guideline = guideline
                    };
                    db.GenFilme.Add(gen);

                    db.SaveChanges();
                    return RedirectToAction("Index");
                }
                return View(gg);
            }
            catch (Exception e) { return View(gg); }
        }


        // Delete
        [HttpDelete]
        public ActionResult Delete(int id)
        {
            GenFilm gen = db.GenFilme.Find(id);
            Guideline guideline = db.Guidelines.Find(gen.Guideline.Id);

            if (gen != null)
            {
                db.GenFilme.Remove(gen);
                db.Guidelines.Remove(guideline);
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return HttpNotFound("Nu s-a găsit genul filmului cu id-ul " + id.ToString() + "!");
        }


        // Edit
        [HttpGet]
        public ActionResult Edit(int? id)
        {
            if (id.HasValue)
            {
                GenFilm gen = db.GenFilme.Find(id);
                if (gen == null) return HttpNotFound("Nu am putut găsi genul filmului cu Id-ul " + id.ToString());
                return View(gen);
            }
            return HttpNotFound("Lipsește parametrul Id al genului de film!");
        }
        [HttpPut]
        public ActionResult Edit(int id, GenFilm gen)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    GenFilm GenFilm = db.GenFilme.Find(id);
                    Guideline g = db.Guidelines.Find(gen.Guideline.Id);
                    if (TryUpdateModel(GenFilm))
                    {
                        GenFilm.Nume = gen.Nume;
                        g.Varsta = gen.Guideline.Varsta;
                        g.Mesaj = gen.Guideline.Mesaj;
                        db.SaveChanges();
                    }
                    return RedirectToAction("Index");
                }
                return View(gen);
            }
            catch (Exception e)
            {
                return View(gen);
            }
        }
    }
}