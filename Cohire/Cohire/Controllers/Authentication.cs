using Cohire.Models.CommonOperation;
using Cohire.Models.Profile;
using Cohire.Models.UserAuthentication;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;

namespace Cohire.Controllers
{
    public class Authentication : Controller
    {
        private readonly IHttpContextAccessor _httpContextAccessor;

        public Authentication(IHttpContextAccessor httpContextAccessor)
        {
            this._httpContextAccessor = httpContextAccessor;
        }
        public IActionResult Index()
        {
            return View();
        }
        
        [HttpPost]
        public JsonResult SignUp(SigupModel sigupModel)
        {
            ProfileModel mdoel = new ProfileModel();
               Sigupresponse sigupresponse = new Sigupresponse();
            ProfileGeneraldetails profilemodel = new ProfileGeneraldetails();
            try
            {
                sigupModel.Ip_Address = CommonOP.Instance.GetUserIP();
                Guid jobID = System.Guid.NewGuid();
                string OTP = "VF" + jobID.ToString().Substring(0, 4);
                string ProfileID = "CHPF" + jobID.ToString().Substring(0, 4);
                sigupresponse.ProfileID = ProfileID;
                sigupresponse.Is_error = false;
                string message = "";

                if (!string.IsNullOrEmpty(sigupModel.Email))
                {
                    message = "Your verififcation OTP: <b>" + OTP + "</b>";
                    if (sigupresponse.Is_error == false)
                    {
                        profilemodel.profileid = ProfileID;
                        profilemodel.name = sigupModel.FullName;
                        profilemodel.email = sigupModel.Email;
                        profilemodel.mobilenumber = sigupModel.Mobile;
                        profilemodel.image = "noprofilr.png";
                        mdoel.profilegeneral = profilemodel;
                           var data = UserAuthentication.Instance.UserRegistarionAsync(ProfileID, sigupModel.FullName, sigupModel.Email, sigupModel.Mobile, OTP, sigupModel.Password, message, sigupModel.Ip_Address, sigupModel.DeviceType);
                        if(data.Result.ToString()=="-1")
                        {
                            sigupresponse.Is_error = true;
                            sigupresponse.errormsg = "Email already exist!!";
                        }
                        else if(data.Result.ToString() == "")
                        {
                            sigupresponse.Is_error = true;
                            sigupresponse.errormsg = "Something went wrong,please try agian";
                        }
                        else
                        {
                            var response = CommonOP.Instance.SendEmailGoDady(sigupModel.Email, "SignupOTP", message);
                            if (response != true)
                            {
                                sigupresponse.Is_error = true;
                                sigupresponse.errormsg = "OTP can't send to your email";
                            }
                            else
                            {
                                InsertProfileJson(mdoel, ProfileID);
                                sigupresponse.errormsg = "OTP has been sent to your email";
                            }
                        }
                    }
                    
                }
                else if(!string.IsNullOrEmpty(sigupModel.Mobile))
                {
                    message = "Hi, Your verififcation OTP : " + OTP + "";
                    if (sigupresponse.Is_error == false)
                    {
                        profilemodel.profileid = ProfileID;
                        profilemodel.name = sigupModel.FullName;
                        profilemodel.email = sigupModel.Email;
                        profilemodel.mobilenumber = sigupModel.Mobile;
                        profilemodel.image = "noprofilr.png";
                        mdoel.profilegeneral = profilemodel;

                        var data = UserAuthentication.Instance.UserRegistarionAsync(ProfileID, sigupModel.FullName, sigupModel.Email, sigupModel.Mobile, OTP, sigupModel.Password, message, sigupModel.Ip_Address, sigupModel.DeviceType);
                        if (data.Result.ToString() == "-1")
                        {
                            sigupresponse.Is_error = true;
                            sigupresponse.errormsg = "Mobile number already exist!!";
                        }
                        else if (data.Result.ToString() == "")
                        {
                            sigupresponse.Is_error = true;
                            sigupresponse.errormsg = "Something went wrong,please try agian";
                        }
                        else
                        {
                            var response = CommonOP.Instance.sendSMS("Your verififcation OTP: " + OTP + "", sigupModel.Mobile);
                            if (response.status == "failure")
                            {
                                sigupresponse.Is_error = true;
                                sigupresponse.errormsg = "OTP can't send to your mobile";
                            }
                            else
                            {
                                InsertProfileJson(mdoel, ProfileID);
                                sigupresponse.errormsg = "OTP has been sent to your mobile";
                            }
                        }
                    }
                    
                }
                else
                {
                    sigupresponse.Is_error = true;
                    sigupresponse.errormsg = "Something went wrong,please try agian";
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
                if(data!=null)
                {
                    if (!string.IsNullOrEmpty(data.Result.Email))
                    {

                        var response = commonOP.SendEmailGoDady(data.Result.Email, "SignupOTP", data.Result.OTP_Message);
                        if (response != true)
                        {
                            sigupresponse.Is_error = true;
                            sigupresponse.errormsg = "OTP can't send to your email";
                        }
                    }
                    if (!string.IsNullOrEmpty(data.Result.Mobile))
                    {

                        var response = commonOP.sendSMS("Hi, Your verififcation OTP : " + data.Result.OTP_Message + "", data.Result.Mobile);
                        if (response.status == "failure")
                        {
                            sigupresponse.Is_error = true;
                            sigupresponse.errormsg = "OTP can't send to your mobile number";
                        }
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
            return RedirectToAction("Index", "Home");
        }
       
        [HttpPost]
        public JsonResult SignIn(SigupModel sigupModel)
        {
            sigupModel.Ip_Address = CommonOP.Instance.GetUserIP();
            CommonOP.Instance.GetUserIP();
            var data = UserAuthentication.Instance.Login(sigupModel.Email, sigupModel.Password, sigupModel.Mobile, sigupModel.Ip_Address, sigupModel.DeviceType);
            if(data.Result!=null)
            {
                Response.Cookies.Delete("UserID");
                Response.Cookies.Delete("Username");
                CookieOptions options = new CookieOptions();
                options.Expires = DateTime.Now.AddHours(1);
                Response.Cookies.Append("UserID", data.Result.CHProfileID);
                Response.Cookies.Append("Username", data.Result.FullName);
                return Json(data.Result);
            }
            else
            {
                return Json("0");
            }
            
        }

        [HttpGet]
        public IActionResult ProfilePage()
        {
            return View();
        }

        [HttpPost]
        public JsonResult SendPassword(string Email,string Password)
        {
            return Json(UserAuthentication.Instance.SendTempPassword(Email, Password).Result);
        }
        [HttpGet]
        public List<string> GetCurrentCookie()
        {
            List<string> cookies = new List<string>();
            cookies.Add(Convert.ToString(_httpContextAccessor.HttpContext.Request.Cookies["Username"]));
            cookies.Add(Convert.ToString(_httpContextAccessor.HttpContext.Request.Cookies["UserID"]));
            return cookies;
        }

        public void InsertProfileJson(ProfileModel profilemodel,string ProfileId)
        {
           string jsonModel = JsonConvert.SerializeObject(profilemodel);
            SqlConnection azureSQLDb = null;
            SqlCommand cmd;
            string Is_profileUpdate = string.Empty;
            try
            {

                using (azureSQLDb = new SqlConnection(GetConnectionString.Instance.ReturnConnectionString()))
                {
                    if (azureSQLDb.State == System.Data.ConnectionState.Closed)
                        azureSQLDb.Open();
                    cmd = new SqlCommand("Insert_user_Profile_Json", azureSQLDb);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@ProfileId", SqlDbType.VarChar).Value = ProfileId;
                    cmd.Parameters.Add("@Profilejson", SqlDbType.VarChar).Value = jsonModel;
                    Is_profileUpdate = cmd.ExecuteScalar().ToString();

                }
            }
            catch (Exception ex)
            {
                throw;
            }
            finally { azureSQLDb.Close(); }
        }
    }
}

