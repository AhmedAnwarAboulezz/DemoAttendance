using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using AttendanceProject.Models;

namespace AttendanceProject.Controllers
{
    public class FileRefrencesController : Controller
    {
        private AttendanceEntities db = new AttendanceEntities();

        // GET: FileRefrences
        public ActionResult Index()
        {
            return View(db.FileRefrences.ToList());
        }

        // GET: FileRefrences/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            FileRefrence fileRefrence = db.FileRefrences.Find(id);
            if (fileRefrence == null)
            {
                return HttpNotFound();
            }
            return View(fileRefrence);
        }

        // GET: FileRefrences/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: FileRefrences/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "Id,FileNumber,FilePath,Comment,CreatedDate,IsActive")] FileRefrence fileRefrence)
        {
            if (ModelState.IsValid)
            {
                db.FileRefrences.Add(fileRefrence);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            return View(fileRefrence);
        }

        // GET: FileRefrences/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            FileRefrence fileRefrence = db.FileRefrences.Find(id);
            if (fileRefrence == null)
            {
                return HttpNotFound();
            }
            return View(fileRefrence);
        }

        // POST: FileRefrences/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "Id,FileNumber,FilePath,Comment,CreatedDate,IsActive")] FileRefrence fileRefrence)
        {
            if (ModelState.IsValid)
            {
                db.Entry(fileRefrence).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(fileRefrence);
        }

        // GET: FileRefrences/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            FileRefrence fileRefrence = db.FileRefrences.Find(id);
            if (fileRefrence == null)
            {
                return HttpNotFound();
            }
            return View(fileRefrence);
        }

        // POST: FileRefrences/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            FileRefrence fileRefrence = db.FileRefrences.Find(id);
            string fullPath = Request.MapPath("~/" + fileRefrence.FilePath);
            if (System.IO.File.Exists(fullPath))
            {
                System.IO.File.Delete(fullPath);
            }
            db.FileRefrences.Remove(fileRefrence);
            db.SaveChanges();
            return RedirectToAction("Index");
        }



        public ActionResult EnableActive(int? fileid, int check)
        {

            if (fileid != null)
            {
                var updatedfile = db.FileRefrences.Where(c => c.Id == fileid).FirstOrDefault();
                updatedfile.IsActive = check;
                db.Entry(updatedfile).State = EntityState.Modified;
                db.SaveChanges();
                return Json(new { message = "Process done Successfully" });
            }
            return Json(new { message = "Something went wrong" });
        }





        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
