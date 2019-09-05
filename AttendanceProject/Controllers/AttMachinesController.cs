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
    public class AttMachinesController : Controller
    {
        private AttendanceEntities db = new AttendanceEntities();

        // GET: AttMachines
        public ActionResult Index()
        {
            var attMachines = db.AttMachines.Include(a => a.Senario);
            return View(attMachines.ToList());
        }

        // GET: AttMachines/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            AttMachine attMachine = db.AttMachines.Find(id);
            if (attMachine == null)
            {
                return HttpNotFound();
            }
            return View(attMachine);
        }

        // GET: AttMachines/Create
        public ActionResult Create()
        {
            ViewBag.SenarioID = new SelectList(db.Senarios, "Id", "SenarioName");
            return View();
        }

        // POST: AttMachines/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "MachId,MachineName,SenarioID,IsDeleted")] AttMachine attMachine)
        {
            if (ModelState.IsValid)
            {
                db.AttMachines.Add(attMachine);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.SenarioID = new SelectList(db.Senarios, "Id", "SenarioName", attMachine.SenarioID);
            return View(attMachine);
        }

        // GET: AttMachines/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            AttMachine attMachine = db.AttMachines.Find(id);
            if (attMachine == null)
            {
                return HttpNotFound();
            }
            ViewBag.SenarioID = new SelectList(db.Senarios, "Id", "SenarioName", attMachine.SenarioID);
            return View(attMachine);
        }

        // POST: AttMachines/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "MachId,MachineName,SenarioID,IsDeleted")] AttMachine attMachine)
        {
            if (ModelState.IsValid)
            {
                db.Entry(attMachine).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.SenarioID = new SelectList(db.Senarios, "Id", "SenarioName", attMachine.SenarioID);
            return View(attMachine);
        }

        // GET: AttMachines/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            AttMachine attMachine = db.AttMachines.Find(id);
            if (attMachine == null)
            {
                return HttpNotFound();
            }
            return View(attMachine);
        }

        // POST: AttMachines/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            AttMachine attMachine = db.AttMachines.Find(id);
            db.AttMachines.Remove(attMachine);
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
