using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using AttendanceProject.Models;
using System.Reflection;

namespace AttendanceProject.Controllers
{
    public class AttTableDefinationsController : Controller
    {
        private AttendanceEntities db = new AttendanceEntities();



        // GET: AttTableDefinations
        public ActionResult Index()
        {
            var attTableDefinations = db.AttTableDefinations.Include(a => a.Senario);
            return View(attTableDefinations.ToList());
        }

        // GET: AttTableDefinations/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            AttTableDefination attTableDefination = db.AttTableDefinations.Find(id);
            if (attTableDefination == null)
            {
                return HttpNotFound();
            }
            return View(attTableDefination);
        }

        // GET: AttTableDefinations/Create
        public ActionResult Create()
        {

            ViewBag.SenarioID = new SelectList(db.Senarios, "Id", "SenarioName");
            List<int> senario1 = new List<int> { 6, 1, 2, 3, 7, 8 };
            List<int> senario2 = new List<int> { 6, 1, 4, 5, 7, 8 };
            var Allcolumn = typeof(AttendanceLog).GetMembers().Where(p => p.MemberType == MemberTypes.Property).Select(a=>a.Name).ToList();
            ViewBag.DefinationColumns = Allcolumn;
            ViewBag.senario1 = senario1;
            ViewBag.senario2 = senario2;
            return View();
        }

        // POST: AttTableDefinations/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "TableId,SenarioID,ColumnDefination,ColumnOrder,IsDeleted")] AttTableDefination attTableDefination)
        {
            if (ModelState.IsValid)
            {
                db.AttTableDefinations.Add(attTableDefination);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.SenarioID = new SelectList(db.Senarios, "Id", "SenarioName", attTableDefination.SenarioID);
            return View(attTableDefination);
        }

        // GET: AttTableDefinations/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            AttTableDefination attTableDefination = db.AttTableDefinations.Find(id);
            if (attTableDefination == null)
            {
                return HttpNotFound();
            }
            ViewBag.SenarioID = new SelectList(db.Senarios, "Id", "SenarioName", attTableDefination.SenarioID);
            return View(attTableDefination);
        }

        // POST: AttTableDefinations/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "TableId,SenarioID,ColumnDefination,ColumnOrder,IsDeleted")] AttTableDefination attTableDefination)
        {
            if (ModelState.IsValid)
            {
                db.Entry(attTableDefination).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.SenarioID = new SelectList(db.Senarios, "Id", "SenarioName", attTableDefination.SenarioID);
            return View(attTableDefination);
        }

        // GET: AttTableDefinations/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            AttTableDefination attTableDefination = db.AttTableDefinations.Find(id);
            if (attTableDefination == null)
            {
                return HttpNotFound();
            }
            return View(attTableDefination);
        }

        // POST: AttTableDefinations/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            AttTableDefination attTableDefination = db.AttTableDefinations.Find(id);
            db.AttTableDefinations.Remove(attTableDefination);
            db.SaveChanges();
            return RedirectToAction("Index");
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
