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
using System.IO;
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
        public IActionResult Index(string profileid)
        {
            ViewBag.ProfileName = Convert.ToString(Request.Cookies["Username"]);
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
            else if(!string.IsNullOrEmpty(Convert.ToString(profileid)))
            {
                try
                {
                    using (azureSQLDb = new SqlConnection(GetConnectionString.Instance.ReturnConnectionString()))
                    {
                        if (azureSQLDb.State == System.Data.ConnectionState.Closed)
                            azureSQLDb.Open();
                        cmd = new SqlCommand("Get_user_Profile_Json", azureSQLDb);
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add("@ProfileId", SqlDbType.VarChar).Value = Convert.ToString(profileid);
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
                            //Update company first
                            Is_companyFound.CompanyId = model.CompanyId;
                            Is_companyFound.CompanyName = model.CompanyName;
                            Is_companyFound.CompanyStartDate = model.CompanyStartDate;
                            Is_companyFound.CompanyEndDate = model.CompanyEndDate;
                            Is_companyFound.Is_currentCompany = model.Is_currentCompany;
                            //the update designation
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
                            if(success)
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
        public async Task<JsonResult> AddUpdateCertifications(Certifications model, IFormFile Attachments)
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
                    if(profilemodel.certifications!=null)
                    {
                        certifications.AddRange(profilemodel.certifications);
                    }
                    model.certificationid=Guid.NewGuid().ToString();
                    if(Attachments!=null)
                    {
                        var uploadDirecotroy = "ApplyJobResume\\";
                        var uploadPath = Path.Combine(_webHostEnvironment.WebRootPath, uploadDirecotroy);
                        if (!Directory.Exists(uploadPath))
                            Directory.CreateDirectory(uploadPath);
                        var fileName = Guid.NewGuid() + Path.GetExtension(Attachments.FileName);
                        var filePath = Path.Combine(uploadPath, fileName);
                        using (var stream = new FileStream(filePath, FileMode.Create))
                        {
                            Attachments.CopyTo(stream);
                        }
                        model.certiAttach = URL + "/ApplyJobResume/" + fileName;
                    }
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

        [HttpPost]
        public async Task<JsonResult> AddUpdateEducation(Education model)
        {
            ProfileModel profilemodel = new ProfileModel();
            List<Education> educations = new List<Education>();
            string jsonModel = string.Empty; var UserProfile = "1";
            try
            {
                var getprofileJson = GetProfileString();
                profilemodel = JsonConvert.DeserializeObject<ProfileModel>(getprofileJson.ToString());
                if (string.IsNullOrEmpty(model.educationid))
                {   if(profilemodel.education!=null)
                    {
                        educations.AddRange(profilemodel.education);
                    }
                    model.educationid = Guid.NewGuid().ToString();
                }
                else
                {
                    var getcertification = profilemodel.education.Where(x => x.educationid == model.educationid).FirstOrDefault();
                    profilemodel.education.Remove(getcertification);
                    educations.AddRange(profilemodel.education);
                }
                educations.Add(model);
                profilemodel.education = educations;
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
        public async Task<ActionResult> Deleteeducation(string id)
        {
            ProfileModel profilemodel = new ProfileModel();
            List<Education> education = new List<Education>();
            string jsonModel = string.Empty; var UserProfile = "1";
            try
            {
                var getprofileJson = GetProfileString();
                profilemodel = JsonConvert.DeserializeObject<ProfileModel>(getprofileJson.ToString());

                if (!string.IsNullOrEmpty(id))
                {
                    var getcertification = profilemodel.education.Where(x => x.educationid == id).FirstOrDefault();
                    profilemodel.education.Remove(getcertification);
                    education.AddRange(profilemodel.education);
                }
                profilemodel.education = education;
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

        [HttpPost]
        public async Task<JsonResult> InsertSkills(string skills)
        {
            var UserProfile = "1";
            try
            {
                ProfileModel profilemodel = new ProfileModel();
                List<Profileskills> skillmdoel = new List<Profileskills>();
                var getprofileJson = GetProfileString();
                string jsonModel = string.Empty; 
                profilemodel = JsonConvert.DeserializeObject<ProfileModel>(getprofileJson.ToString());
                if (!string.IsNullOrEmpty(skills))
                {
                    List<string> TagIds = skills.Split(',').Select(x => x).Distinct().ToList();
                    TagIds.ForEach(x =>
                    {
                        skillmdoel.Add(new Profileskills
                        {
                            id = Guid.NewGuid().ToString(),
                            selfrating = "0",
                            skill = x
                        });

                    });
                    if(profilemodel.skills!=null)
                    {
                        var getskills = profilemodel.skills.ToList();
                        getskills.AddRange(skillmdoel);
                        profilemodel.skills = getskills;
                    }
                    else
                    {
                        profilemodel.skills = skillmdoel;
                    }
                    jsonModel = JsonConvert.SerializeObject(profilemodel);
                    UserProfile = InsertProfileJsinstring(jsonModel);
                }
            }
            catch (Exception ex)
            {

                throw;
            }
            return new JsonResult(UserProfile);
        }

        [HttpGet]
        public async Task<ActionResult> DeleteSkills(string skill)
        {
            var UserProfile = "1";
            try
            {
                ProfileModel profilemodel = new ProfileModel();
                List<Profileskills> skillmdoel = new List<Profileskills>();
                var getprofileJson = GetProfileString();
                string jsonModel = string.Empty;
                profilemodel = JsonConvert.DeserializeObject<ProfileModel>(getprofileJson.ToString());
                if (!string.IsNullOrEmpty(skill))
                {
                    var getskills = profilemodel.skills.ToList();
                    getskills.Remove(getskills.Where(x=>x.id==skill).FirstOrDefault());
                    profilemodel.skills = getskills;
                    jsonModel = JsonConvert.SerializeObject(profilemodel);
                    UserProfile = InsertProfileJsinstring(jsonModel);
                }
            }
            catch (Exception ex)
            {

                throw;
            }
            return RedirectToAction("Index", "Profile");
        }
        [HttpPost]
        public async Task<JsonResult> UpdateSkillSelfrating(string skill, string count)
        {
            var UserProfile = "1";
            try
            {
                ProfileModel profilemodel = new ProfileModel();
                Profileskills skillmdoel = new Profileskills();
                var getprofileJson = GetProfileString();
                string jsonModel = string.Empty;
                profilemodel = JsonConvert.DeserializeObject<ProfileModel>(getprofileJson.ToString());
                if (!string.IsNullOrEmpty(skill))
                {
                    if (profilemodel.skills != null)
                    {
                        var getskills = profilemodel.skills.ToList();
                        var removeskills = getskills.Where(x => x.id == skill).FirstOrDefault();

                        skillmdoel.id = Guid.NewGuid().ToString();
                        skillmdoel.skill = removeskills.skill;
                        skillmdoel.selfrating = count;

                        getskills.Remove(removeskills);
                        getskills.Add(skillmdoel);
                        profilemodel.skills = getskills;
                    }
                    else
                    {
                        List<Profileskills>skillmdoellist = new List<Profileskills>();
                        skillmdoellist.Add(skillmdoel);
                        profilemodel.skills = skillmdoellist;
                    }
                    jsonModel = JsonConvert.SerializeObject(profilemodel);
                    UserProfile = InsertProfileJsinstring(jsonModel);
                }
            }
            catch (Exception ex)
            {

                throw;
            }
            return new JsonResult(UserProfile);
        }
        [HttpPost]
        public async Task<JsonResult> Insertlanguages(string langugae,string rating)
        {
            var UserProfile = "1";
            try
            {
                ProfileModel profilemodel = new ProfileModel();
                List<Language> skillmdoel = new List<Language>();
                var getprofileJson = GetProfileString();
                string jsonModel = string.Empty;
                profilemodel = JsonConvert.DeserializeObject<ProfileModel>(getprofileJson.ToString());
                if (!string.IsNullOrEmpty(langugae) && !string.IsNullOrEmpty(rating))
                {
                    
                    if (profilemodel.languages != null)
                    {
                        if(profilemodel.languages.Count()>0)
                        {
                            var getskills = profilemodel.languages.ToList();
                            var deletlang = getskills.Where(x => x.language == langugae).FirstOrDefault();
                            if (deletlang != null)
                            {
                                skillmdoel.Add(new Language
                                {
                                    language = langugae,
                                    selfrating = rating
                                });
                                getskills.AddRange(skillmdoel);
                                profilemodel.languages = getskills;
                            }
                            else
                            {
                                getskills.Remove(deletlang);
                                skillmdoel.Add(new Language
                                {
                                    language = langugae,
                                    selfrating = rating
                                });
                                getskills.AddRange(skillmdoel);
                                profilemodel.languages = getskills;
                            }
                        }
                        else
                        {
                            skillmdoel.Add(new Language
                            {
                                language = langugae,
                                selfrating = rating
                            });
                            profilemodel.languages = skillmdoel;
                        }

                    }
                    else
                    {
                        profilemodel.languages = skillmdoel;
                    }
                    jsonModel = JsonConvert.SerializeObject(profilemodel);
                    UserProfile = InsertProfileJsinstring(jsonModel);
                }
            }
            catch (Exception ex)
            {

                throw;
            }
            return new JsonResult(UserProfile);
        }

        [HttpPost]
        public async Task<JsonResult> Deletelanguage(string skill)
        {
            var UserProfile = "1";
            try
            {
                ProfileModel profilemodel = new ProfileModel();
                List<Profileskills> skillmdoel = new List<Profileskills>();
                var getprofileJson = GetProfileString();
                string jsonModel = string.Empty;
                profilemodel = JsonConvert.DeserializeObject<ProfileModel>(getprofileJson.ToString());
                if (!string.IsNullOrEmpty(skill))
                {
                    var getskills = profilemodel.languages.ToList();
                    getskills.Remove(getskills.Where(x => x.language == skill).FirstOrDefault());
                    profilemodel.languages = getskills;
                    jsonModel = JsonConvert.SerializeObject(profilemodel);
                    UserProfile = InsertProfileJsinstring(jsonModel);
                }
            }
            catch (Exception ex)
            {

                throw;
            }
            return new JsonResult(UserProfile);
        }

        [HttpPost]
        public async Task<JsonResult> InsertAboutProfile(string message)
        {
            var UserProfile = "1";
            try
            {
                ProfileModel profilemodel = new ProfileModel();
                List<Language> skillmdoel = new List<Language>();
                var getprofileJson = GetProfileString();
                string jsonModel = string.Empty;
                profilemodel = JsonConvert.DeserializeObject<ProfileModel>(getprofileJson.ToString());
                if (!string.IsNullOrEmpty(message))
                {
                    profilemodel.AboutProfile = message;
                    jsonModel = JsonConvert.SerializeObject(profilemodel);
                    UserProfile = InsertProfileJsinstring(jsonModel);
                }
            }
            catch (Exception ex)
            {

                throw;
            }
            return new JsonResult(UserProfile);
        }

        public class chartpoint
        {
            public int y { get; set; }
            public string label { get; set; }
        }
        [HttpPost]
        public async Task<JsonResult>LoadChartData()
        {
            List<chartpoint> chartpoints = new List<chartpoint>();
            ProfileModel profilemodel = new ProfileModel();
            var getprofileJson = GetProfileString();
            profilemodel = JsonConvert.DeserializeObject<ProfileModel>(getprofileJson.ToString());
            int count = 0;
            if (profilemodel!=null)
            {
                if(profilemodel.education!=null)
                {
                    if(profilemodel.education.Count>0)
                    {
                        foreach(var v in profilemodel.education)
                        {
                            
                            chartpoints.Add(new chartpoint {y=count, label=v.degreename+"-"+v.universityname });
                            count++;
                        }
                        
                    }
                }
                if (profilemodel.WorkExperience != null)
                {
                    if (profilemodel.WorkExperience.Count > 0)
                    {
                        foreach (var v in profilemodel.WorkExperience)
                        {

                            foreach(var ex in v.designatioexp)
                            {
                                count++;
                                chartpoints.Add(new chartpoint { y = count, label =v.CompanyName+" - "+ex.DesignationName+" - "+ ex.EmploymentTypeName });

                            }
                        }

                    }
                }
            }

            return new JsonResult(chartpoints);
        }
    }
}
