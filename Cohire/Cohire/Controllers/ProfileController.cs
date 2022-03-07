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
                
                using (azureSQLDb = new SqlConnection(GetConnectionString.Instance.ReturnConnectionString()))
                {
                    if (azureSQLDb.State == System.Data.ConnectionState.Closed)
                        azureSQLDb.Open();
                    cmd = new SqlCommand("Get_user_Profile_Json", azureSQLDb);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@ProfileId", SqlDbType.VarChar).Value = Convert.ToString(Request.Cookies["UserID"]);
                    var getuserProfileJson = cmd.ExecuteScalar().ToString();

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
                    cmd = new SqlCommand("Insert_user_Profile_Json", azureSQLDb);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@ProfileId", SqlDbType.VarChar).Value = Convert.ToString(Request.Cookies["UserID"]);
                    cmd.Parameters.Add("@Profilejson", SqlDbType.VarChar).Value = jsonModel;
                    UserProfile = cmd.ExecuteScalar().ToString();

                }
            }
            catch (Exception ex)
            {
                throw;
            }
            finally { azureSQLDb.Close(); }
            return new JsonResult(UserProfile);
        }
    }
}
