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
    public class DirectorController : Controller
    {
        private ApplicationDbContext db = new ApplicationDbContext();

        // GET: Director
        public ActionResult Index()
        {
            List<Director> directori = db.Directori.ToList();
            ViewBag.Directori = directori;
            return View();
        }

        // Detalii
        public ActionResult Detalii(int? id)
        {
            if (id.HasValue)
            {
                Director director = db.Directori.Find(id);

                if (director != null)
                {
                    return View(director);
                }
                return HttpNotFound("Nu am putut găsi directorul cu id-ul " + id.ToString());
            }
            return HttpNotFound("Lipsește id-ul Directorului!");
        }


        // Create
        [HttpGet]
        public ActionResult New()
        {
            Director director = new Director();
            return View(director);
        }
        [HttpPost]
        public ActionResult New(Director director)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    db.Directori.Add(director);
                    db.SaveChanges();
                    return RedirectToAction("Index");
                }
                return View(director);
            }
            catch (Exception e) { return View(director); }
        }


        // Delete
        [HttpDelete]
        public ActionResult Delete(int? id)
        {
            if (id.HasValue)
            {
                Director f = db.Directori.Find(id);
                if (f == null)
                {
                    return HttpNotFound("Nu s-a găsit Directorul cu id-ul " + id.ToString() + "!");
                }
                db.Directori.Remove(f);
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return HttpNotFound("Lipsește parametrul id al Directorului!");
        }


        // Edit
        [HttpGet]
        public ActionResult Edit(int? id)
        {
            if (id.HasValue)
            {
                Director director = db.Directori.Find(id);
                if (director == null) return HttpNotFound("Nu am putut găsi directorul cu Id-ul " + id.ToString());
                
                return View(director);
            }
            return HttpNotFound("Lipseste parametrul Id al Directorului!");
        }
        [HttpPut]
        public ActionResult Edit(int id, Director d)
        {
            try
            {
                // preiau filmul pe care vreau să îl modific din bd (relații 1:m)
                Director director = db.Directori.SingleOrDefault(f => f.DirectorId.Equals(id));

                if (ModelState.IsValid)
                {
                    if (TryUpdateModel(director))
                    {
                        director.Nume = d.Nume;
                        director.Prenume = d.Prenume;
                        director.DataNastere = d.DataNastere;
                        director.Varsta = d.Varsta;
                        
                        db.SaveChanges();
                    }
                    return RedirectToAction("Index");
                }
                return View(d);
            }
            catch (Exception e)
            {
                return View(d);
            }
        }
    }
}