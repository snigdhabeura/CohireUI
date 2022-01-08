using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;

namespace Cohire.PostJobs.Model
{
    public class PostJobModel
    {
        public Guid ?JobId { get; set; }
        public string ChJobID { get; set; }
        public string PostedByID { get; set; }
        public string RoleId { get; set; }
        public string JobDescription { get; set; }  
        public string Skills { get; set; }
        public string JobQuestions{ get; set; }
        public List<IFormFile> JobFiles { get; set; }

    }


    public class ViewPostJobModel
    {
        public Guid? JobId { get; set; }
        public string ChJobID { get; set; }
        public string PostedByID { get; set; }
        public string RoleId { get; set; }
        public string JobDescription { get; set; }
        public List<string> Skills { get; set; }
        public List<string> JobQuestions { get; set; }
        public List<PostJobFiles> JobFiles { get; set; }

    }

    public class PostJobFiles
    {
        public string filetype { get; set;}
        public string fileurl { get; set; }
    }

}
