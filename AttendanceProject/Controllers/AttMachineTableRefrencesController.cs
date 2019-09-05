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
    public class AttMachineTableRefrencesController : Controller
    {
        private AttendanceEntities db = new AttendanceEntities();

        // GET: AttMachineTableRefrences
        public ActionResult Index()
        {
            var attMachineTableRefrences = db.AttMachineTableRefrences.Include(a => a.AttMachine).Include(a => a.AttTableDefination);
            return View(attMachineTableRefrences.ToList());
        }

        // GET: AttMachineTableRefrences/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            AttMachineTableRefrence attMachineTableRefrence = db.AttMachineTableRefrences.Find(id);
            if (attMachineTableRefrence == null)
            {
                return HttpNotFound();
            }
            return View(attMachineTableRefrence);
        }

        // GET: AttMachineTableRefrences/Create
        public ActionResult Create()
        {
            //ViewBag.MachineID = new SelectList(db.AttMachines, "MachId", "MachineName");
            //ViewBag.TableID = new SelectList(db.AttTableDefinations, "TableId", "ColumnDefination");
            ViewBag.MachineID = db.AttMachines.ToList();
            ViewBag.TableID = db.AttTableDefinations.ToList();
            return View();
        }

        // POST: AttMachineTableRefrences/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "Id,MachineID,TableID")] AttMachineTableRefrence attMachineTableRefrence)
        {
            if (ModelState.IsValid)
            {
                db.AttMachineTableRefrences.Add(attMachineTableRefrence);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.MachineID = new SelectList(db.AttMachines, "MachId", "MachineName", attMachineTableRefrence.MachineID);
            ViewBag.TableID = new SelectList(db.AttTableDefinations, "TableId", "ColumnDefination", attMachineTableRefrence.TableID);
            return View(attMachineTableRefrence);
        }

        // GET: AttMachineTableRefrences/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            AttMachineTableRefrence attMachineTableRefrence = db.AttMachineTableRefrences.Find(id);
            if (attMachineTableRefrence == null)
            {
                return HttpNotFound();
            }
            ViewBag.MachineID = new SelectList(db.AttMachines, "MachId", "MachineName", attMachineTableRefrence.MachineID);
            ViewBag.TableID = new SelectList(db.AttTableDefinations, "TableId", "ColumnDefination", attMachineTableRefrence.TableID);
            return View(attMachineTableRefrence);
        }

        // POST: AttMachineTableRefrences/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "Id,MachineID,TableID")] AttMachineTableRefrence attMachineTableRefrence)
        {
            if (ModelState.IsValid)
            {
                db.Entry(attMachineTableRefrence).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.MachineID = new SelectList(db.AttMachines, "MachId", "MachineName", attMachineTableRefrence.MachineID);
            ViewBag.TableID = new SelectList(db.AttTableDefinations, "TableId", "ColumnDefination", attMachineTableRefrence.TableID);
            return View(attMachineTableRefrence);
        }

        // GET: AttMachineTableRefrences/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            AttMachineTableRefrence attMachineTableRefrence = db.AttMachineTableRefrences.Find(id);
            if (attMachineTableRefrence == null)
            {
                return HttpNotFound();
            }
            return View(attMachineTableRefrence);
        }

        // POST: AttMachineTableRefrences/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            AttMachineTableRefrence attMachineTableRefrence = db.AttMachineTableRefrences.Find(id);
            db.AttMachineTableRefrences.Remove(attMachineTableRefrence);
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
