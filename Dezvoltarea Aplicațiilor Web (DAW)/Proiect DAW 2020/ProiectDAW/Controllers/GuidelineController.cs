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
    public class GuidelineController : Controller
    {
        private ApplicationDbContext db = new ApplicationDbContext();

        // GET: Guideline
        public ActionResult Index()
        {
            List<Guideline> genuri = db.Guidelines.ToList();
            ViewBag.Guidelines = genuri;

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
            Guideline guideline = db.Guidelines.Find(id);

            if (guideline != null)
            {
                List<GenFilm> genuri = db.GenFilme.ToList();
                foreach (var gen in genuri)
                    if (gen.Guideline.Id == id) db.GenFilme.Remove(gen);
                db.Guidelines.Remove(guideline);
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return HttpNotFound("Nu s-a găsit Guideline cu id-ul " + id.ToString() + "!");
        }


        // Edit
        [HttpGet]
        public ActionResult Edit(int? id)
        {
            if (id.HasValue)
            {
                Guideline g = db.Guidelines.Find(id);
                if (g == null) return HttpNotFound("Nu am putut găsi Guideline cu Id-ul " + id.ToString());
                return View(g);
            }
            return HttpNotFound("Lipsește parametrul Id al Guideline-ului!");
        }
        [HttpPut]
        public ActionResult Edit(int id, Guideline guideline)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    Guideline g = db.Guidelines.Find(id);
                    if (TryUpdateModel(g))
                    {
                        g.Varsta = guideline.Varsta;
                        g.Mesaj = guideline.Mesaj;
                        db.SaveChanges();
                    }
                    return RedirectToAction("Index");
                }
                return View(guideline);
            }
            catch (Exception e)
            {
                return View(guideline);
            }
        }
    }
}