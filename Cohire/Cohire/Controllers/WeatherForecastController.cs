using Cohire.Model.PostJob;
using Cohire.PostJobs.Model;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading.Tasks;

namespace Cohire.Controllers
{
    [ApiController]
    [Route("api/job")]
    public class WeatherForecastController : ControllerBase
    {
        private readonly ILogger<PostJobController> _logger;
        private readonly IHttpContextAccessor _httpContextAccessor;
        private readonly IWebHostEnvironment _webHostEnvironment;
        public WeatherForecastController(IWebHostEnvironment webHostEnvironment, ILogger<PostJobController> logger, IHttpContextAccessor httpContextAccessor)
        {
            _webHostEnvironment = webHostEnvironment;
            _logger = logger;
            _httpContextAccessor = httpContextAccessor;
        }
        [Route("getjobs")]
        [HttpPost]
        public IActionResult JobFeed()
        {
            return Ok();
        }

        [Route("getroles")]
        [HttpGet]
        public IActionResult GetRoles()
        {
            return Ok();
        }

        [Route("getskills")]
        [HttpGet]
        public IActionResult GetSkills(string prefix)
        {
            return Ok();
        }

        [Route("getquestions")]
        [HttpGet]
        public IActionResult GetQuestions(string prefix)
        {
            return Ok();
        }

        [Route("postjob")]
        [HttpPost]
        public async Task<IActionResult> PostJob([FromForm] PostJobModel postJobModel)
        {
            var host = _httpContextAccessor.HttpContext.Request;
            string URL = host.Scheme + "://" + host.Host.Value;
            Guid jobID = System.Guid.NewGuid();
            string ChJobID = "CHJ" + jobID.ToString().Substring(0, 6);
            ViewPostJobModel postJobviewModels = new ViewPostJobModel();
            postJobviewModels.JobId = jobID;
            postJobviewModels.ChJobID = ChJobID;
            postJobviewModels.RoleId = postJobModel.RoleId;
            postJobviewModels.PostedByID = postJobModel.PostedByID;
            postJobviewModels.JobDescription = postJobModel.JobDescription;
            List<string> result;
            if (!string.IsNullOrEmpty(postJobModel.JobQuestions))
            {
                result = new List<string>();
                string[] Questions = postJobModel.JobQuestions.Split(',');
                Questions.ToList().ForEach(x =>
                {
                    result.Add(x);
                });
                postJobviewModels.JobQuestions = result;
            }
            if (!string.IsNullOrEmpty(postJobModel.Skills))
            {
                result = new List<string>();
                string[] skills = postJobModel.Skills.Split(',');
                skills.ToList().ForEach(x =>
                {
                    result.Add(x);
                });
                postJobviewModels.Skills = result;
            }
            List<PostJobFiles> Filesresult = new List<PostJobFiles>();
            foreach (var file in postJobModel.JobFiles)
            {
                var uploadDirecotroy = "JobFiles\\";
                var uploadPath = Path.Combine(_webHostEnvironment.WebRootPath, uploadDirecotroy);
                if (!Directory.Exists(uploadPath))
                    Directory.CreateDirectory(uploadPath);
                var fileName = Guid.NewGuid() + Path.GetExtension(file.FileName);
                var filePath = Path.Combine(uploadPath, fileName);
                using (var stream = new FileStream(filePath, FileMode.Create))
                {
                    await file.CopyToAsync(stream);
                }
                Filesresult.Add(new PostJobFiles
                {
                    filetype = file.ContentType,
                    fileurl = URL + "/JobFiles/" + fileName,
                });
            }
            postJobviewModels.JobFiles = Filesresult;
            var json = JsonConvert.SerializeObject(postJobviewModels);
            string serachInstance = postJobModel.RoleId + "-" + postJobModel.Skills;
            var Is_insert = PostJobDB.Instance.CreateJobPublic(jobID.ToString(), ChJobID, postJobModel.PostedByID, json, serachInstance);
            return Ok(json);
        }
    }
}
