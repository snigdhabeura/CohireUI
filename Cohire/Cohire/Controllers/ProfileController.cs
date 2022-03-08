using Cohire.Models.CommonOperation;
using Cohire.Models.Profile;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;

namespace Cohire.Controllers
{
    public class ProfileController : Controller
    {
        private IWebHostEnvironment Environment;
        private ILogger<PostJobController> _logger;
        private IWebHostEnvironment _webHostEnvironment;
        private readonly IHttpContextAccessor _httpContextAccessor;
        string URL = string.Empty;
        private object hostingEnvironment;

        public ProfileController(IWebHostEnvironment _environment, ILogger<PostJobController> logger, IWebHostEnvironment webhttpContextAccessor, IHttpContextAccessor httpContextAccessor)
        {
            Environment = _environment;
            _logger = logger;
            _webHostEnvironment = webhttpContextAccessor;
            _httpContextAccessor = httpContextAccessor;
            var host = _httpContextAccessor.HttpContext.Request;
            URL = host.Scheme + "://" + host.Host.Value;
        }
        public IActionResult Index()
        {
            SqlConnection azureSQLDb = null;
            SqlCommand cmd;
            ProfileModelList profilemodel = new ProfileModelList();
            if (!string.IsNullOrEmpty(Convert.ToString(Request.Cookies["UserID"])))
            {
                try
                {
                    using (azureSQLDb = new SqlConnection(GetConnectionString.Instance.ReturnConnectionString()))
                    {
                        if (azureSQLDb.State == System.Data.ConnectionState.Closed)
                            azureSQLDb.Open();
                        cmd = new SqlCommand("Get_user_Profile_Json", azureSQLDb);
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add("@ProfileId", SqlDbType.VarChar).Value = Convert.ToString(Request.Cookies["UserID"]);
                        var getuserProfileJson = cmd.ExecuteScalar().ToString();
                        if (!String.IsNullOrEmpty(getuserProfileJson))
                        {

                            profilemodel = JsonConvert.DeserializeObject<ProfileModelList>(getuserProfileJson.ToString());
                        }
                    }
                }
                catch (Exception ex)
                {
                    throw;
                }
                finally { azureSQLDb.Close(); }
                return View(profilemodel);
            }
            else
            {
                return RedirectToAction("Index", "Home");
            }
            
        }

        [HttpGet]
        public async Task<JsonResult> GetCompany()
        {
            var data = await ProfileDB.Instance.GetCompanyNames();
            return new JsonResult(data);
        }

        [HttpPost]
        public async Task<JsonResult>AddUpdateWorkExp(WorkExperienceRequest model)
        {
            SqlConnection azureSQLDb = null;
            SqlCommand cmd;
            ProfileModel profilemodel = new ProfileModel();
            List<WorkExperience> workExperience = new List<WorkExperience>();
            Designatioexp designatioexpreq = new Designatioexp();
            List<Designatioexp> designatioexpreqlist = new List<Designatioexp>();
            string jsonModel = string.Empty; var UserProfile = "1";
            try
            {
                    var getuserProfileJson = GetProfileString();

                    designatioexpreq.DesignationId = model.DesignationId;
                    designatioexpreq.DesignationName = model.DesignationName;
                    designatioexpreq.DesignationStartDate = model.DesignationStartDate;
                    designatioexpreq.DesignationEndDate = model.DesignationEndDate;
                    designatioexpreq.Is_currentDesignation = model.Is_currentDesignation;
                    designatioexpreq.EmploymentType = model.EmploymentType;
                    designatioexpreq.EmploymentTypeName = model.EmploymentTypeName;
                    designatioexpreq.JobProfile = model.JobProfile;
                  
                    if (!String.IsNullOrEmpty(getuserProfileJson))
                    {
                        
                           profilemodel = JsonConvert.DeserializeObject<ProfileModel>(getuserProfileJson.ToString());

                        workExperience = profilemodel.WorkExperience;
                        var Is_companyFound = profilemodel.WorkExperience.Where(x => x.CompanyId == model.CompanyId).FirstOrDefault();
                        if (Is_companyFound!=null)
                        {
                            var Is_desgnationFound = Is_companyFound.designatioexp.Where(x => x.DesignationId == model.DesignationId).FirstOrDefault();
                            if (Is_desgnationFound != null)
                            {
                                workExperience.Where(x => x.CompanyId == model.CompanyId).Select(x => x.designatioexp).FirstOrDefault().Remove(Is_desgnationFound);
                            }
                            workExperience.Where(x => x.CompanyId == model.CompanyId).FirstOrDefault().designatioexp.Add(designatioexpreq);
                        }
                        else
                        {
                            designatioexpreqlist.Add(designatioexpreq);
                            workExperience.Add(new WorkExperience 
                            {

                                CompanyId =model.CompanyId,
                                CompanyName = model.CompanyName,
                                CompanyStartDate = model.CompanyStartDate,
                                CompanyEndDate = model.CompanyEndDate,
                                Is_currentCompany = model.Is_currentCompany,
                                designatioexp= designatioexpreqlist,
                            });
                        }
                    }
                    else
                    {
                        designatioexpreqlist.Add(designatioexpreq);
                        workExperience.Add(new WorkExperience
                        {

                            CompanyId = model.CompanyId,
                            CompanyName = model.CompanyName,
                            CompanyStartDate = model.CompanyStartDate,
                            CompanyEndDate = model.CompanyEndDate,
                            Is_currentCompany = model.Is_currentCompany,
                            designatioexp = designatioexpreqlist,
                        });
                    }
                    profilemodel.WorkExperience = workExperience;
                    jsonModel =JsonConvert.SerializeObject(profilemodel);
                    UserProfile=InsertProfileJsinstring(jsonModel);
            }
            catch (Exception ex)
            {
                throw;
            }
            return new JsonResult(UserProfile);
        }

