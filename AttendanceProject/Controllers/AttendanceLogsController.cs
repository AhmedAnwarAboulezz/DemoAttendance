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
    public class AttendanceLogsController : Controller
    {
        private AttendanceEntities db = new AttendanceEntities();

        // GET: AttendanceLogs
        public ActionResult Index()
        {
            var attendanceLogs = db.AttendanceLogs.Include(a => a.AttMachineTableRefrence).Include(a => a.Employee);
            return View(attendanceLogs.ToList());
        }

        // GET: AttendanceLogs/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            AttendanceLog attendanceLog = db.AttendanceLogs.Find(id);
            if (attendanceLog == null)
            {
                return HttpNotFound();
            }
            return View(attendanceLog);
        }

        // GET: AttendanceLogs/Create
        public ActionResult Create()
        {
            ViewBag.MachineTableID = new SelectList(db.AttMachineTableRefrences, "Id", "Id");
            ViewBag.EmployeeID = new SelectList(db.Employees, "EmployeeId", "ReferenceNumber");
            return View();
        }

        // POST: AttendanceLogs/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "Id,Date,TimeIN,TimeOut,TimeFunction,FunctionID,EmployeeID,MachineTableID,Comment")] AttendanceLog attendanceLog)
        {
            if (ModelState.IsValid)
            {
                db.AttendanceLogs.Add(attendanceLog);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.MachineTableID = new SelectList(db.AttMachineTableRefrences, "Id", "Id", attendanceLog.MachineTableID);
            ViewBag.EmployeeID = new SelectList(db.Employees, "EmployeeId", "ReferenceNumber", attendanceLog.EmployeeID);
            return View(attendanceLog);
        }

        // GET: AttendanceLogs/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            AttendanceLog attendanceLog = db.AttendanceLogs.Find(id);
            if (attendanceLog == null)
            {
                return HttpNotFound();
            }
            ViewBag.MachineTableID = new SelectList(db.AttMachineTableRefrences, "Id", "Id", attendanceLog.MachineTableID);
            ViewBag.EmployeeID = new SelectList(db.Employees, "EmployeeId", "ReferenceNumber", attendanceLog.EmployeeID);
            return View(attendanceLog);
        }

        // POST: AttendanceLogs/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "Id,Date,TimeIN,TimeOut,TimeFunction,FunctionID,EmployeeID,MachineTableID,Comment")] AttendanceLog attendanceLog)
        {
            if (ModelState.IsValid)
            {
                db.Entry(attendanceLog).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.MachineTableID = new SelectList(db.AttMachineTableRefrences, "Id", "Id", attendanceLog.MachineTableID);
            ViewBag.EmployeeID = new SelectList(db.Employees, "EmployeeId", "ReferenceNumber", attendanceLog.EmployeeID);
            return View(attendanceLog);
        }

        // GET: AttendanceLogs/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            AttendanceLog attendanceLog = db.AttendanceLogs.Find(id);
            if (attendanceLog == null)
            {
                return HttpNotFound();
            }
            return View(attendanceLog);
        }

        // POST: AttendanceLogs/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            AttendanceLog attendanceLog = db.AttendanceLogs.Find(id);
            db.AttendanceLogs.Remove(attendanceLog);
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
