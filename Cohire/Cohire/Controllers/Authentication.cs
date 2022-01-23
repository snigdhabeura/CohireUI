using Cohire.Models.CommonOperation;
using Cohire.Models.UserAuthentication;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Cohire.Controllers
{
    public class Authentication : Controller
    {
        public IActionResult Index()
        {
            return View();
        }
        
        [HttpGet]
        public IActionResult SignUp(string id="")
        {
            ViewBag.ID = id;
            return View();
        }

        [HttpPost]
        public JsonResult SignUp(SigupModel sigupModel)
        {
            Sigupresponse sigupresponse = new Sigupresponse();
            CommonOP commonOP = new CommonOP();
            try
            {
                Guid jobID = System.Guid.NewGuid();
                string OTP = "VF" + jobID.ToString().Substring(0, 4);
                string ProfileID = "CHPF" + jobID.ToString().Substring(0, 4);
                sigupresponse.ProfileID = ProfileID;
                sigupresponse.Is_error = false;
                string message = "";
                if (!string.IsNullOrEmpty(sigupModel.Email))
                {
                    message = "Your verififcation OTP:<b>" + OTP + "</b>";
                       var response = commonOP.SendEmail(sigupModel.Email, "SignupOTP", message);
                    if(response!=true)
                    {
                        sigupresponse.Is_error = true;
                        sigupresponse.errormsg = "OTP can't send to your email";
                    }
                }
                if(!string.IsNullOrEmpty(sigupModel.Mobile))
                {
                    message = "Hi, Your verififcation OTP : " + OTP + "";
                    var response= commonOP.sendSMS("Hi, Your verififcation OTP : " + OTP + "", sigupModel.Mobile);
                    if (response.status == "failure")
                    {
                        sigupresponse.Is_error = true;
                        sigupresponse.errormsg = "OTP can't send to your mobile number";
                    }
                }
                if(sigupresponse.Is_error==false)
                {
                   var data= UserAuthentication.Instance.UserRegistarionAsync(ProfileID, sigupModel.FullName, sigupModel.Email, sigupModel.Mobile, OTP, sigupModel.Password, message);
                }
            }
            catch (Exception ex)
            {
                sigupresponse.Is_error = true;
                sigupresponse.id = "";
                sigupresponse.errormsg = "Something went wrong, Please try again later!!!!";
            }
            return Json(sigupresponse);
        }

        [HttpPost]
        public JsonResult ResenOTP(SigupModel sigupModel)
        {
            Sigupresponse sigupresponse = new Sigupresponse();
            CommonOP commonOP = new CommonOP();
            try
            {
                var data = UserAuthentication.Instance.ResendOTPAsync(sigupModel.CHProfileID,"");
                sigupresponse.Is_error = false;
                if (!string.IsNullOrEmpty(data.Result.Email))
                {
                   
                    var response = commonOP.SendEmail(sigupModel.Email, "SignupOTP", data.Result.OTP_Message);
                    if (response != true)
                    {
                        sigupresponse.Is_error = true;
                        sigupresponse.errormsg = "OTP can't send to your email";
                    }
                }
                if (!string.IsNullOrEmpty(data.Result.Mobile))
                {
                    
                    var response = commonOP.sendSMS("Hi, Your verififcation OTP : " + data.Result.OTP_Message + "", sigupModel.Mobile);
                    if (response.status == "failure")
                    {
                        sigupresponse.Is_error = true;
                        sigupresponse.errormsg = "OTP can't send to your mobile number";
                    }
                }
            }
            catch (Exception ex)
            {
                sigupresponse.Is_error = true;
                sigupresponse.id = "";
                sigupresponse.errormsg = "Something went wrong, Please try again later!!!!";
            }
            return Json(sigupresponse);
        }

        [HttpPost]
        public JsonResult VerifyOTP(SigupModel sigupModel)
        {
            Sigupresponse sigupresponse = new Sigupresponse();
            CommonOP commonOP = new CommonOP();
            try
            {
                var data = UserAuthentication.Instance.ResendOTPAsync(sigupModel.CHProfileID, sigupModel.OTP);
                
                if(data.Result!=null)
                {
                    sigupresponse.errormsg = "OTP verified";
                    sigupresponse.Is_error = false;
                    CookieOptions options = new CookieOptions();
                    options.Expires = DateTime.Now.AddHours(1);
                    Response.Cookies.Append("UserID", data.Result.CHProfileID);
                    Response.Cookies.Append("Username", data.Result.FullName);
                }
                else
                {
                    sigupresponse.errormsg = "Please enter the correct OTP";
                    sigupresponse.Is_error = true;
                }
            }
            catch (Exception ex)
            {
                sigupresponse.Is_error = true;
                sigupresponse.id = "";
                sigupresponse.errormsg = "Something went wrong, Please try again later!!!!";
            }
            return Json(sigupresponse);
        }
        [HttpGet]
        public IActionResult SignOut()
        {
            Response.Cookies.Delete("UserID");
            Response.Cookies.Delete("Username");
            return RedirectToAction("SignUp");
        }
       
        [HttpPost]
        public ActionResult SignIn(SigupModel sigupModel)
        {
           
            var data = UserAuthentication.Instance.Login(sigupModel.Email, sigupModel.Password);
            if(data!=null)
            {
                Response.Cookies.Delete("UserID");
                Response.Cookies.Delete("Username");
                CookieOptions options = new CookieOptions();
                options.Expires = DateTime.Now.AddHours(1);
                Response.Cookies.Append("UserID", data.Result.CHProfileID);
                Response.Cookies.Append("Username", data.Result.FullName);
                return RedirectToAction("ProfilePage");
            }
            else
            {
                return RedirectToAction("SignUp", new { id = "" });
            }
            
        }

        [HttpGet]
        public IActionResult ProfilePage()
        {
            return View();
        }
    }
}