        [HttpGet]
        public async Task<ActionResult> DeleteWorkExp(string com,string exp)
        {
            SqlConnection azureSQLDb = null;
            SqlCommand cmd;
            ProfileModel profilemodel = new ProfileModel();
            List<WorkExperience> workExperience = new List<WorkExperience>();
            Designatioexp designatioexpreq = new Designatioexp();
            List<Designatioexp> designatioexpreqlist = new List<Designatioexp>();
            string jsonModel = string.Empty; var UserProfile = "1";
            try
            {
                if(!string.IsNullOrEmpty(com)||!string.IsNullOrEmpty(exp))
                {
                    using (azureSQLDb = new SqlConnection(GetConnectionString.Instance.ReturnConnectionString()))
                    {
                            int company;
                            bool success = int.TryParse(com, out company);
                            if(success && company != 0)
                            {
                                if (azureSQLDb.State == System.Data.ConnectionState.Closed)
                                    azureSQLDb.Open();
                                cmd = new SqlCommand("Get_user_Profile_Json", azureSQLDb);
                                cmd.CommandType = CommandType.StoredProcedure;
                                cmd.Parameters.Add("@ProfileId", SqlDbType.VarChar).Value = Convert.ToString(Request.Cookies["UserID"]);
                                var getuserProfileJson = cmd.ExecuteScalar().ToString();
                                profilemodel = JsonConvert.DeserializeObject<ProfileModel>(getuserProfileJson.ToString());
                                workExperience = profilemodel.WorkExperience;
                                var Is_companyFound = profilemodel.WorkExperience.Where(x => x.CompanyId == company).FirstOrDefault();
                                if(!string.IsNullOrEmpty(exp))
                                {
                                    int experiece;
                                    bool issuccess = int.TryParse(exp, out experiece);
                                    if(issuccess && experiece!=0)
                                    {
                                        var Is_desgnationFound = Is_companyFound.designatioexp.Where(x => x.DesignationId == experiece).FirstOrDefault();
                                        if (Is_desgnationFound != null)
                                        {
                                            workExperience.Where(x => x.CompanyId == company).Select(x => x.designatioexp).FirstOrDefault().Remove(Is_desgnationFound);
                                        }
                                    }
                                }
                                else
                                {
                                    workExperience.Remove(Is_companyFound);
                                }
                            profilemodel.WorkExperience = workExperience;
                            jsonModel = JsonConvert.SerializeObject(profilemodel);
                            cmd = new SqlCommand("Insert_user_Profile_Json", azureSQLDb);
                            cmd.CommandType = CommandType.StoredProcedure;
                            cmd.Parameters.Add("@ProfileId", SqlDbType.VarChar).Value = Convert.ToString(Request.Cookies["UserID"]);
                            cmd.Parameters.Add("@Profilejson", SqlDbType.VarChar).Value = jsonModel;
                            UserProfile = cmd.ExecuteScalar().ToString();
                        }
                            
                        
                        

                    }
                }
            }
            catch (Exception ex)
            {
                throw;
            }
            finally { azureSQLDb.Close(); }
            return RedirectToAction("Index", "Profile");
        }

