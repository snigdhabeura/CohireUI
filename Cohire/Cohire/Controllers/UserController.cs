using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Cohire.Model.PostJob;
using CohireAPI.PostJobs.Model;
using System.Net;
using System.Text;
using System.Web;
using System.Net.Http;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Logging;
using Microsoft.AspNetCore.Http;


namespace Cohire.Controllers
{
    public class UserController : Controller
    {
        private IWebHostEnvironment Environment;
        private ILogger<PostJobController> _logger;
        private  IWebHostEnvironment _webHostEnvironment;


        public UserController(IWebHostEnvironment _environment, ILogger<PostJobController> logger, IWebHostEnvironment httpContextAccessor)
        {
            Environment = _environment;
            _logger = logger;
            _webHostEnvironment = httpContextAccessor;
        }
        public IActionResult Index()
        {
            return View("UserHome");
        }

        [HttpPost]
        public IActionResult Index(PostJobModel postModel)
        {

            var listOfFiles = new PostJobController(Environment, _logger, null).PostJob(postModel);

           
            ViewBag.Msg = "Ok";
            return View("UserHome", postModel);
        }

        public IActionResult SignIn()
        {
            ViewBag.SignIn = "SignIn";
            return View("UserHome");
        }
    }
}
