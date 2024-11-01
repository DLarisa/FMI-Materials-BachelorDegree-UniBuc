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
    [Authorize(Roles = "Moderator, Admin")]
    public class LimbaFilmController : Controller
    {
        private ApplicationDbContext db = new ApplicationDbContext();

        // GET: LimbaFilm
        public ActionResult Index()
        {
            List<LimbaFilm> lbFilme = db.LimbaFilme.ToList();
            ViewBag.LimbaFilme = lbFilme;
            return View();
        }


        // Create
        [HttpGet]
        public ActionResult New()
        {
            LimbaFilm lbFilm = new LimbaFilm();
            return View(lbFilm);
        }
        [HttpPost]
        public ActionResult New(LimbaFilm limbaFilm)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    db.LimbaFilme.Add(limbaFilm);
                    db.SaveChanges();
                    return RedirectToAction("Index");
                }
                return View(limbaFilm);
            }
            catch (Exception e) { return View(limbaFilm); }
        }


        // Delete
        [HttpDelete]
        public ActionResult Delete(int? id)
        {
            if (id.HasValue)
            {
                LimbaFilm f = db.LimbaFilme.Find(id);
                if (f == null)
                {
                    return HttpNotFound("Nu s-a găsit limba filmului cu id-ul " + id.ToString() + "!");
                }
                db.LimbaFilme.Remove(f);
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return HttpNotFound("Lipsește parametrul id al Limbii Filmului!");
        }


        // Edit
        [HttpGet]
        public ActionResult Edit(int? id)
        {
            if (id.HasValue)
            {
                LimbaFilm f = db.LimbaFilme.Find(id);
                if (f == null) return HttpNotFound("Nu am putut găsi limba filmului cu Id-ul " + id.ToString());
                return View(f);
            }
            return HttpNotFound("Lipseste parametrul Id al Limbii Filmului!");
        }
        [HttpPut]
        public ActionResult Edit(int id, LimbaFilm f)
        {
            try
            {
                LimbaFilm lbFilm = db.LimbaFilme.SingleOrDefault(l => l.LimbaId.Equals(id));

                if (ModelState.IsValid)
                {
                    if (TryUpdateModel(lbFilm))
                    {
                        lbFilm.Nume = f.Nume;
                        
                        db.SaveChanges();
                    }
                    return RedirectToAction("Index");
                }
                return View(f);
            }
            catch (Exception e)
            {
                return View(f);
            }
        }
    }
}