        [HttpPost]
        public async Task<JsonResult> AddUpdateCertifications(Certifications model)
        {
            ProfileModel profilemodel = new ProfileModel();
            List<Certifications> certifications = new List<Certifications>();
            string jsonModel = string.Empty; var UserProfile = "1";
            try
            {
                var getprofileJson= GetProfileString();
                profilemodel = JsonConvert.DeserializeObject<ProfileModel>(getprofileJson.ToString());
                if (string.IsNullOrEmpty(model.certificationid))
                {
                    certifications.AddRange(profilemodel.certifications);
                    model.certificationid=Guid.NewGuid().ToString();
                }
                else
                {
                    var getcertification= profilemodel.certifications.Where(x=>x.certificationid==model.certificationid).FirstOrDefault();
                    profilemodel.certifications.Remove(getcertification);
                    certifications.AddRange(profilemodel.certifications);
                }
                certifications.Add(model);
                profilemodel.certifications= certifications;
                jsonModel = JsonConvert.SerializeObject(profilemodel);
                UserProfile = InsertProfileJsinstring(jsonModel);
            }
            catch (Exception ex)
            {
                throw;
            }
            return new JsonResult(UserProfile);
        }

        [HttpGet]
        public async Task<ActionResult> DeleteCertifications(string id)
        {
            ProfileModel profilemodel = new ProfileModel();
            List<Certifications> certifications = new List<Certifications>();
            string jsonModel = string.Empty; var UserProfile = "1";
            try
            {
                var getprofileJson = GetProfileString();
                profilemodel = JsonConvert.DeserializeObject<ProfileModel>(getprofileJson.ToString());
                
                if (!string.IsNullOrEmpty(id))
                {
                    var getcertification = profilemodel.certifications.Where(x => x.certificationid == id).FirstOrDefault();
                    profilemodel.certifications.Remove(getcertification);
                    certifications.AddRange(profilemodel.certifications);
                }
                profilemodel.certifications = certifications;
                jsonModel = JsonConvert.SerializeObject(profilemodel);
                UserProfile = InsertProfileJsinstring(jsonModel);
            }
            catch (Exception ex)
            {
                throw;
            }
            return RedirectToAction("Index", "Profile");
        }
        public string GetProfileString()
        {
            SqlConnection azureSQLDb = null;
            SqlCommand cmd;
            string getuserProfileJson=string.Empty;
            try
            {

                using (azureSQLDb = new SqlConnection(GetConnectionString.Instance.ReturnConnectionString()))
                {
                    if (azureSQLDb.State == System.Data.ConnectionState.Closed)
                        azureSQLDb.Open();
                    cmd = new SqlCommand("Get_user_Profile_Json", azureSQLDb);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@ProfileId", SqlDbType.VarChar).Value = Convert.ToString(Request.Cookies["UserID"]);
                    getuserProfileJson = cmd.ExecuteScalar().ToString();

                }
            }
            catch (Exception ex)
            {
                throw;
            }
            finally { azureSQLDb.Close(); }return getuserProfileJson;
        }
        public string InsertProfileJsinstring(string jsonModel)
        {
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
                    cmd.Parameters.Add("@ProfileId", SqlDbType.VarChar).Value = Convert.ToString(Request.Cookies["UserID"]);
                    cmd.Parameters.Add("@Profilejson", SqlDbType.VarChar).Value = jsonModel;
                    Is_profileUpdate = cmd.ExecuteScalar().ToString();

                }
            }
            catch (Exception ex)
            {
                throw;
            }
            finally { azureSQLDb.Close(); }
            return Is_profileUpdate;
        }
    }
}
